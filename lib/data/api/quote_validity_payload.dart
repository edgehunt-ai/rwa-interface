import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

/// Decodes `quote_validity` without telling its variants apart.
///
/// The contract models it as a `oneOf` of [BstocksBlockQuoteValidity] and
/// [BstocksRequoteValidity] with no discriminator, and dart-dio drops the
/// structural constraints that would separate them: the generated enums map an
/// unrecognized `kind` to `unknown_default_open_api` instead of rejecting it,
/// and unknown members are ignored. A `block_window` payload therefore decodes
/// as *both* variants and `OneOfSerializer` aborts the whole preview with
/// "more than one match found".
///
/// Nothing in the app reads this field, so the variants are not worth
/// rescuing. Keeping the members as a plain map preserves whatever the server
/// sent, for a reader that does not exist yet, without a decision this client
/// has no way to make correctly.
final class QuoteValidityPayload {
  const QuoteValidityPayload(this.fields);

  final Map<String, Object?> fields;

  String? get kind => fields['kind']?.toString();
}

class QuoteValidityPayloadSerializer
    implements PrimitiveSerializer<BstocksPreviewEconomicsQuoteValidity> {
  const QuoteValidityPayloadSerializer();

  @override
  Iterable<Type> get types => const [BstocksPreviewEconomicsQuoteValidity];

  @override
  String get wireName => r'BstocksPreviewEconomicsQuoteValidity';

  @override
  Object serialize(
    Serializers serializers,
    BstocksPreviewEconomicsQuoteValidity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final value = object.oneOf.value;
    if (value is QuoteValidityPayload) return value.fields;
    return serializers.serialize(
      value,
      specifiedType: FullType(object.oneOf.valueType),
    )!;
  }

  @override
  BstocksPreviewEconomicsQuoteValidity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => BstocksPreviewEconomicsQuoteValidity(
    (builder) => builder.oneOf = OneOfDynamic(
      types: const [QuoteValidityPayload],
      typeIndex: 0,
      value: QuoteValidityPayload(_fields(serialized)),
    ),
  );

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
    throw const FormatException('quote_validity is not a JSON object');
  }
}
