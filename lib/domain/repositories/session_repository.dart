import '../models/product_session.dart';

abstract interface class SessionRepository {
  Future<ProductSession> createOrRestore({
    String? language,
    required int generation,
  });
  Future<void> endSession();
}
