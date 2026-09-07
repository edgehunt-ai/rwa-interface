import 'user_account.dart';

final class ProductSession {
  const ProductSession({
    required this.sessionId,
    required this.createdAt,
    required this.expiresAt,
    required this.generation,
    required this.accountCreated,
    required this.account,
  });

  final String sessionId;
  final DateTime createdAt;
  final DateTime expiresAt;
  final int generation;
  final bool accountCreated;
  final UserAccount account;

  bool get isExpired => !expiresAt.isAfter(DateTime.now().toUtc());
}
