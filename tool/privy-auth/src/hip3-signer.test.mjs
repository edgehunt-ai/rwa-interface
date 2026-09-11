import { test } from 'node:test';
import assert from 'node:assert/strict';
import { signHip3TypedData } from './hip3-signer.mjs';

const address = `0x${'11'.repeat(20)}`;
const other = `0x${'22'.repeat(20)}`;
const signature = `0x${'33'.repeat(64)}1b`;
const payload = JSON.stringify({ types: { EIP712Domain: [], Agent: [{name:'source',type:'string'}] }, primaryType: 'Agent', domain: {}, message: {source:'b'} });
function fixture(request = async () => signature) {
  const wallet = { address, getEthereumProvider: async () => ({request}) };
  const state = { ready: true, walletsReady: true, authenticated: true, generation: 1,
    user: {id:'user-a', linkedAccounts:[{type:'wallet',chainType:'ethereum',address}]}, wallets:[wallet] };
  return {state,wallet, sign: (target=address, data=payload) => signHip3TypedData(() => state,target,data)};
}
const fails = (code) => (error) => error.code === code;

test('signs exact frozen string with exact wallet and no alternate RPC', async () => {
  const calls=[];
  const f=fixture(async (call)=>{calls.push(call);return signature;});
  assert.equal(await f.sign(),signature);
  assert.deepEqual(calls,[{method:'eth_signTypedData_v4',params:[address,payload]}]);
});
test('rejects unavailable, mismatching, ambiguous and unlinked wallets before requesting', async () => {
  for (const mutation of [s=>s.walletsReady=false,s=>s.authenticated=false]) {
    const f=fixture(()=>assert.fail('must not request'));mutation(f.state);
    await assert.rejects(f.sign(),fails('walletUnavailable'));
  }
  for (const mutation of [s=>s.wallets[0].address=other,s=>s.wallets.push(s.wallets[0]),s=>s.user.linkedAccounts=[]]) {
    const f=fixture(()=>assert.fail('must not request'));mutation(f.state);
    await assert.rejects(f.sign(),fails('walletMismatch'));
  }
});
test('rejects malformed input and invalid signatures', async () => {
  const f=fixture();
  for (const data of ['{}','not json',JSON.stringify({types:{},domain:{},message:{},primaryType:'Missing'})])
    await assert.rejects(f.sign(address,data),fails('invalidPayload'));
  await assert.rejects(f.sign('bad'),fails('invalidPayload'));
  await assert.rejects(fixture(async()=> '0x1234').sign(),fails('invalidPayload'));
});
test('rejects changed session before requesting provider and after signature', async () => {
  const f=fixture(()=>assert.fail('must not sign after account switch'));
  f.wallet.getEthereumProvider=async()=>{f.state.generation++;return {request:()=>assert.fail()};};
  await assert.rejects(f.sign(),fails('walletUnavailable'));
  const g=fixture(async()=>{g.state.user={...g.state.user,id:'user-b'};return signature;});
  await assert.rejects(g.sign(),fails('walletUnavailable'));
});
test('maps user rejection without retry or fallback', async () => {
  let calls=0;
  const f=fixture(async()=>{calls++;throw {code:4001};});
  await assert.rejects(f.sign(),fails('rejected'));assert.equal(calls,1);
  await assert.rejects(fixture(async()=>{throw new Error('transport');}).sign(),fails('walletUnavailable'));
});
