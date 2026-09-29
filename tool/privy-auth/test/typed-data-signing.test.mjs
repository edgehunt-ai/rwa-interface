import assert from 'node:assert/strict';
import test from 'node:test';

import { signTypedDataV4 } from '../src/typed-data-signing.mjs';

const signer = '0x1234567890abcdef1234567890abcdef12345678';
const signature = `0x${'ab'.repeat(65)}`;
const typedData = {
  domain: { name: 'HyperliquidSignTransaction' },
  primaryType: 'HyperliquidTransaction:ApproveAgent',
  types: { EIP712Domain: [] },
  message: { nonce: 1 },
};

test('signs typed data with the exact normalized wallet address', async () => {
  let request;
  const result = await signTypedDataV4({
    authenticated: true,
    expectedSigner: signer.toUpperCase().replace('0X', '0x'),
    typedDataJson: JSON.stringify(typedData),
    wallets: [
      {
        address: signer.toUpperCase().replace('0X', '0x'),
        getEthereumProvider: async () => ({
          request: async (value) => {
            request = value;
            return signature;
          },
        }),
      },
    ],
  });

  assert.equal(result, signature);
  assert.deepEqual(request, {
    method: 'eth_signTypedData_v4',
    params: [signer, JSON.stringify(typedData)],
  });
});

test('rejects signing before an authenticated signer is available', async () => {
  await assert.rejects(
    signTypedDataV4({
      authenticated: false,
      expectedSigner: signer,
      typedDataJson: JSON.stringify(typedData),
      wallets: [],
    }),
    /unavailable/,
  );
});

test('rejects malformed typed data and malformed signatures', async () => {
  await assert.rejects(
    signTypedDataV4({
      authenticated: true,
      expectedSigner: signer,
      typedDataJson: '[]',
      wallets: [],
    }),
    /payload is invalid/,
  );
  await assert.rejects(
    signTypedDataV4({
      authenticated: true,
      expectedSigner: signer,
      typedDataJson: JSON.stringify(typedData),
      wallets: [
        {
          address: signer,
          getEthereumProvider: async () => ({ request: async () => '0x1234' }),
        },
      ],
    }),
    /invalid signature/,
  );
});

test('rejects a signer that is not connected', async () => {
  await assert.rejects(
    signTypedDataV4({
      authenticated: true,
      expectedSigner: signer,
      typedDataJson: JSON.stringify(typedData),
      wallets: [],
    }),
    /not connected/,
  );
});
