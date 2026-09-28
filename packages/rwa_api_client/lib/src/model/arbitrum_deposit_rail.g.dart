// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arbitrum_deposit_rail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ArbitrumDepositRailChainEnum _$arbitrumDepositRailChainEnum_arbitrum =
    const ArbitrumDepositRailChainEnum._('arbitrum');

ArbitrumDepositRailChainEnum _$arbitrumDepositRailChainEnumValueOf(
    String name) {
  switch (name) {
    case 'arbitrum':
      return _$arbitrumDepositRailChainEnum_arbitrum;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ArbitrumDepositRailChainEnum>
    _$arbitrumDepositRailChainEnumValues =
    BuiltSet<ArbitrumDepositRailChainEnum>(const <ArbitrumDepositRailChainEnum>[
  _$arbitrumDepositRailChainEnum_arbitrum,
]);

const ArbitrumDepositRailChainIdEnum
    _$arbitrumDepositRailChainIdEnum_number42161 =
    const ArbitrumDepositRailChainIdEnum._('number42161');

ArbitrumDepositRailChainIdEnum _$arbitrumDepositRailChainIdEnumValueOf(
    String name) {
  switch (name) {
    case 'number42161':
      return _$arbitrumDepositRailChainIdEnum_number42161;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ArbitrumDepositRailChainIdEnum>
    _$arbitrumDepositRailChainIdEnumValues = BuiltSet<
        ArbitrumDepositRailChainIdEnum>(const <ArbitrumDepositRailChainIdEnum>[
  _$arbitrumDepositRailChainIdEnum_number42161,
]);

const ArbitrumDepositRailTokenEnum _$arbitrumDepositRailTokenEnum_USDC =
    const ArbitrumDepositRailTokenEnum._('USDC');

ArbitrumDepositRailTokenEnum _$arbitrumDepositRailTokenEnumValueOf(
    String name) {
  switch (name) {
    case 'USDC':
      return _$arbitrumDepositRailTokenEnum_USDC;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ArbitrumDepositRailTokenEnum>
    _$arbitrumDepositRailTokenEnumValues =
    BuiltSet<ArbitrumDepositRailTokenEnum>(const <ArbitrumDepositRailTokenEnum>[
  _$arbitrumDepositRailTokenEnum_USDC,
]);

const ArbitrumDepositRailTokenContractEnum
    _$arbitrumDepositRailTokenContractEnum_n0xaf88d065e77c8cc2239327c5edb3a432268e5831 =
    const ArbitrumDepositRailTokenContractEnum._(
        'n0xaf88d065e77c8cc2239327c5edb3a432268e5831');

ArbitrumDepositRailTokenContractEnum
    _$arbitrumDepositRailTokenContractEnumValueOf(String name) {
  switch (name) {
    case 'n0xaf88d065e77c8cc2239327c5edb3a432268e5831':
      return _$arbitrumDepositRailTokenContractEnum_n0xaf88d065e77c8cc2239327c5edb3a432268e5831;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ArbitrumDepositRailTokenContractEnum>
    _$arbitrumDepositRailTokenContractEnumValues = BuiltSet<
        ArbitrumDepositRailTokenContractEnum>(const <ArbitrumDepositRailTokenContractEnum>[
  _$arbitrumDepositRailTokenContractEnum_n0xaf88d065e77c8cc2239327c5edb3a432268e5831,
]);

const ArbitrumDepositRailTokenDecimalsEnum
    _$arbitrumDepositRailTokenDecimalsEnum_number6 =
    const ArbitrumDepositRailTokenDecimalsEnum._('number6');

ArbitrumDepositRailTokenDecimalsEnum
    _$arbitrumDepositRailTokenDecimalsEnumValueOf(String name) {
  switch (name) {
    case 'number6':
      return _$arbitrumDepositRailTokenDecimalsEnum_number6;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ArbitrumDepositRailTokenDecimalsEnum>
    _$arbitrumDepositRailTokenDecimalsEnumValues = BuiltSet<
        ArbitrumDepositRailTokenDecimalsEnum>(const <ArbitrumDepositRailTokenDecimalsEnum>[
  _$arbitrumDepositRailTokenDecimalsEnum_number6,
]);

const ArbitrumDepositRailConfirmationsRequiredEnum
    _$arbitrumDepositRailConfirmationsRequiredEnum_number20 =
    const ArbitrumDepositRailConfirmationsRequiredEnum._('number20');

ArbitrumDepositRailConfirmationsRequiredEnum
    _$arbitrumDepositRailConfirmationsRequiredEnumValueOf(String name) {
  switch (name) {
    case 'number20':
      return _$arbitrumDepositRailConfirmationsRequiredEnum_number20;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ArbitrumDepositRailConfirmationsRequiredEnum>
    _$arbitrumDepositRailConfirmationsRequiredEnumValues = BuiltSet<
        ArbitrumDepositRailConfirmationsRequiredEnum>(const <ArbitrumDepositRailConfirmationsRequiredEnum>[
  _$arbitrumDepositRailConfirmationsRequiredEnum_number20,
]);

Serializer<ArbitrumDepositRailChainEnum>
    _$arbitrumDepositRailChainEnumSerializer =
    _$ArbitrumDepositRailChainEnumSerializer();
Serializer<ArbitrumDepositRailChainIdEnum>
    _$arbitrumDepositRailChainIdEnumSerializer =
    _$ArbitrumDepositRailChainIdEnumSerializer();
Serializer<ArbitrumDepositRailTokenEnum>
    _$arbitrumDepositRailTokenEnumSerializer =
    _$ArbitrumDepositRailTokenEnumSerializer();
Serializer<ArbitrumDepositRailTokenContractEnum>
    _$arbitrumDepositRailTokenContractEnumSerializer =
    _$ArbitrumDepositRailTokenContractEnumSerializer();
Serializer<ArbitrumDepositRailTokenDecimalsEnum>
    _$arbitrumDepositRailTokenDecimalsEnumSerializer =
    _$ArbitrumDepositRailTokenDecimalsEnumSerializer();
Serializer<ArbitrumDepositRailConfirmationsRequiredEnum>
    _$arbitrumDepositRailConfirmationsRequiredEnumSerializer =
    _$ArbitrumDepositRailConfirmationsRequiredEnumSerializer();

class _$ArbitrumDepositRailChainEnumSerializer
    implements PrimitiveSerializer<ArbitrumDepositRailChainEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'arbitrum': 'Arbitrum',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Arbitrum': 'arbitrum',
  };

  @override
  final Iterable<Type> types = const <Type>[ArbitrumDepositRailChainEnum];
  @override
  final String wireName = 'ArbitrumDepositRailChainEnum';

  @override
  Object serialize(Serializers serializers, ArbitrumDepositRailChainEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ArbitrumDepositRailChainEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ArbitrumDepositRailChainEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ArbitrumDepositRailChainIdEnumSerializer
    implements PrimitiveSerializer<ArbitrumDepositRailChainIdEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number42161': 42161,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    42161: 'number42161',
  };

  @override
  final Iterable<Type> types = const <Type>[ArbitrumDepositRailChainIdEnum];
  @override
  final String wireName = 'ArbitrumDepositRailChainIdEnum';

  @override
  Object serialize(
          Serializers serializers, ArbitrumDepositRailChainIdEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ArbitrumDepositRailChainIdEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ArbitrumDepositRailChainIdEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ArbitrumDepositRailTokenEnumSerializer
    implements PrimitiveSerializer<ArbitrumDepositRailTokenEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
  };

  @override
  final Iterable<Type> types = const <Type>[ArbitrumDepositRailTokenEnum];
  @override
  final String wireName = 'ArbitrumDepositRailTokenEnum';

  @override
  Object serialize(Serializers serializers, ArbitrumDepositRailTokenEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ArbitrumDepositRailTokenEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ArbitrumDepositRailTokenEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ArbitrumDepositRailTokenContractEnumSerializer
    implements PrimitiveSerializer<ArbitrumDepositRailTokenContractEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n0xaf88d065e77c8cc2239327c5edb3a432268e5831':
        '0xaf88d065e77c8cc2239327c5edb3a432268e5831',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '0xaf88d065e77c8cc2239327c5edb3a432268e5831':
        'n0xaf88d065e77c8cc2239327c5edb3a432268e5831',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ArbitrumDepositRailTokenContractEnum
  ];
  @override
  final String wireName = 'ArbitrumDepositRailTokenContractEnum';

  @override
  Object serialize(
          Serializers serializers, ArbitrumDepositRailTokenContractEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ArbitrumDepositRailTokenContractEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ArbitrumDepositRailTokenContractEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ArbitrumDepositRailTokenDecimalsEnumSerializer
    implements PrimitiveSerializer<ArbitrumDepositRailTokenDecimalsEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number6': 6,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    6: 'number6',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ArbitrumDepositRailTokenDecimalsEnum
  ];
  @override
  final String wireName = 'ArbitrumDepositRailTokenDecimalsEnum';

  @override
  Object serialize(
          Serializers serializers, ArbitrumDepositRailTokenDecimalsEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ArbitrumDepositRailTokenDecimalsEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ArbitrumDepositRailTokenDecimalsEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ArbitrumDepositRailConfirmationsRequiredEnumSerializer
    implements
        PrimitiveSerializer<ArbitrumDepositRailConfirmationsRequiredEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number20': 20,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    20: 'number20',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ArbitrumDepositRailConfirmationsRequiredEnum
  ];
  @override
  final String wireName = 'ArbitrumDepositRailConfirmationsRequiredEnum';

  @override
  Object serialize(Serializers serializers,
          ArbitrumDepositRailConfirmationsRequiredEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ArbitrumDepositRailConfirmationsRequiredEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ArbitrumDepositRailConfirmationsRequiredEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ArbitrumDepositRail extends ArbitrumDepositRail {
  @override
  final String chain;
  @override
  final int chainId;
  @override
  final String token;
  @override
  final String tokenContract;
  @override
  final int tokenDecimals;
  @override
  final String minimumAmount;
  @override
  final int confirmationsRequired;
  @override
  final DepositRailAvailability availability;

  factory _$ArbitrumDepositRail(
          [void Function(ArbitrumDepositRailBuilder)? updates]) =>
      (ArbitrumDepositRailBuilder()..update(updates))._build();

  _$ArbitrumDepositRail._(
      {required this.chain,
      required this.chainId,
      required this.token,
      required this.tokenContract,
      required this.tokenDecimals,
      required this.minimumAmount,
      required this.confirmationsRequired,
      required this.availability})
      : super._();
  @override
  ArbitrumDepositRail rebuild(
          void Function(ArbitrumDepositRailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ArbitrumDepositRailBuilder toBuilder() =>
      ArbitrumDepositRailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ArbitrumDepositRail &&
        chain == other.chain &&
        chainId == other.chainId &&
        token == other.token &&
        tokenContract == other.tokenContract &&
        tokenDecimals == other.tokenDecimals &&
        minimumAmount == other.minimumAmount &&
        confirmationsRequired == other.confirmationsRequired &&
        availability == other.availability;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, tokenContract.hashCode);
    _$hash = $jc(_$hash, tokenDecimals.hashCode);
    _$hash = $jc(_$hash, minimumAmount.hashCode);
    _$hash = $jc(_$hash, confirmationsRequired.hashCode);
    _$hash = $jc(_$hash, availability.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ArbitrumDepositRail')
          ..add('chain', chain)
          ..add('chainId', chainId)
          ..add('token', token)
          ..add('tokenContract', tokenContract)
          ..add('tokenDecimals', tokenDecimals)
          ..add('minimumAmount', minimumAmount)
          ..add('confirmationsRequired', confirmationsRequired)
          ..add('availability', availability))
        .toString();
  }
}

class ArbitrumDepositRailBuilder
    implements
        Builder<ArbitrumDepositRail, ArbitrumDepositRailBuilder>,
        DepositRailBaseBuilder {
  _$ArbitrumDepositRail? _$v;

  String? _chain;
  String? get chain => _$this._chain;
  set chain(covariant String? chain) => _$this._chain = chain;

  int? _chainId;
  int? get chainId => _$this._chainId;
  set chainId(covariant int? chainId) => _$this._chainId = chainId;

  String? _token;
  String? get token => _$this._token;
  set token(covariant String? token) => _$this._token = token;

  String? _tokenContract;
  String? get tokenContract => _$this._tokenContract;
  set tokenContract(covariant String? tokenContract) =>
      _$this._tokenContract = tokenContract;

  int? _tokenDecimals;
  int? get tokenDecimals => _$this._tokenDecimals;
  set tokenDecimals(covariant int? tokenDecimals) =>
      _$this._tokenDecimals = tokenDecimals;

  String? _minimumAmount;
  String? get minimumAmount => _$this._minimumAmount;
  set minimumAmount(covariant String? minimumAmount) =>
      _$this._minimumAmount = minimumAmount;

  int? _confirmationsRequired;
  int? get confirmationsRequired => _$this._confirmationsRequired;
  set confirmationsRequired(covariant int? confirmationsRequired) =>
      _$this._confirmationsRequired = confirmationsRequired;

  DepositRailAvailabilityBuilder? _availability;
  DepositRailAvailabilityBuilder get availability =>
      _$this._availability ??= DepositRailAvailabilityBuilder();
  set availability(covariant DepositRailAvailabilityBuilder? availability) =>
      _$this._availability = availability;

  ArbitrumDepositRailBuilder() {
    ArbitrumDepositRail._defaults(this);
  }

  ArbitrumDepositRailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _chain = $v.chain;
      _chainId = $v.chainId;
      _token = $v.token;
      _tokenContract = $v.tokenContract;
      _tokenDecimals = $v.tokenDecimals;
      _minimumAmount = $v.minimumAmount;
      _confirmationsRequired = $v.confirmationsRequired;
      _availability = $v.availability.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant ArbitrumDepositRail other) {
    _$v = other as _$ArbitrumDepositRail;
  }

  @override
  void update(void Function(ArbitrumDepositRailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ArbitrumDepositRail build() => _build();

  _$ArbitrumDepositRail _build() {
    _$ArbitrumDepositRail _$result;
    try {
      _$result = _$v ??
          _$ArbitrumDepositRail._(
            chain: BuiltValueNullFieldError.checkNotNull(
                chain, r'ArbitrumDepositRail', 'chain'),
            chainId: BuiltValueNullFieldError.checkNotNull(
                chainId, r'ArbitrumDepositRail', 'chainId'),
            token: BuiltValueNullFieldError.checkNotNull(
                token, r'ArbitrumDepositRail', 'token'),
            tokenContract: BuiltValueNullFieldError.checkNotNull(
                tokenContract, r'ArbitrumDepositRail', 'tokenContract'),
            tokenDecimals: BuiltValueNullFieldError.checkNotNull(
                tokenDecimals, r'ArbitrumDepositRail', 'tokenDecimals'),
            minimumAmount: BuiltValueNullFieldError.checkNotNull(
                minimumAmount, r'ArbitrumDepositRail', 'minimumAmount'),
            confirmationsRequired: BuiltValueNullFieldError.checkNotNull(
                confirmationsRequired,
                r'ArbitrumDepositRail',
                'confirmationsRequired'),
            availability: availability.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'availability';
        availability.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ArbitrumDepositRail', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
