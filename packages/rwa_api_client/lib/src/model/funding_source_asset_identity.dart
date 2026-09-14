//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_source_asset_identity.g.dart';

/// FundingSourceAssetIdentity
///
/// Properties:
/// * [assetId] 
/// * [namespace] 
/// * [network] 
/// * [chainId] 
/// * [token] 
/// * [tokenContract] 
/// * [tokenDecimals] 
/// * [provenance] 
@BuiltValue()
abstract class FundingSourceAssetIdentity implements Built<FundingSourceAssetIdentity, FundingSourceAssetIdentityBuilder> {
  @BuiltValueField(wireName: r'asset_id')
  String get assetId;

  @BuiltValueField(wireName: r'namespace')
  String get namespace;

  @BuiltValueField(wireName: r'network')
  String get network;

  @BuiltValueField(wireName: r'chain_id')
  int get chainId;

  @BuiltValueField(wireName: r'token')
  String get token;

  @BuiltValueField(wireName: r'token_contract')
  String get tokenContract;

  @BuiltValueField(wireName: r'token_decimals')
  int get tokenDecimals;

  @BuiltValueField(wireName: r'provenance')
  String get provenance;

  FundingSourceAssetIdentity._();

  factory FundingSourceAssetIdentity([void updates(FundingSourceAssetIdentityBuilder b)]) = _$FundingSourceAssetIdentity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSourceAssetIdentityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSourceAssetIdentity> get serializer => _$FundingSourceAssetIdentitySerializer();
}

class _$FundingSourceAssetIdentitySerializer implements PrimitiveSerializer<FundingSourceAssetIdentity> {
  @override
  final Iterable<Type> types = const [FundingSourceAssetIdentity, _$FundingSourceAssetIdentity];

  @override
  final String wireName = r'FundingSourceAssetIdentity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSourceAssetIdentity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'asset_id';
    yield serializers.serialize(
      object.assetId,
      specifiedType: const FullType(String),
    );
    yield r'namespace';
    yield serializers.serialize(
      object.namespace,
      specifiedType: const FullType(String),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(String),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(int),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType: const FullType(String),
    );
    yield r'token_decimals';
    yield serializers.serialize(
      object.tokenDecimals,
      specifiedType: const FullType(int),
    );
    yield r'provenance';
    yield serializers.serialize(
      object.provenance,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingSourceAssetIdentity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingSourceAssetIdentityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.assetId = valueDes;
          break;
        case r'namespace':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.namespace = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.network = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.chainId = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tokenContract = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.tokenDecimals = valueDes;
          break;
        case r'provenance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.provenance = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingSourceAssetIdentity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSourceAssetIdentityBuilder();
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

