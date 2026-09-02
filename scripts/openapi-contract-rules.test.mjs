import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import test from 'node:test';

import { parse } from 'yaml';

import { validateContract } from './validate-openapi-contract.mjs';

test('the checked-in OpenAPI document satisfies every custom contract rule', async () => {
  const document = parse(await readFile(new URL('../openapi/main.yaml', import.meta.url), 'utf8'));

  assert.deepEqual(validateContract(document), []);
});

test('reports duplicate operation ids, unresolved refs, and incomplete path parameters', () => {
  const document = {
    openapi: '3.0.3',
    paths: {
      '/v1/things/{thing_id}': {
        get: {
          operationId: 'readThing',
          responses: { 200: { description: 'OK' } },
        },
      },
      '/v1/other': {
        get: {
          operationId: 'readThing',
          responses: {
            200: { description: 'OK', content: { 'application/json': { schema: { $ref: '#/components/schemas/Missing' } } } },
          },
        },
      },
    },
    components: { schemas: { Unused: { type: 'object' } } },
  };

  const violations = validateContract(document).join('\n');
  assert.match(violations, /duplicate operationId readThing/);
  assert.match(violations, /missing path parameter thing_id/);
  assert.match(violations, /unresolved or external ref/);
  assert.match(violations, /Unused: orphan schema/);
});

test('financial commands require idempotency and reject server-owned request fields', () => {
  const document = {
    openapi: '3.0.3',
    paths: {
      '/v1/orders': {
        post: {
          operationId: 'createOrder',
          requestBody: {
            content: {
              'application/json': {
                schema: { type: 'object', properties: { account_id: { type: 'string' }, provider_order_id: { type: 'string' }, status: { type: 'string' } } },
              },
            },
          },
          responses: { 201: { description: 'Created' } },
        },
      },
    },
    components: { schemas: {} },
  };

  const violations = validateContract(document).join('\n');
  assert.match(violations, /requires a required Idempotency-Key header/);
  assert.match(violations, /requires a 409 response/);
  assert.match(violations, /forbidden server-owned field account_id/);
  assert.match(violations, /forbidden server-owned field provider_order_id/);
  assert.match(violations, /forbidden server-owned field status/);
});

test('request object roots and oneOf variants are closed and reject provider-owned fields', () => {
  const document = {
    openapi: '3.0.3',
    paths: {
      '/v1/root': {
        post: {
          operationId: 'createRoot',
          requestBody: {
            content: {
              'application/json': { schema: { $ref: '#/components/schemas/OpenRoot' } },
            },
          },
          responses: {},
        },
      },
      '/v1/variants': {
        post: {
          operationId: 'createVariant',
          requestBody: {
            content: {
              'application/json': {
                schema: {
                  oneOf: [
                    { $ref: '#/components/schemas/OpenVariant' },
                    { $ref: '#/components/schemas/ClosedVariant' },
                  ],
                },
              },
            },
          },
          responses: {},
        },
      },
    },
    components: {
      schemas: {
        OpenRoot: {
          type: 'object',
          properties: { provider: { type: 'string' }, provider_id: { type: 'string' } },
        },
        OpenVariant: {
          type: 'object',
          properties: { provider_account_id: { type: 'string' } },
        },
        ClosedVariant: { type: 'object', additionalProperties: false, properties: {} },
      },
    },
  };

  const violations = validateContract(document).join('\n');
  assert.match(violations, /POST \/v1\/root: request body object root must set additionalProperties: false/);
  assert.match(violations, /POST \/v1\/variants oneOf\[0\]: request body object variant must set additionalProperties: false/);
  assert.match(violations, /forbidden server-owned field provider/);
  assert.match(violations, /forbidden server-owned field provider_id/);
  assert.match(violations, /forbidden server-owned field provider_account_id/);
});


test('settlement schemas use discriminated oneOf variants for rail network and USDC', () => {
  const document = {
    openapi: '3.0.3',
    paths: {
      '/v1/orders/preview': {
        post: {
          operationId: 'previewOrder',
          responses: {
            200: {
              description: 'OK',
              headers: { 'X-Request-ID': { schema: { type: 'string' } } },
              content: { 'application/json': { schema: { $ref: '#/components/schemas/OrderPreview' } } },
            },
          },
        },
      },
    },
    components: {
      schemas: {
        OrderPreview: {
          type: 'object',
          properties: {
            kind: { type: 'string', enum: ['bstock', 'perp'] },
            network: { type: 'string', enum: ['BSC', 'Arbitrum'] },
            settlement_asset: { type: 'string', enum: ['USDC'] },
          },
        },
        FundingRail: {
          oneOf: [
            { $ref: '#/components/schemas/BstockFundingRail' },
            { $ref: '#/components/schemas/PerpFundingRail' },
          ],
          discriminator: {
            propertyName: 'rail',
            mapping: {
              bstock: '#/components/schemas/BstockFundingRail',
              perp: '#/components/schemas/PerpFundingRail',
            },
          },
        },
        BstockFundingRail: {
          type: 'object',
          properties: {
            rail: { type: 'string', enum: ['bstock'] },
            network: { type: 'string', enum: ['Arbitrum'] },
            settlement_asset: { type: 'string', enum: ['USDC'] },
          },
        },
        PerpFundingRail: {
          type: 'object',
          properties: {
            rail: { type: 'string', enum: ['perp'] },
            network: { type: 'string', enum: ['BSC'] },
            settlement_asset: { type: 'string', enum: ['USDT'] },
          },
        },
        FundingPlan: {
          type: 'object',
          properties: {
            rail: { type: 'string', enum: ['bstock', 'perp'] },
            network: { type: 'string', enum: ['BSC', 'Arbitrum'] },
            asset: { type: 'string', enum: ['USDC'] },
          },
        },
      },
    },
  };

  const violations = validateContract(document).join('\n');
  assert.match(violations, /components.schemas.OrderPreview: settlement schema must use oneOf/);
  assert.match(violations, /components.schemas.BstockFundingRail: bstock settlement variant must require network=BSC/);
  assert.match(violations, /components.schemas.PerpFundingRail: perp settlement variant must require network=Arbitrum/);
  assert.match(violations, /components.schemas.PerpFundingRail: perp settlement variant must require settlement_asset=USDC/);
  assert.match(violations, /components.schemas.FundingPlan: settlement schema must use oneOf/);
});
test('every response declares X-Request-ID', () => {
  const document = {
    openapi: '3.0.3',
    paths: {
      '/v1/things': {
        get: {
          operationId: 'listThings',
          responses: {
            200: {
              description: 'OK',
              content: { 'application/json': { schema: { type: 'array', items: { type: 'string' } } } },
            },
          },
        },
      },
    },
    components: { schemas: {} },
  };

  assert.match(validateContract(document).join('\n'), /response must declare X-Request-ID/);
});

test('protected and public operations declare their uniform error sets', () => {
  const document = {
    openapi: '3.0.3',
    security: [{ bearerAuth: [] }],
    paths: {
      '/v1/private': {
        get: { operationId: 'getPrivate', responses: { 200: { description: 'OK' } } },
      },
      '/v1/public': {
        get: { operationId: 'getPublic', security: [], responses: { 204: { description: 'No content' } } },
      },
    },
    components: {
      securitySchemes: { bearerAuth: { type: 'http', scheme: 'bearer' } },
      schemas: {},
    },
  };

  const violations = validateContract(document).join('\n');
  assert.match(violations, /GET \/v1\/private: missing required 401 Error response/);
  assert.match(violations, /GET \/v1\/private: missing required 403 Error response/);
  assert.match(violations, /GET \/v1\/private: missing required 429 Error response/);
  assert.match(violations, /GET \/v1\/private: missing required 503 Error response/);
  assert.match(violations, /GET \/v1\/public 204: response must declare X-Request-ID/);
  assert.doesNotMatch(violations, /GET \/v1\/public: missing required 401/);
  assert.match(violations, /GET \/v1\/public: missing required 429 Error response/);
  assert.match(violations, /GET \/v1\/public: missing required 503 Error response/);
  assert.match(violations, /GET \/v1\/public 204: response must declare X-Request-ID/);
});

test('financial commands require a 422 business rejection response', () => {
  const document = {
    openapi: '3.0.3',
    security: [{ bearerAuth: [] }],
    paths: {
      '/v1/orders': {
        post: {
          operationId: 'createOrder',
          parameters: [{
            name: 'Idempotency-Key',
            in: 'header',
            required: true,
            schema: { type: 'string' },
          }],
          responses: { 409: { description: 'Conflict' } },
        },
      },
    },
    components: {
      securitySchemes: { bearerAuth: { type: 'http', scheme: 'bearer' } },
      schemas: {},
    },
  };

  assert.match(validateContract(document).join('\n'), /POST \/v1\/orders: missing required 422 Error response/);
});

test('financial wire numbers use the shared Decimal schema', () => {
  const document = {
    openapi: '3.0.3',
    paths: {
      '/v1/quote': {
        get: {
          operationId: 'getQuote',
          security: [],
          responses: {
            200: {
              description: 'OK',
              headers: { 'X-Request-ID': { schema: { type: 'string' } } },
              content: { 'application/json': { schema: { $ref: '#/components/schemas/Quote' } } },
            },
          },
        },
      },
    },
    components: {
      schemas: {
        Quote: {
          type: 'object',
          properties: {
            price: { type: 'string' },
            leverage: { type: 'integer' },
          },
        },
      },
    },
  };

  const violations = validateContract(document).join('\n');
  assert.match(violations, /numeric wire field price must use Decimal/);
  assert.match(violations, /numeric wire field leverage must use Decimal/);
});

test('nested request objects are closed and reject server-owned fields', () => {
  const document = {
    openapi: '3.0.3',
    paths: {
      '/v1/nested': {
        post: {
          operationId: 'createNested',
          requestBody: {
            content: {
              'application/json': {
                schema: { $ref: '#/components/schemas/NestedRequest' },
              },
            },
          },
          responses: {},
        },
      },
    },
    components: {
      schemas: {
        NestedRequest: {
          type: 'object',
          additionalProperties: false,
          properties: {
            device: { $ref: '#/components/schemas/OpenDevice' },
            actions: {
              type: 'array',
              items: { $ref: '#/components/schemas/OpenAction' },
            },
          },
        },
        OpenDevice: {
          type: 'object',
          properties: { account_id: { type: 'string' } },
        },
        OpenAction: {
          type: 'object',
          properties: {
            provider_order_id: { type: 'string' },
            status: { type: 'string' },
          },
        },
      },
    },
  };

  const violations = validateContract(document).join('\n');
  assert.match(violations, /POST \/v1\/nested\.device: request body object member must set additionalProperties: false/);
  assert.match(violations, /POST \/v1\/nested\.actions\[\]: request body object member must set additionalProperties: false/);
  assert.match(violations, /forbidden server-owned field account_id/);
  assert.match(violations, /forbidden server-owned field provider_order_id/);
  assert.match(violations, /forbidden server-owned field status/);
});
