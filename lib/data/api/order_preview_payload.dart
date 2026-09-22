import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

import 'quote_validity_payload.dart';

/// A decoded `/orders/preview` response.
///
/// Every variant of the contract's `OrderPreview` `oneOf` carries the same
/// [OrderPreviewCommon] body and differs only in its settlement identity, which
/// the app reads as plain text. Decoding straight into the common shape keeps
/// the typed terms — `hip3_execution` above all — without having to tell the
/// variants apart, so a settlement identity the client has never heard of stays
/// readable instead of failing or, worse, being read as a different one.
final class OrderPreviewPayload {
  const OrderPreviewPayload({required this.common, required this.fields});

  final OrderPreviewCommon common;

  /// Top-level members the variants add on top of [OrderPreviewCommon]:
  /// `kind`, `network`, `settlement_asset` and the bStocks execution binding.
  final Map<String, Object?> fields;

  String? text(String key) => fields[key]?.toString();
}

/// Decodes `OrderPreview` without going through the generated `oneOf`.
///
/// dart-dio drops the contract's structural constraints, leaving every variant
/// able to accept every payload; `OneOfSerializer` then aborts with
/// "more than one match found" and the response decodes to nothing at all.
/// The variants are not worth rescuing: the app only ever read their `kind`,
/// `network` and `settlement_asset` members, and reading those as text avoids
/// the generated enums' `unknown_default_open_api` fallback, which is what
/// could silently turn testnet TUSDT into mainnet USDT.
class OrderPreviewPayloadSerializer
    implements PrimitiveSerializer<OrderPreview> {
  const OrderPreviewPayloadSerializer();

  @override
  Iterable<Type> get types => const [OrderPreview];

  @override
  String get wireName => r'OrderPreview';

  @override
  Object serialize(
    Serializers serializers,
    OrderPreview object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(
      oneOf.value,
      specifiedType: FullType(oneOf.valueType),
    )!;
  }

  @override
  OrderPreview deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final common = serializers.deserialize(
      serialized,
      specifiedType: const FullType($OrderPreviewCommon),
    ) as OrderPreviewCommon;
    return OrderPreview(
      (builder) => builder.oneOf = OneOfDynamic(
        types: const [OrderPreviewPayload],
        typeIndex: 0,
        value: OrderPreviewPayload(common: common, fields: _fields(serialized)),
      ),
    );
  }

  /// `StandardJsonPlugin` flattens the JSON object into alternating key/value
  /// entries before a serializer sees it; accept both shapes.
  static Map<String, Object?> _fields(Object serialized) {
    if (serialized is Map) return serialized.cast<String, Object?>();
    if (serialized is List) {
      final fields = <String, Object?>{};
      for (var index = 0; index + 1 < serialized.length; index += 2) {
        final key = serialized[index];
        if (key is String) fields[key] = serialized[index + 1];
      }
      return fields;
    }
    throw const FormatException('Order preview payload is not a JSON object');
  }
}

/// Wire serializers used by the app.
///
/// Each entry replaces a generated serializer that cannot decode this API's
/// responses; `add` overwrites by type and wire name, so ordering after
/// `standardSerializers` is what makes them win.
final Serializers appApiSerializers =
    (standardSerializers.toBuilder()
          ..add(const OrderPreviewPayloadSerializer())
          ..add(const QuoteValidityPayloadSerializer()))
        .build();
