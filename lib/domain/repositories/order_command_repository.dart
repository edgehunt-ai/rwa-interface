abstract interface class OrderCommandRepository {
  Future<String> submit({
    required String intentId,
    required String idempotencyKey,
  });
}
