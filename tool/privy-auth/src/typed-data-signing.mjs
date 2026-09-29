const ethereumAddress = /^0x[0-9a-f]{40}$/;
const compactSignature = /^0x[0-9a-f]{130}$/i;

export async function signTypedDataV4({
  authenticated,
  wallets,
  expectedSigner,
  typedDataJson,
}) {
  const signer = typeof expectedSigner === 'string' ? expectedSigner.toLowerCase() : '';
  if (!authenticated || !Array.isArray(wallets)) {
    throw new Error('Privy signing is unavailable.');
  }
  if (!ethereumAddress.test(signer)) {
    throw new Error('The expected signer is invalid.');
  }

  let typedData;
  try {
    typedData = JSON.parse(typedDataJson);
  } catch {
    throw new Error('The typed data payload is invalid.');
  }
  if (!typedData || Array.isArray(typedData) || typeof typedData !== 'object') {
    throw new Error('The typed data payload is invalid.');
  }

  const matches = wallets.filter(
    (wallet) => typeof wallet?.address === 'string' && wallet.address.toLowerCase() === signer,
  );
  if (matches.length !== 1 || typeof matches[0].getEthereumProvider !== 'function') {
    throw new Error('The expected signer is not connected.');
  }
  const provider = await matches[0].getEthereumProvider();
  const signature = await provider.request({
    method: 'eth_signTypedData_v4',
    params: [signer, typedDataJson],
  });
  if (typeof signature !== 'string' || !compactSignature.test(signature)) {
    throw new Error('Privy returned an invalid signature.');
  }
  return signature;
}
