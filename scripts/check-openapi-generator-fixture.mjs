import { readFile } from 'node:fs/promises';
import { parse } from 'yaml';

export function validateGeneratorFixture(document) {
  const schemas = document?.components?.schemas ?? {};
  const event = schemas.Event ?? {};
  const get = document?.paths?.['/things']?.get;
  const deleteOperation = document?.paths?.['/things']?.delete;
  const sse = document?.paths?.['/events']?.get?.responses?.['200']?.content?.['text/event-stream'];
  const errors = [];
  if (!event.oneOf || !event.discriminator) errors.push('missing discriminated oneOf');
  if (schemas.Page?.properties?.next_cursor?.nullable !== true) errors.push('missing nullable/absent fixture');
  if (!get?.responses?.['200'] || !get.responses['206']) errors.push('missing multiple success responses');
  if (!deleteOperation?.responses?.['204']) errors.push('missing 204 response');
  if (schemas.Decimal?.type !== 'string') errors.push('decimal must remain a string');
  if (!sse) errors.push('missing SSE response');
  if (!schemas.ApiError) errors.push('missing ApiError');
  return errors;
}

if (process.argv[1]?.endsWith('check-openapi-generator-fixture.mjs')) {
  const path = process.argv[2] ?? 'scripts/fixtures/openapi-generator/main.yaml';
  const errors = validateGeneratorFixture(parse(await readFile(path, 'utf8')));
  if (errors.length) throw new Error(errors.join('\n'));
  console.log('OpenAPI Generator fixture is valid.');
}
