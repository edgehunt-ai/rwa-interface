//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/bstocks_preview_fee.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_preview_fees.g.dart';

/// BstocksPreviewFees
///
/// Properties:
/// * [trading] 
/// * [network] 
@BuiltValue()
abstract class BstocksPreviewFees implements Built<BstocksPreviewFees, BstocksPreviewFeesBuilder> {
  @BuiltValueField(wireName: r'trading')
  BstocksPreviewFee get trading;

  @BuiltValueField(wireName: r'network')
  BstocksPreviewFee get network;

  BstocksPreviewFees._();

  factory BstocksPreviewFees([void updates(BstocksPreviewFeesBuilder b)]) = _$BstocksPreviewFees;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksPreviewFeesBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksPreviewFees> get serializer => _$BstocksPreviewFeesSerializer();
}

class _$BstocksPreviewFeesSerializer implements PrimitiveSerializer<BstocksPreviewFees> {
  @override
  final Iterable<Type> types = const [BstocksPreviewFees, _$BstocksPreviewFees];

  @override
  final String wireName = r'BstocksPreviewFees';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksPreviewFees object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'trading';
    yield serializers.serialize(
      object.trading,
      specifiedType: const FullType(BstocksPreviewFee),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(BstocksPreviewFee),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksPreviewFees object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksPreviewFeesBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'trading':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksPreviewFee),
          ) as BstocksPreviewFee;
          result.trading.replace(valueDes);
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksPreviewFee),
          ) as BstocksPreviewFee;
          result.network.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksPreviewFees deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksPreviewFeesBuilder();
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

