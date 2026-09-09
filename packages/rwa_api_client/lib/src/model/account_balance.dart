//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/account_kind.dart';
import 'package:rwa_api_client/src/model/chain.dart';
import 'package:rwa_api_client/src/model/token_balance.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_balance.g.dart';

/// AccountBalance
///
/// Properties:
/// * [account]
/// * [label]
/// * [address]
/// * [chain]
/// * [totalValueUsd] - 十进制字符串，避免浮点误差
/// * [availableUsd] - 十进制字符串，避免浮点误差
/// * [marginUsedUsd] - 十进制字符串，避免浮点误差
/// * [balances]
@BuiltValue()
abstract class AccountBalance
    implements Built<AccountBalance, AccountBalanceBuilder> {
  @BuiltValueField(wireName: r'account')
  AccountKind get account;
  // enum accountEnum {  app,  bstocks,  hip3,  };

  @BuiltValueField(wireName: r'label')
  String? get label;

  @BuiltValueField(wireName: r'address')
  String? get address;

  @BuiltValueField(wireName: r'chain')
  Chain? get chain;
  // enum chainEnum {  BSC,  Arbitrum,  Base,  Ethereum,  Hyperliquid,  Polygon,  Solana,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'total_value_usd')
  String? get totalValueUsd;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'available_usd')
  String? get availableUsd;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'margin_used_usd')
  String? get marginUsedUsd;

  @BuiltValueField(wireName: r'balances')
  BuiltList<TokenBalance> get balances;

  AccountBalance._();

  factory AccountBalance([void updates(AccountBalanceBuilder b)]) =
      _$AccountBalance;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountBalanceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountBalance> get serializer =>
      _$AccountBalanceSerializer();
}

class _$AccountBalanceSerializer
    implements PrimitiveSerializer<AccountBalance> {
  @override
  final Iterable<Type> types = const [AccountBalance, _$AccountBalance];

  @override
  final String wireName = r'AccountBalance';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountBalance object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'account';
    yield serializers.serialize(
      object.account,
      specifiedType: const FullType(AccountKind),
    );
    if (object.label != null) {
      yield r'label';
      yield serializers.serialize(
        object.label,
        specifiedType: const FullType(String),
      );
    }
    if (object.address != null) {
      yield r'address';
      yield serializers.serialize(
        object.address,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.chain != null) {
      yield r'chain';
      yield serializers.serialize(
        object.chain,
        specifiedType: const FullType(Chain),
      );
    }
    if (object.totalValueUsd != null) {
      yield r'total_value_usd';
      yield serializers.serialize(
        object.totalValueUsd,
        specifiedType: const FullType(String),
      );
    }
    if (object.availableUsd != null) {
      yield r'available_usd';
      yield serializers.serialize(
        object.availableUsd,
        specifiedType: const FullType(String),
      );
    }
    if (object.marginUsedUsd != null) {
      yield r'margin_used_usd';
      yield serializers.serialize(
        object.marginUsedUsd,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'balances';
    yield serializers.serialize(
      object.balances,
      specifiedType: const FullType(BuiltList, [FullType(TokenBalance)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountBalance object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountBalanceBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'account':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountKind),
          ) as AccountKind;
          result.account = valueDes;
          break;
        case r'label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.label = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.address = valueDes;
          break;
        case r'chain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Chain),
          ) as Chain?;
          if (valueDes == null) continue;
          result.chain = valueDes;
          break;
        case r'total_value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.totalValueUsd = valueDes;
          break;
        case r'available_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.availableUsd = valueDes;
          break;
        case r'margin_used_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.marginUsedUsd = valueDes;
          break;
        case r'balances':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TokenBalance)]),
          ) as BuiltList<TokenBalance>;
          result.balances.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountBalance deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountBalanceBuilder();
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
