export async function signHip3TypedData(getState, expectedSigner, encodedPayload) {
  const fail = (code) => { throw Object.assign(new Error(code), {code}); };
  if (typeof expectedSigner !== 'string' || !/^0x[0-9a-f]{40}$/i.test(expectedSigner) ||
      typeof encodedPayload !== 'string' || encodedPayload.length > 262144) fail('invalidPayload');
  let payload;
  try { payload = JSON.parse(encodedPayload); } catch { fail('invalidPayload'); }
  const object = (value) => value !== null && typeof value === 'object' && !Array.isArray(value);
  if (!object(payload) || !object(payload.domain) || !object(payload.message) || !object(payload.types) ||
      typeof payload.primaryType !== 'string' || !Array.isArray(payload.types[payload.primaryType])) fail('invalidPayload');
  const address = expectedSigner.toLowerCase();
  const initial = getState();
  const generation = initial.generation;
  const principal = initial.user?.id;
  function currentWallet() {
    const state = getState();
    if (!state.ready || !state.walletsReady || !state.authenticated || !principal ||
        state.generation !== generation || state.user?.id !== principal) fail('walletUnavailable');
    const linked = state.user.linkedAccounts?.some((account) => account.type === 'wallet' &&
      account.chainType === 'ethereum' && account.address?.toLowerCase() === address);
    const matches = state.wallets?.filter((wallet) => wallet.address?.toLowerCase() === address) ?? [];
    if (!linked || matches.length !== 1) fail('walletMismatch');
    return matches[0];
  }
  const wallet = currentWallet();
  let provider;
  try { provider = await wallet.getEthereumProvider(); } catch { fail('walletUnavailable'); }
  currentWallet();
  let signature;
  try {
    signature = await provider.request({method:'eth_signTypedData_v4',params:[wallet.address,encodedPayload]});
  } catch (error) {
    currentWallet();
    fail(error?.code === 4001 || error?.code === '4001' || error?.code === 'ACTION_REJECTED' ? 'rejected' : 'walletUnavailable');
  }
  currentWallet();
  if (typeof signature !== 'string' || !/^0x[0-9a-f]{128}(00|01|1b|1c)$/i.test(signature)) fail('invalidPayload');
  return signature;
}
