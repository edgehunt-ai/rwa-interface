//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_account_abstraction_mode.dart';
import 'package:rwa_api_client/src/model/hip3_agent_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_account_abstraction.g.dart';

/// Hip3AccountAbstraction
///
/// Properties:
/// * [ownerAddress] 
/// * [currentMode] 
/// * [targetMode] 
/// * [switchAvailable] - 仅 current_mode=default 时为 true；Unified Account 或 Portfolio Margin 用户不显示一次性切换入口。
/// * [agentStatus] 
/// * [observedAt] 
@BuiltValue()
abstract class Hip3AccountAbstraction implements Built<Hip3AccountAbstraction, Hip3AccountAbstractionBuilder> {
  @BuiltValueField(wireName: r'owner_address')
  String get ownerAddress;

  @BuiltValueField(wireName: r'current_mode')
  Hip3AccountAbstractionMode get currentMode;
  // enum currentModeEnum {  default,  unifiedAccount,  portfolioMargin,  };

  @BuiltValueField(wireName: r'target_mode')
  Hip3AccountAbstractionTargetModeEnum get targetMode;
  // enum targetModeEnum {  unifiedAccount,  };

  /// 仅 current_mode=default 时为 true；Unified Account 或 Portfolio Margin 用户不显示一次性切换入口。
  @BuiltValueField(wireName: r'switch_available')
  bool get switchAvailable;

  @BuiltValueField(wireName: r'agent_status')
  Hip3AgentStatus? get agentStatus;
  // enum agentStatusEnum {  awaiting_owner_approval,  registering,  active,  expiring,  expired,  rotating,  revoked,  failed,  manual_review,  };

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  Hip3AccountAbstraction._();

  factory Hip3AccountAbstraction([void updates(Hip3AccountAbstractionBuilder b)]) = _$Hip3AccountAbstraction;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3AccountAbstractionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3AccountAbstraction> get serializer => _$Hip3AccountAbstractionSerializer();
}

class _$Hip3AccountAbstractionSerializer implements PrimitiveSerializer<Hip3AccountAbstraction> {
  @override
  final Iterable<Type> types = const [Hip3AccountAbstraction, _$Hip3AccountAbstraction];

  @override
  final String wireName = r'Hip3AccountAbstraction';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3AccountAbstraction object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'owner_address';
    yield serializers.serialize(
      object.ownerAddress,
      specifiedType: const FullType(String),
    );
    yield r'current_mode';
    yield serializers.serialize(
      object.currentMode,
      specifiedType: const FullType(Hip3AccountAbstractionMode),
    );
    yield r'target_mode';
    yield serializers.serialize(
      object.targetMode,
      specifiedType: const FullType(Hip3AccountAbstractionTargetModeEnum),
    );
    yield r'switch_available';
    yield serializers.serialize(
      object.switchAvailable,
      specifiedType: const FullType(bool),
    );
    yield r'agent_status';
    yield object.agentStatus == null ? null : serializers.serialize(
      object.agentStatus,
      specifiedType: const FullType.nullable(Hip3AgentStatus),
    );
    yield r'observed_at';
    yield serializers.serialize(
      object.observedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3AccountAbstraction object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3AccountAbstractionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'owner_address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ownerAddress = valueDes;
          break;
        case r'current_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3AccountAbstractionMode),
          ) as Hip3AccountAbstractionMode;
          result.currentMode = valueDes;
          break;
        case r'target_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3AccountAbstractionTargetModeEnum),
          ) as Hip3AccountAbstractionTargetModeEnum;
          result.targetMode = valueDes;
          break;
        case r'switch_available':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.switchAvailable = valueDes;
          break;
        case r'agent_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3AgentStatus),
          ) as Hip3AgentStatus?;
          if (valueDes == null) continue;
          result.agentStatus = valueDes;
          break;
        case r'observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.observedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3AccountAbstraction deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3AccountAbstractionBuilder();
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

class Hip3AccountAbstractionTargetModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'unifiedAccount')
  static const Hip3AccountAbstractionTargetModeEnum unifiedAccount = _$hip3AccountAbstractionTargetModeEnum_unifiedAccount;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3AccountAbstractionTargetModeEnum unknownDefaultOpenApi = _$hip3AccountAbstractionTargetModeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3AccountAbstractionTargetModeEnum> get serializer => _$hip3AccountAbstractionTargetModeEnumSerializer;

  const Hip3AccountAbstractionTargetModeEnum._(String name): super(name);

  static BuiltSet<Hip3AccountAbstractionTargetModeEnum> get values => _$hip3AccountAbstractionTargetModeEnumValues;
  static Hip3AccountAbstractionTargetModeEnum valueOf(String name) => _$hip3AccountAbstractionTargetModeEnumValueOf(name);
}

