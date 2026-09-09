import '../../domain/auth/identity_auth_gateway.dart';
import 'unsupported_identity_auth_gateway.dart';

/// Used in non-browser builds so browser interop is not linked into them.
IdentityAuthGateway createWebIdentityAuthGateway() =>
    const UnsupportedIdentityAuthGateway();
