//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/portfolio_notice_severity.dart';
import 'package:rwa_api_client/src/model/portfolio_warning_code.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_notice.g.dart';

/// PortfolioNotice
///
/// Properties:
/// * [code] 
/// * [severity] 
/// * [message] 
/// * [userAction] 
@BuiltValue()
abstract class PortfolioNotice implements Built<PortfolioNotice, PortfolioNoticeBuilder> {
  @BuiltValueField(wireName: r'code')
  PortfolioWarningCode get code;
  // enum codeEnum {  evm_rpc_unavailable,  hyperliquid_unavailable,  price_unavailable,  asset_unvalued,  using_last_good,  wallet_set_changed,  internal_ledger_stale,  internal_ledger_unreconciled,  };

  @BuiltValueField(wireName: r'severity')
  PortfolioNoticeSeverity get severity;
  // enum severityEnum {  info,  warning,  error,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'user_action')
  String? get userAction;

  PortfolioNotice._();

  factory PortfolioNotice([void updates(PortfolioNoticeBuilder b)]) = _$PortfolioNotice;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioNoticeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioNotice> get serializer => _$PortfolioNoticeSerializer();
}

class _$PortfolioNoticeSerializer implements PrimitiveSerializer<PortfolioNotice> {
  @override
  final Iterable<Type> types = const [PortfolioNotice, _$PortfolioNotice];

  @override
  final String wireName = r'PortfolioNotice';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortfolioNotice object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(PortfolioWarningCode),
    );
    yield r'severity';
    yield serializers.serialize(
      object.severity,
      specifiedType: const FullType(PortfolioNoticeSeverity),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    if (object.userAction != null) {
      yield r'user_action';
      yield serializers.serialize(
        object.userAction,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioNotice object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PortfolioNoticeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioWarningCode),
          ) as PortfolioWarningCode;
          result.code = valueDes;
          break;
        case r'severity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioNoticeSeverity),
          ) as PortfolioNoticeSeverity;
          result.severity = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'user_action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.userAction = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PortfolioNotice deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortfolioNoticeBuilder();
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

