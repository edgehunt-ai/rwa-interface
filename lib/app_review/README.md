# App Review mode

This directory contains simulated account data and local repository
implementations used by the iOS App Store review account. Review mode uses real
APIs for market data, prices, market quotes, and other supporting data. It requires
network access and is not an offline mode.

Login, Privy embedded-wallet creation, and backend wallet synchronization use
the real identity and APIs. Wallet synchronization must
register the verified wallet before real deposit instructions can resolve it;
it does not require payment or move funds. The wallet list for simulated
portfolio assets retains the ledger's wallet identity so simulated withdrawals
continue to match those assets. Real deposit addresses come exclusively from
the live deposit directory. Transfer/withdrawal authorizations
remain simulated, as do the financial operations described below. After
upgrading from a build that simulated wallet synchronization, sign out and
sign in again to run the real synchronization during session setup.

Critical operations that would require the user to spend money or move real
funds must instead simulate success. Review users must be able to experience
these flows without paying, funding a real account, or executing real financial
transactions. Reading real funding instructions or obtaining a real quote does
not authorize a real transfer, withdrawal, payment, or trade submission.

Simulation must update the corresponding account state, rather than only
returning a successful response or displaying a success message:

- Creating, filling, or cancelling an order must update the appropriate open
  orders, order history, and activity lists. Filled orders must also update
  holdings, positions, available balances, and asset totals as applicable.
- A partial close must reduce the position by the requested quantity; a full
  close must remove it from open positions. Both must update order/activity
  history, realized PnL, balances, and portfolio values as applicable.
- Leverage and take-profit/stop-loss changes must appear in position details
  and the corresponding position and protection-order lists. Cancelling a
  protection order must update those views as well.
- Simulated funding, transfers, and withdrawals must update the corresponding
  balances, asset allocations, and transaction history without moving funds.

Lists, detail pages, and portfolio/asset displays must read consistent simulated
state. Refreshing or navigating between screens must preserve completed
simulated operations within the review session; a static fixture must not
overwrite their effects. Real market data and quotes may continue to refresh
and inform simulated valuations.

Spot-to-Perps transfer quotes and plans use the simulated ledger rather than
real wallet balances. They show a simulated 1:1 USDC transfer with zero fees and
slippage. Creating or refreshing a quote does not refresh account balances;
executing the transfer updates Spot/Perps balances and activity together.
Order funding checks obtain a matching, unexpired quote through the review
orders repository when one is not cached yet, including after amount or
slippage changes. Financial sufficiency uses simulated balances; quote errors
retain their concrete reason.

The repositories share one session-local ledger. Market orders simulate an
immediate fill; limit orders remain in the open-order list and reserve the
corresponding funds or shares until cancelled. Position equity, available
balances, holdings, allocation, and the latest portfolio-history point derive
from that ledger. Seed entry levels align with their first live market
observation. Later market refreshes update valuations without restoring closed
positions. Financial execution never requests a wallet signature or broadcasts
a transaction.

Perps allocation includes the cross USDC pool (cash plus position collateral,
less isolated and opening-order collateral), used cross/isolated margin,
opening-order margin, estimated withdrawable funds, and simulated liquidation
risk. Unrealized PnL changes equity without being counted as additional USDC
tokens. These details update from the same ledger after each operation.

Review accounts can add 1,000 units of the selected token from a deposit detail
screen. Credits use the selected network and token (USDC/USDT), with separate
balances per route. Simulated stablecoin balances are valued at USD 1 per token.
The credit updates balances, deposit history, and activity without an external
payment. Real deposit instructions remain available from the API. Simulated
funds and operations are held in memory for the active session; signing out or
restarting the app resets the demonstration data.

Simulated deposits use the same deposit-received sheet as normal deposits,
The Spot-to-Perps action appears only for Arbitrum USDC; other routes show
the corresponding token and network receipt. Updating simulated balances does
not reload the live deposit directory or replace the deposit page with a
loading state.

Run both the normal suite and the enabled review-mode suite:

```sh
flutter test
flutter test --dart-define=APP_REVIEW_ENABLED=true test/app_review
```

CI runs the enabled suite separately so build-gated provider routing and UI
checks are exercised. Regression coverage checks resulting lists and assets,
refreshes, idempotent retries, concrete quote failures, and session isolation.

Enable it only in an App Store review build:

```sh
flutter build ipa \
  --dart-define=APP_REVIEW_ENABLED=true \
  --dart-define=APP_REVIEW_USERS=did:privy:review-user
```

`APP_REVIEW_USERS` accepts comma-separated Privy user IDs, backend account IDs,
Privy DIDs, or login emails. These values are public build configuration and
must never contain passwords or other secrets.

Normal builds should omit the defines or set `APP_REVIEW_ENABLED=false`. The
compile-time constant keeps review providers and repositories off the normal
runtime path, and the shared mock store is created lazily only after a matching
review user signs in.

To remove the feature, delete this directory and remove references found by:

```sh
rg 'AppReview|appReview|APP_REVIEW' lib .env.example test
```

Simulated bStocks holdings can be withdrawn on BSC. Withdrawal selection,
available amounts, and sell availability share the same ledger and subtract
shares reserved by open sell orders. Completing a withdrawal reduces the
holding and portfolio value, updates account token balances and withdrawal
history, and never credits sale proceeds. Local token identities are used only
inside this simulation; no signing or live execution uses them.
