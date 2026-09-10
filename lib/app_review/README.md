# App Review mode

This directory contains all mock data and local repository implementations used
by the iOS App Store review account. It performs no network, wallet, payment,
push-registration, chain, or realtime-stream operations.

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
