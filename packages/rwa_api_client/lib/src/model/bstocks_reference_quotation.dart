//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_reference_quotation.g.dart';

/// BstocksReferenceQuotation
///
/// Properties:
/// * [status] 
/// * [executionEnabled] 
/// * [priceKind] 
/// * [source_] 
/// * [symbol] 
/// * [chainId] 
/// * [pairId] 
/// * [quoteAsset] 
/// * [observedAtMs] 
/// * [validUntilMs] 
@BuiltValue()
abstract class BstocksReferenceQuotation implements Built<BstocksReferenceQuotation, BstocksReferenceQuotationBuilder> {
  @BuiltValueField(wireName: r'status')
  BstocksReferenceQuotationStatusEnum get status;
  // enum statusEnum {  fresh,  unavailable,  };

  @BuiltValueField(wireName: r'execution_enabled')
  bool get executionEnabled;

  @BuiltValueField(wireName: r'price_kind')
  BstocksReferenceQuotationPriceKindEnum? get priceKind;
  // enum priceKindEnum {  cex_top_of_book,  };

  @BuiltValueField(wireName: r'source')
  BstocksReferenceQuotationSource_Enum? get source_;
  // enum source_Enum {  binance,  };

  @BuiltValueField(wireName: r'symbol')
  String? get symbol;

  @BuiltValueField(wireName: r'chain_id')
  BstocksReferenceQuotationChainIdEnum? get chainId;
  // enum chainIdEnum {  56,  97,  31337,  };

  @BuiltValueField(wireName: r'pair_id')
  String? get pairId;

  @BuiltValueField(wireName: r'quote_asset')
  String? get quoteAsset;

  @BuiltValueField(wireName: r'observed_at_ms')
  int? get observedAtMs;

  @BuiltValueField(wireName: r'valid_until_ms')
  int? get validUntilMs;

  BstocksReferenceQuotation._();

  factory BstocksReferenceQuotation([void updates(BstocksReferenceQuotationBuilder b)]) = _$BstocksReferenceQuotation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksReferenceQuotationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksReferenceQuotation> get serializer => _$BstocksReferenceQuotationSerializer();
}

class _$BstocksReferenceQuotationSerializer implements PrimitiveSerializer<BstocksReferenceQuotation> {
  @override
  final Iterable<Type> types = const [BstocksReferenceQuotation, _$BstocksReferenceQuotation];

  @override
  final String wireName = r'BstocksReferenceQuotation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksReferenceQuotation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(BstocksReferenceQuotationStatusEnum),
    );
    yield r'execution_enabled';
    yield serializers.serialize(
      object.executionEnabled,
      specifiedType: const FullType(bool),
    );
    if (object.priceKind != null) {
      yield r'price_kind';
      yield serializers.serialize(
        object.priceKind,
        specifiedType: const FullType(BstocksReferenceQuotationPriceKindEnum),
      );
    }
    if (object.source_ != null) {
      yield r'source';
      yield serializers.serialize(
        object.source_,
        specifiedType: const FullType(BstocksReferenceQuotationSource_Enum),
      );
    }
    if (object.symbol != null) {
      yield r'symbol';
      yield serializers.serialize(
        object.symbol,
        specifiedType: const FullType(String),
      );
    }
    if (object.chainId != null) {
      yield r'chain_id';
      yield serializers.serialize(
        object.chainId,
        specifiedType: const FullType(BstocksReferenceQuotationChainIdEnum),
      );
    }
    if (object.pairId != null) {
      yield r'pair_id';
      yield serializers.serialize(
        object.pairId,
        specifiedType: const FullType(String),
      );
    }
    if (object.quoteAsset != null) {
      yield r'quote_asset';
      yield serializers.serialize(
        object.quoteAsset,
        specifiedType: const FullType(String),
      );
    }
    if (object.observedAtMs != null) {
      yield r'observed_at_ms';
      yield serializers.serialize(
        object.observedAtMs,
        specifiedType: const FullType(int),
      );
    }
    if (object.validUntilMs != null) {
      yield r'valid_until_ms';
      yield serializers.serialize(
        object.validUntilMs,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksReferenceQuotation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksReferenceQuotationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksReferenceQuotationStatusEnum),
          ) as BstocksReferenceQuotationStatusEnum;
          result.status = valueDes;
          break;
        case r'execution_enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.executionEnabled = valueDes;
          break;
        case r'price_kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksReferenceQuotationPriceKindEnum),
          ) as BstocksReferenceQuotationPriceKindEnum?;
          if (valueDes == null) continue;
          result.priceKind = valueDes;
          break;
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksReferenceQuotationSource_Enum),
          ) as BstocksReferenceQuotationSource_Enum?;
          if (valueDes == null) continue;
          result.source_ = valueDes;
          break;
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.symbol = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksReferenceQuotationChainIdEnum),
          ) as BstocksReferenceQuotationChainIdEnum?;
          if (valueDes == null) continue;
          result.chainId = valueDes;
          break;
        case r'pair_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.pairId = valueDes;
          break;
        case r'quote_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.quoteAsset = valueDes;
          break;
        case r'observed_at_ms':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.observedAtMs = valueDes;
          break;
        case r'valid_until_ms':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.validUntilMs = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksReferenceQuotation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksReferenceQuotationBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class BstocksReferenceQuotationStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'fresh')
  static const BstocksReferenceQuotationStatusEnum fresh = _$bstocksReferenceQuotationStatusEnum_fresh;
  @BuiltValueEnumConst(wireName: r'unavailable')
  static const BstocksReferenceQuotationStatusEnum unavailable = _$bstocksReferenceQuotationStatusEnum_unavailable;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksReferenceQuotationStatusEnum unknownDefaultOpenApi = _$bstocksReferenceQuotationStatusEnum_unknownDefaultOpenApi;

  static Serializer<BstocksReferenceQuotationStatusEnum> get serializer => _$bstocksReferenceQuotationStatusEnumSerializer;

  const BstocksReferenceQuotationStatusEnum._(String name): super(name);

  static BuiltSet<BstocksReferenceQuotationStatusEnum> get values => _$bstocksReferenceQuotationStatusEnumValues;
  static BstocksReferenceQuotationStatusEnum valueOf(String name) => _$bstocksReferenceQuotationStatusEnumValueOf(name);
}

class BstocksReferenceQuotationPriceKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'cex_top_of_book')
  static const BstocksReferenceQuotationPriceKindEnum cexTopOfBook = _$bstocksReferenceQuotationPriceKindEnum_cexTopOfBook;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksReferenceQuotationPriceKindEnum unknownDefaultOpenApi = _$bstocksReferenceQuotationPriceKindEnum_unknownDefaultOpenApi;

  static Serializer<BstocksReferenceQuotationPriceKindEnum> get serializer => _$bstocksReferenceQuotationPriceKindEnumSerializer;

  const BstocksReferenceQuotationPriceKindEnum._(String name): super(name);

  static BuiltSet<BstocksReferenceQuotationPriceKindEnum> get values => _$bstocksReferenceQuotationPriceKindEnumValues;
  static BstocksReferenceQuotationPriceKindEnum valueOf(String name) => _$bstocksReferenceQuotationPriceKindEnumValueOf(name);
}

class BstocksReferenceQuotationSource_Enum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'binance')
  static const BstocksReferenceQuotationSource_Enum binance = _$bstocksReferenceQuotationSourceEnum_binance;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksReferenceQuotationSource_Enum unknownDefaultOpenApi = _$bstocksReferenceQuotationSourceEnum_unknownDefaultOpenApi;

  static Serializer<BstocksReferenceQuotationSource_Enum> get serializer => _$bstocksReferenceQuotationSourceEnumSerializer;

  const BstocksReferenceQuotationSource_Enum._(String name): super(name);

  static BuiltSet<BstocksReferenceQuotationSource_Enum> get values => _$bstocksReferenceQuotationSourceEnumValues;
  static BstocksReferenceQuotationSource_Enum valueOf(String name) => _$bstocksReferenceQuotationSourceEnumValueOf(name);
}

class BstocksReferenceQuotationChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 56)
  static const BstocksReferenceQuotationChainIdEnum number56 = _$bstocksReferenceQuotationChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 97)
  static const BstocksReferenceQuotationChainIdEnum number97 = _$bstocksReferenceQuotationChainIdEnum_number97;
  @BuiltValueEnumConst(wireNumber: 31337)
  static const BstocksReferenceQuotationChainIdEnum number31337 = _$bstocksReferenceQuotationChainIdEnum_number31337;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BstocksReferenceQuotationChainIdEnum unknownDefaultOpenApi = _$bstocksReferenceQuotationChainIdEnum_unknownDefaultOpenApi;

  static Serializer<BstocksReferenceQuotationChainIdEnum> get serializer => _$bstocksReferenceQuotationChainIdEnumSerializer;

  const BstocksReferenceQuotationChainIdEnum._(String name): super(name);

  static BuiltSet<BstocksReferenceQuotationChainIdEnum> get values => _$bstocksReferenceQuotationChainIdEnumValues;
  static BstocksReferenceQuotationChainIdEnum valueOf(String name) => _$bstocksReferenceQuotationChainIdEnumValueOf(name);
}

