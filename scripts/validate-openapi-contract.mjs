import { readFile } from 'node:fs/promises';
import { pathToFileURL } from 'node:url';

import { parse } from 'yaml';

const HTTP_METHODS = new Set(['get', 'post', 'put', 'patch', 'delete', 'head', 'options', 'trace']);
const FINANCIAL_COMMANDS = [
  ['post', /^\/v1\/orders(?:\/preview)?$/],
  ['delete', /^\/v1\/orders\/\{[^}]+\}$/],
  ['post', /^\/v1\/orders\/\{[^}]+\}\/wallet-actions\/\{[^}]+\}\/complete$/],
  ['post', /^\/v1\/hip3\/agent\/challenges(?:\/\{[^}]+\}\/complete)?$/],
  ['post', /^\/v1\/funding\/plans$/],
  ['post', /^\/v1\/deposits$/],
  ['post', /^\/v1\/transfers(?:\/\{[^}]+\}\/claims)?$/],
  ['post', /^\/v1\/withdrawal-quotes$/],
  ['post', /^\/v1\/withdrawals$/],
  ['post', /^\/v1\/me\/wallets\/(?:sync|\{[^}]+\}\/authorizations)$/],
  ['post', /^\/v1\/positions\/\{[^}]+\}\/close$/],
  ['put', /^\/v1\/positions\/\{[^}]+\}\/tpsl$/],
  ['delete', /^\/v1\/positions\/\{[^}]+\}\/tpsl$/],
  ['patch', /^\/v1\/positions\/\{[^}]+\}\/leverage$/],
];

const FORBIDDEN_REQUEST_FIELDS = new Set([
  'accountid',
  'provider',
  'providerid',
  'providerorderid',
  'venueorderid',
  'exchangeorderid',
  'externalorderid',
  'status',
  'state',
  'createdat',
  'updatedat',
  'completedat',
  'failedat',
  'failureat',
  'txhash',
  'transactionhash',
  'confirmations',
  'creditedat',
]);

function visit(node, visitor, pointer = '#', seen = new Set()) {
  if (node === null || typeof node !== 'object' || seen.has(node)) return;
  seen.add(node);
  visitor(node, pointer);
  for (const [key, value] of Object.entries(node)) {
    visit(value, visitor, `${pointer}/${escapePointer(key)}`, seen);
  }
}

function escapePointer(value) {
  return value.replaceAll('~', '~0').replaceAll('/', '~1');
}

function decodePointer(value) {
  return value.replaceAll('~1', '/').replaceAll('~0', '~');
}

export function resolveLocalRef(document, ref) {
  if (typeof ref !== 'string' || !ref.startsWith('#/')) return undefined;
  return ref
    .slice(2)
    .split('/')
    .map(decodePointer)
    .reduce((value, key) => value?.[key], document);
}

function operations(document) {
  const result = [];
  for (const [path, pathItem] of Object.entries(document.paths ?? {})) {
    for (const [method, operation] of Object.entries(pathItem ?? {})) {
      if (HTTP_METHODS.has(method)) result.push({ path, method, operation, pathItem });
    }
  }
  return result;
}

function validateOperationIds(document, violations) {
  const owners = new Map();
  for (const { path, method, operation } of operations(document)) {
    const id = operation.operationId;
    if (!id) {
      violations.push(`${method.toUpperCase()} ${path}: missing operationId`);
      continue;
    }
    if (owners.has(id)) {
      violations.push(`${method.toUpperCase()} ${path}: duplicate operationId ${id} (also ${owners.get(id)})`);
    } else {
      owners.set(id, `${method.toUpperCase()} ${path}`);
    }
  }
}

function validateRefs(document, violations) {
  visit(document, (node, pointer) => {
    if (!('$ref' in node)) return;
    if (!resolveLocalRef(document, node.$ref)) {
      violations.push(`${pointer}/$ref: unresolved or external ref ${node.$ref}`);
    }
  });
}

function resolvedParameters(document, values) {
  return (values ?? []).map((parameter) => {
    if (parameter?.$ref) return resolveLocalRef(document, parameter.$ref);
    return parameter;
  });
}

function validatePathParameters(document, violations) {
  for (const { path, method, operation, pathItem } of operations(document)) {
    const placeholders = new Set([...path.matchAll(/\{([^}]+)\}/g)].map((match) => match[1]));
    const parameters = [
      ...resolvedParameters(document, pathItem.parameters),
      ...resolvedParameters(document, operation.parameters),
    ].filter((parameter) => parameter?.in === 'path');
    const declared = new Set(parameters.map((parameter) => parameter.name));

    for (const name of placeholders) {
      const parameter = parameters.find((candidate) => candidate.name === name);
      if (!parameter) violations.push(`${method.toUpperCase()} ${path}: missing path parameter ${name}`);
      else if (parameter.required !== true) violations.push(`${method.toUpperCase()} ${path}: path parameter ${name} must be required`);
    }
    for (const name of declared) {
      if (!placeholders.has(name)) violations.push(`${method.toUpperCase()} ${path}: extraneous path parameter ${name}`);
    }
  }
}

function schemaRefs(node) {
  const refs = new Set();
  visit(node, (value) => {
    if (typeof value.$ref === 'string' && value.$ref.startsWith('#/components/schemas/')) {
      refs.add(value.$ref.slice('#/components/schemas/'.length));
    }
  });
  return refs;
}

function localRefs(node) {
  const refs = new Set();
  visit(node, (value) => {
    if (typeof value.$ref === 'string' && value.$ref.startsWith('#/')) refs.add(value.$ref);
  });
  return refs;
}

function validateReachableSchemas(document, violations) {
  const schemas = document.components?.schemas ?? {};
  const reachableSchemas = new Set();
  const visitedRefs = new Set();
  const pending = [...localRefs(document.paths ?? {})];
  while (pending.length > 0) {
    const ref = pending.pop();
    if (visitedRefs.has(ref)) continue;
    visitedRefs.add(ref);
    if (ref.startsWith('#/components/schemas/')) {
      reachableSchemas.add(ref.slice('#/components/schemas/'.length));
    }
    const target = resolveLocalRef(document, ref);
    for (const dependency of localRefs(target)) pending.push(dependency);
  }
  for (const name of Object.keys(schemas)) {
    if (!reachableSchemas.has(name)) {
      violations.push(`components.schemas.${name}: orphan schema is not reachable from any operation`);
    }
  }
}

function hasIdempotencyKey(document, operation) {
  return resolvedParameters(document, operation.parameters).some(
    (parameter) => parameter?.in === 'header'
      && parameter.name?.toLowerCase() === 'idempotency-key'
      && parameter.required === true,
  );
}

function isFinancialCommand(method, path) {
  return FINANCIAL_COMMANDS.some(([candidateMethod, pattern]) => (
    candidateMethod === method && pattern.test(path)
  ));
}

function validateFinancialCommands(document, violations) {
  for (const { path, method, operation } of operations(document)) {
    if (!isFinancialCommand(method, path)) continue;
    if (!hasIdempotencyKey(document, operation)) {
      violations.push(`${method.toUpperCase()} ${path}: financial command requires a required Idempotency-Key header`);
    }
    if (!operation.responses?.['409']) {
      violations.push(`${method.toUpperCase()} ${path}: financial command requires a 409 response`);
    }
  }
}

function normalizeFieldName(name) {
  return name.replaceAll(/[^a-zA-Z0-9]/g, '').toLowerCase();
}

function isForbiddenRequestField(name) {
  const normalized = normalizeFieldName(name);
  return FORBIDDEN_REQUEST_FIELDS.has(normalized)
    || (normalized.startsWith('provider') && normalized.endsWith('id'));
}

function isObjectSchema(schema) {
  return schema?.type === 'object' || !!schema?.properties || !!schema?.additionalProperties;
}

function requestObjectRole(context) {
  if (context === 'variant') return 'variant';
  if (context === 'member') return 'member';
  return 'root';
}

function validateRequestSchema(document, schema, label, violations, visitedRefs = new Set(), context = 'root') {
  if (!schema || typeof schema !== 'object') return;
  if (schema.$ref) {
    if (visitedRefs.has(schema.$ref)) return;
    visitedRefs.add(schema.$ref);
    validateRequestSchema(document, resolveLocalRef(document, schema.$ref), label, violations, visitedRefs, context);
    return;
  }
  if (Array.isArray(schema.oneOf)) {
    for (const [index, value] of schema.oneOf.entries()) {
      validateRequestSchema(document, value, `${label} oneOf[${index}]`, violations, visitedRefs, 'variant');
    }
  }
  for (const keyword of ['allOf', 'anyOf']) {
    for (const [index, value] of (schema[keyword] ?? []).entries()) {
      validateRequestSchema(document, value, `${label} ${keyword}[${index}]`, violations, visitedRefs, context);
    }
  }
  if (isObjectSchema(schema) && schema.additionalProperties !== false) {
    violations.push(`${label}: request body object ${requestObjectRole(context)} must set additionalProperties: false`);
  }
  for (const [name, property] of Object.entries(schema.properties ?? {})) {
    if (isForbiddenRequestField(name)) {
      violations.push(`${label}: request body contains forbidden server-owned field ${name}`);
    }
    validateRequestSchema(document, property, `${label}.${name}`, violations, visitedRefs, 'member');
  }
  validateRequestSchema(document, schema.items, `${label}[]`, violations, visitedRefs, 'member');
}
function validateRequestBodies(document, violations) {
  for (const { path, method, operation } of operations(document)) {
    const label = `${method.toUpperCase()} ${path}`;
    for (const mediaType of Object.values(operation.requestBody?.content ?? {})) {
      validateRequestSchema(document, mediaType?.schema, label, violations);
    }
  }
}

function resolvedResponse(document, declaredResponse) {
  return declaredResponse?.$ref
    ? resolveLocalRef(document, declaredResponse.$ref)
    : declaredResponse;
}

function hasUniformErrorSchema(document, declaredResponse) {
  const response = resolvedResponse(document, declaredResponse);
  return response?.content?.['application/json']?.schema?.$ref === '#/components/schemas/Error';
}

function validateSecurityResponses(document, violations) {
  for (const { path, method, operation } of operations(document)) {
    const security = Object.hasOwn(operation, 'security') ? operation.security : document.security;
    const publicOperation = Array.isArray(security) && security.length === 0;
    const requiredStatuses = publicOperation
      ? ['429', '503']
      : ['401', '403', '429', '503'];
    if (operation.operationId === 'createSession' && !requiredStatuses.includes('401')) {
      requiredStatuses.push('401');
    }
    if (isFinancialCommand(method, path)) requiredStatuses.push('422');

    for (const status of new Set(requiredStatuses)) {
      const declaredResponse = operation.responses?.[status];
      if (!declaredResponse) {
        violations.push(`${method.toUpperCase()} ${path}: missing required ${status} Error response`);
      } else if (!hasUniformErrorSchema(document, declaredResponse)) {
        violations.push(`${method.toUpperCase()} ${path} ${status}: response must use the uniform Error schema`);
      }
    }

    for (const [status, declaredResponse] of Object.entries(operation.responses ?? {})) {
      if (!/^[45][0-9][0-9]$/.test(status)) continue;
      if (!hasUniformErrorSchema(document, declaredResponse)) {
        violations.push(`${method.toUpperCase()} ${path} ${status}: response must use the uniform Error schema`);
      }
    }
  }
}

function validateAllResponseHeaders(document, violations) {
  for (const { path, method, operation } of operations(document)) {
    for (const [status, declaredResponse] of Object.entries(operation.responses ?? {})) {
      const response = resolvedResponse(document, declaredResponse);
      const hasRequestId = Object.keys(response?.headers ?? {})
        .some((name) => name.toLowerCase() === 'x-request-id');
      if (!hasRequestId) {
        violations.push(`${method.toUpperCase()} ${path} ${status}: response must declare X-Request-ID`);
      }
    }
  }
}

const DECIMAL_TOKENS = new Set([
  'amount', 'balance', 'fee', 'leverage', 'margin', 'multiplier', 'notional',
  'percent', 'pnl', 'price', 'quantity', 'rate', 'size', 'value', 'volume',
]);
const DECIMAL_EXCLUDED_SUFFIXES = new Set([
  'asset', 'currency', 'decimals', 'display', 'label', 'mode', 'note', 'status', 'text', 'unit', 'updated',
]);

function requiresDecimal(name) {
  const tokens = name.toLowerCase().split('_');
  if (!tokens.some((token) => DECIMAL_TOKENS.has(token))) return false;
  if (name === 'value') return false;
  return !DECIMAL_EXCLUDED_SUFFIXES.has(tokens.at(-1));
}

function isDecimalSchema(schema) {
  if (!schema || typeof schema !== 'object') return false;
  if (schema.$ref === '#/components/schemas/Decimal') return true;
  return (schema.allOf ?? []).some(
    (candidate) => candidate?.$ref === '#/components/schemas/Decimal',
  );
}

function validateDecimalFields(document, violations) {
  visit(document, (node, pointer) => {
    for (const [name, schema] of Object.entries(node.properties ?? {})) {
      if (requiresDecimal(name) && !isDecimalSchema(schema)) {
        violations.push(`${pointer}/properties/${escapePointer(name)}: numeric wire field ${name} must use Decimal`);
      }
    }
  });
}

const SETTLEMENT_SCHEMAS = [
  { name: 'OrderPreview', discriminator: 'kind', asset: 'settlement_asset' },
  { name: 'FundingRail', discriminator: 'rail', asset: 'settlement_asset' },
  { name: 'FundingPlan', discriminator: 'rail', asset: 'asset' },
];
const SETTLEMENT_VARIANTS = {
  bstock: { network: 'BSC' },
  perp: { network: 'Arbitrum' },
};

function localSchemaName(ref) {
  return typeof ref === 'string' && ref.startsWith('#/components/schemas/')
    ? ref.slice('#/components/schemas/'.length)
    : undefined;
}

function schemaProperty(document, schema, propertyName, visitedRefs = new Set()) {
  if (!schema || typeof schema !== 'object') return undefined;
  if (schema.$ref) {
    if (visitedRefs.has(schema.$ref)) return undefined;
    visitedRefs.add(schema.$ref);
    return schemaProperty(document, resolveLocalRef(document, schema.$ref), propertyName, visitedRefs);
  }
  if (schema.properties?.[propertyName]) return schema.properties[propertyName];
  for (const value of schema.allOf ?? []) {
    const result = schemaProperty(document, value, propertyName, visitedRefs);
    if (result) return result;
  }
  return undefined;
}

function schemaRequiresProperty(document, schema, propertyName, visitedRefs = new Set()) {
  if (!schema || typeof schema !== 'object') return false;
  if (schema.$ref) {
    if (visitedRefs.has(schema.$ref)) return false;
    visitedRefs.add(schema.$ref);
    return schemaRequiresProperty(document, resolveLocalRef(document, schema.$ref), propertyName, visitedRefs);
  }
  if ((schema.required ?? []).includes(propertyName)) return true;
  return (schema.allOf ?? []).some((value) => schemaRequiresProperty(document, value, propertyName, visitedRefs));
}

function hasSingletonEnum(schema, expectedValue) {
  return Array.isArray(schema?.enum) && schema.enum.length === 1 && schema.enum[0] === expectedValue;
}

function validateSettlementVariant(document, schemaName, schema, kind, discriminator, asset, violations) {
  const label = `components.schemas.${schemaName}`;
  const expected = SETTLEMENT_VARIANTS[kind];
  const checks = [
    [discriminator, kind],
    ['network', expected.network],
    [asset, 'USDC'],
  ];
  for (const [propertyName, expectedValue] of checks) {
    const property = schemaProperty(document, schema, propertyName);
    if (!schemaRequiresProperty(document, schema, propertyName) || !hasSingletonEnum(property, expectedValue)) {
      violations.push(`${label}: ${kind} settlement variant must require ${propertyName}=${expectedValue}`);
    }
  }
}

function validateSettlementDiscriminators(document, violations) {
  const schemas = document.components?.schemas ?? {};
  for (const { name, discriminator, asset } of SETTLEMENT_SCHEMAS) {
    const schema = schemas[name];
    if (!schema) continue;
    const label = `components.schemas.${name}`;
    if (!Array.isArray(schema.oneOf) || schema.oneOf.length !== 2) {
      violations.push(`${label}: settlement schema must use oneOf`);
      continue;
    }
    if (schema.discriminator?.propertyName !== discriminator) {
      violations.push(`${label}: settlement schema discriminator must use ${discriminator}`);
    }
    for (const kind of Object.keys(SETTLEMENT_VARIANTS)) {
      const mappedRef = schema.discriminator?.mapping?.[kind];
      const variantSchemaName = localSchemaName(mappedRef);
      if (!variantSchemaName || !schema.oneOf.some((candidate) => candidate?.$ref === mappedRef)) {
        violations.push(`${label}: settlement schema discriminator must map ${kind} to a oneOf variant`);
        continue;
      }
      validateSettlementVariant(document, variantSchemaName, resolveLocalRef(document, mappedRef), kind, discriminator, asset, violations);
    }
  }
}
export function validateContract(document) {
  const violations = [];
  validateOperationIds(document, violations);
  validateRefs(document, violations);
  validatePathParameters(document, violations);
  validateReachableSchemas(document, violations);
  validateFinancialCommands(document, violations);
  validateRequestBodies(document, violations);
  validateSettlementDiscriminators(document, violations);
  validateSecurityResponses(document, violations);
  validateAllResponseHeaders(document, violations);
  validateDecimalFields(document, violations);
  return violations.sort();
}

async function main() {
  const file = process.argv[2];
  if (!file) throw new Error('Usage: node scripts/validate-openapi-contract.mjs <openapi.yaml>');
  const document = parse(await readFile(file, 'utf8'));
  const violations = validateContract(document);
  if (violations.length > 0) {
    console.error(`OpenAPI contract rules failed with ${violations.length} violation(s):`);
    for (const violation of violations) console.error(`- ${violation}`);
    process.exitCode = 1;
    return;
  }
  console.log('OpenAPI contract rules passed.');
}

if (process.argv[1] && pathToFileURL(process.argv[1]).href === import.meta.url) {
  await main();
}
