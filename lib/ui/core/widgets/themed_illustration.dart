import 'package:flutter/material.dart';

/// Paired artwork: the existing light image and a transparent dark variant.
enum IllustrationAsset {
  privateKeyWarning('account_activity/private_key_warning'),
  emptyState('common/empty_state_illustration'),
  errorState('common/error_state_illustration'),
  signIn('common/sign_in_illustration'),
  depositEmpty('funding/deposit_empty'),
  depositReceived('funding/deposit_received'),
  favoritesEmpty('home_markets/favorites_empty_illustration'),
  fundingPending('trade/funding_pending'),
  orderSubmitting('trade/order_submitting'),
  orderSuccess('trade/order_success');

  const IllustrationAsset(this._path);

  final String _path;

  String get lightAsset => 'assets/figma/$_path.webp';
  String get darkAsset => 'assets/figma/${_path}_dark.webp';
}

/// Selects artwork using the enclosing theme, including live mode changes.
class ThemedIllustration extends StatelessWidget {
  const ThemedIllustration(
    this.asset, {
    super.key,
    this.width,
    this.height,
    this.fit,
  });

  final IllustrationAsset asset;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) => Image.asset(
    Theme.of(context).brightness == Brightness.dark
        ? asset.darkAsset
        : asset.lightAsset,
    width: width,
    height: height,
    fit: fit,
  );
}
