# HIP3 Web typed-data signing

The Web identity gateway now implements the existing `Hip3TypedDataSigner` port.
Order and position execution continue through their existing repositories and
action executor; this change adds no broadcaster, private key or agent signer.

The React Privy bridge selects exactly one connected Ethereum wallet matching the
server's expected signer, also requiring that address to be linked to the current
authenticated user. It waits for wallet readiness by returning a retryable
unavailable result when discovery is incomplete, rather than choosing another
wallet. It requests only `eth_signTypedData_v4`, forwarding the frozen JSON string
unchanged. There is no `personal_sign`/`eth_sign` fallback or automatic retry.

Session generation, user identity and wallet binding are checked before requesting
and after receiving a signature. Logout invalidates pending signing immediately.
The Dart bridge also discards late results after its own logout/reinitialization.
The backend remains responsible for cryptographic verification and broadcasting.

Privy's connected-versus-linked distinction is documented at
[Get connected wallets](https://docs.privy.io/wallets/wallets/get-a-wallet/get-connected-wallet).

Verification:

- `npm run privy:web:test`: five Node tests cover exact RPC/payload, readiness,
  mismatching/ambiguous/unlinked wallets, invalid payload/signature, stale session
  and user rejection without fallback.
- `flutter test --platform chrome test/data/auth/web_identity_auth_gateway_test.dart`:
  three real browser bridge tests passed (mock provider, no real signing).
- `npm run privy:web:build`: generated browser bundle updated successfully.
- Targeted Dart analysis passed for both the gateway and browser test.
- Hand-maintained files pass `git diff --check`. The generated bundle retains
  dependency template-literal whitespace; the full diff check reports those lines.
  They are not blindly stripped because whitespace inside literals can be data.

This is local implementation and verification, not deployment or an acceptance
test using a real Privy account. The existing dependency lock reports 27 npm audit
findings (25 moderate, 2 high); dependencies were installed without changing their
versions, and no broad automatic dependency upgrade is included in this work.
