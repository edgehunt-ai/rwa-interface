//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/multi_source_funding_leg_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_source_position_snapshot.dart';
import 'package:rwa_api_client/src/model/funding_wallet_action_summary.dart';
import 'package:rwa_api_client/src/model/funding_route_quote.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'multi_source_funding_leg.g.dart';

/// One independently authorized and sequentially executed funding leg. A non-null `transfer_id` identifies the leg's dedicated Transfer; authorization and execution never span multiple legs. 
///
/// Properties:
/// * [legId] 
/// * [ordinal] 
/// * [sourcePositionSnapshot] 
/// * [route] 
/// * [outputAmount] - 十进制字符串，避免浮点误差
/// * [status] 
/// * [transferId] - Null until the server has created this leg's dedicated Transfer.
/// * [walletActions] 
@BuiltValue()
abstract class MultiSourceFundingLeg implements Built<MultiSourceFundingLeg, MultiSourceFundingLegBuilder> {
  @BuiltValueField(wireName: r'leg_id')
  String get legId;

  @BuiltValueField(wireName: r'ordinal')
  int get ordinal;

  @BuiltValueField(wireName: r'source_position_snapshot')
  FundingSourcePositionSnapshot get sourcePositionSnapshot;

  @BuiltValueField(wireName: r'route')
  FundingRouteQuote get route;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'output_amount')
  String get outputAmount;

  @BuiltValueField(wireName: r'status')
  MultiSourceFundingLegStatus get status;
  // enum statusEnum {  planned,  action_released,  submitted,  origin_confirmed,  provider_confirmed,  target_confirmed,  completed,  cancelled_as_unneeded,  failed,  ambiguous,  manual_review,  };

  /// Null until the server has created this leg's dedicated Transfer.
  @BuiltValueField(wireName: r'transfer_id')
  String? get transferId;

  @BuiltValueField(wireName: r'wallet_actions')
  BuiltList<FundingWalletActionSummary> get walletActions;

  MultiSourceFundingLeg._();

  factory MultiSourceFundingLeg([void updates(MultiSourceFundingLegBuilder b)]) = _$MultiSourceFundingLeg;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MultiSourceFundingLegBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MultiSourceFundingLeg> get serializer => _$MultiSourceFundingLegSerializer();
}

class _$MultiSourceFundingLegSerializer implements PrimitiveSerializer<MultiSourceFundingLeg> {
  @override
  final Iterable<Type> types = const [MultiSourceFundingLeg, _$MultiSourceFundingLeg];

  @override
  final String wireName = r'MultiSourceFundingLeg';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MultiSourceFundingLeg object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'leg_id';
    yield serializers.serialize(
      object.legId,
      specifiedType: const FullType(String),
    );
    yield r'ordinal';
    yield serializers.serialize(
      object.ordinal,
      specifiedType: const FullType(int),
    );
    yield r'source_position_snapshot';
    yield serializers.serialize(
      object.sourcePositionSnapshot,
      specifiedType: const FullType(FundingSourcePositionSnapshot),
    );
    yield r'route';
    yield serializers.serialize(
      object.route,
      specifiedType: const FullType(FundingRouteQuote),
    );
    yield r'output_amount';
    yield serializers.serialize(
      object.outputAmount,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(MultiSourceFundingLegStatus),
    );
    yield r'transfer_id';
    yield object.transferId == null ? null : serializers.serialize(
      object.transferId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'wallet_actions';
    yield serializers.serialize(
      object.walletActions,
      specifiedType: const FullType(BuiltList, [FullType(FundingWalletActionSummary)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MultiSourceFundingLeg object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MultiSourceFundingLegBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'leg_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.legId = valueDes;
          break;
        case r'ordinal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.ordinal = valueDes;
          break;
        case r'source_position_snapshot':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSourcePositionSnapshot),
          ) as FundingSourcePositionSnapshot;
          result.sourcePositionSnapshot.replace(valueDes);
          break;
        case r'route':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingRouteQuote),
          ) as FundingRouteQuote;
          result.route.replace(valueDes);
          break;
        case r'output_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.outputAmount = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MultiSourceFundingLegStatus),
          ) as MultiSourceFundingLegStatus;
          result.status = valueDes;
          break;
        case r'transfer_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.transferId = valueDes;
          break;
        case r'wallet_actions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(FundingWalletActionSummary)]),
          ) as BuiltList<FundingWalletActionSummary>;
          result.walletActions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MultiSourceFundingLeg deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MultiSourceFundingLegBuilder();
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

