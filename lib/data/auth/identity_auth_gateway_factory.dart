import 'package:flutter/foundation.dart';

import '../../domain/auth/identity_auth_gateway.dart';
import 'privy_identity_auth_gateway.dart';
import 'unsupported_identity_auth_gateway.dart';

IdentityAuthGateway createIdentityAuthGateway({
  bool isWeb = kIsWeb,
  TargetPlatform? platform,
}) {
  final target = platform ?? defaultTargetPlatform;
  if (!isWeb &&
      (target == TargetPlatform.android || target == TargetPlatform.iOS)) {
    return PrivyIdentityAuthGateway();
  }
  return const UnsupportedIdentityAuthGateway();
}
