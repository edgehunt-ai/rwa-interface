import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/// Fresh key for a brand-new logical request. The public API contract pins
/// `Idempotency-Key` to `format: uuid`, so every key must be a UUID.
String newIdempotencyKey() => _uuid.v4();

/// Deterministic key derived from a stable semantic identity. Retrying the
/// same logical operation must replay the exact same key, so derive it from
/// the identity instead of generating a fresh UUID per attempt.
String scopedIdempotencyKey(String identity) =>
    _uuid.v5(Uuid.NAMESPACE_URL, 'rwa:$identity');
