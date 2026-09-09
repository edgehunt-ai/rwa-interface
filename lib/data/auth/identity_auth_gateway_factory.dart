import 'package:flutter/foundation.dart';

import '../../domain/auth/identity_auth_gateway.dart';
import 'privy_identity_auth_gateway.dart';
import 'unsupported_identity_auth_gateway.dart';
import 'web_identity_auth_gateway_stub.dart'
    if (dart.library.js_interop) 'web_identity_auth_gateway.dart'
    as web;

IdentityAuthGateway createIdentityAuthGateway({
  bool isWeb = kIsWeb,
  TargetPlatform? platform,
}) {
  if (isWeb) return web.createWebIdentityAuthGateway();
  final target = platform ?? defaultTargetPlatform;
  if (target == TargetPlatform.android || target == TargetPlatform.iOS) {
    return PrivyIdentityAuthGateway();
  }
  return const UnsupportedIdentityAuthGateway();
}
