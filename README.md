<p align="center">
  <img src="assets/branding/app-pink.svg" width="96" alt="Nobell app icon">
</p>

<h1 align="center">Nobell</h1>

<p align="center">
  A cross-platform Flutter application for digital asset trading.
</p>

<p align="center">
  <a href="README.md">English</a> |
  <a href="docs/zh/README.md">简体中文</a>
</p>

<p align="center">
  <a href="https://github.com/edgehunt-ai/rwa-interface/actions/workflows/ci.yml"><img src="https://github.com/edgehunt-ai/rwa-interface/actions/workflows/ci.yml/badge.svg" alt="CI"></a>
  <a href="https://github.com/edgehunt-ai/rwa-interface/actions/workflows/performance.yml"><img src="https://github.com/edgehunt-ai/rwa-interface/actions/workflows/performance.yml/badge.svg" alt="Native performance"></a>
  <img src="https://img.shields.io/badge/Flutter-3.47.6-02569B?logo=flutter" alt="Flutter 3.47.6">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-GPL--3.0-blue" alt="GPL-3.0 license"></a>
</p>

## Overview

Nobell provides market discovery, portfolio management, funding, and order
workflows from one Flutter codebase. Application-facing requests follow a
Riverpod-first boundary, while the API layer is generated from a versioned
OpenAPI contract.

Key capabilities include:

- Market lists, search, favorites, price charts, and product details.
- Tokenized stock and perpetual trading workflows, including order funding.
- Portfolio, deposit, withdrawal, transfer, and activity views.
- Email, Google OAuth, passkey, and external EVM wallet authentication.
- Native performance CI for page loading and buy/sell order journeys.
- Sentry observability and Firebase Cloud Messaging integration.

## Platform Support

| Platform | Status | Notes |
|---|---|---|
| Android | Supported | Android API 28 or later |
| iOS | Supported | iOS 17 or later |
| Web | Supported | Uses the React-based Privy browser bridge |
| macOS, Windows, Linux | Unsupported | Returns an explicit `unsupportedPlatform` state |

## Getting Started

### Prerequisites

- Flutter 3.47.6 with Dart 3.13.5
- Node.js 24
- An Android/iOS toolchain or a browser for the selected target
- Docker only when updating or regenerating the API client

### Install

```bash
git submodule update --init --recursive
npm ci --ignore-scripts
flutter pub get
cp .env.example .env
```

Fill in the public client configuration in `.env`. At minimum, local
development requires the API URL, Privy App/Client IDs, and Reown Project ID.
Never place secrets, access tokens, or server credentials in `.env`, source
files, or Dart build arguments.

### Run

```bash
make run
```

To select another environment file or Flutter target:

```bash
make run ENV_FILE=.env.staging FLUTTER_ARGS='-d android'
```

For Web, build the Privy browser bundle first:

```bash
npm run privy:web:build
flutter run -d chrome --dart-define-from-file=.env
```

## Common Commands

| Command | Purpose |
|---|---|
| `make run` | Validate configuration, sync the Privy URL scheme, and run Flutter |
| `npm run quality:check` | Check formatting, run static analysis, and execute Flutter tests |
| `flutter test` | Run the Flutter unit and widget test suite |
| `npm run perf:test` | Validate performance journeys and report generation |
| `npm run perf:run -- --device DEVICE_ID` | Collect a native profile-mode performance run |
| `npm run perf:report` | Generate the interactive performance report and CI summary |
| `npm run api:update` | Update the API contract submodule and regenerate the Dart client |

## Architecture

Application requests follow this dependency direction:

```text
Widget / screen
    -> Riverpod provider or notifier
    -> repository or use case
    -> data service
    -> generated dart-dio client
    -> Dio
```

- Widgets and ordinary business classes do not create `Dio` or call generated
  API operations directly.
- Repositories map transport DTOs into domain models.
- Presentation and state layers expose domain values and stable failures.
- Financial values remain lossless and are represented as strings.
- Bootstrap code, non-Flutter isolates, transport infrastructure, and focused
  tests may use lower-level calls only when the exception is documented and
  tested.

## Repository Layout

```text
lib/                         Flutter application and domain/data/UI layers
packages/rwa_api_client/     Generated dart-dio API client
contracts/rwa-api-contract/  Read-only API contract submodule
integration_test/            Native end-to-end and performance entry points
test/                        Unit, widget, and performance journey tests
scripts/                     API, configuration, and report tooling
private-key-export/          Isolated private-key export page
web/privy-auth/              Privy Web bridge
assets/                      Application and design assets
```

## API Client

[`edgehunt-ai/rwa-api-contract`](https://github.com/edgehunt-ai/rwa-api-contract)
is the contract source of truth. This repository consumes it through the
`contracts/rwa-api-contract` submodule. Do not edit the submodule contents or
generated files under `packages/rwa_api_client` by hand.

```bash
# Initialize the contract submodule.
npm run api:init

# Update the default contract branch and regenerate the client.
npm run api:update

# Update a specific contract branch and regenerate the client.
npm run api:update:branch -- feat/example
```

Generation also runs formatting, static analysis, and tests. The generated
OpenAPI version is recorded in
`packages/rwa_api_client/.openapi-generator/VERSION`.

## Quality and CI

GitHub Actions runs the Flutter quality gate for pushes and pull requests.
Mobile releases are built from successful `main` revisions, while the Flutter
Web app and private-key export page use their dedicated workflows.

Native performance CI runs Android in profile mode and measures page loading,
scrolling, product details, quotes, order previews, submissions, and
cancellations. It uses fixed repository data and never sends a real order. The
artifact includes an interactive HTML report, a complete PNG preview, machine
specifications, native frame timings, optional baseline comparisons, and an
automatic summary. The result is also updated in a single PR comment. See
[Native performance testing](docs/performance.md).

## Documentation

- [Native performance testing](docs/performance.md) (Chinese)
- [Push notification setup](docs/push-notifications.md)
- [Flutter documentation](https://docs.flutter.dev/)

## Security

Privy owns identity credential persistence. The application must not store or
log access tokens, email verification codes, private keys, or raw SDK errors.
CI variables, signing material, and server credentials belong in repository or
deployment secrets, never in committed configuration.

## License

Nobell is licensed under the [GNU General Public License v3.0](LICENSE).
