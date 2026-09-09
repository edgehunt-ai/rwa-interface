// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_trigger_spec.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3TriggerSpecTriggerReferenceEnum
    _$hip3TriggerSpecTriggerReferenceEnum_mark =
    const Hip3TriggerSpecTriggerReferenceEnum._('mark');
const Hip3TriggerSpecTriggerReferenceEnum
    _$hip3TriggerSpecTriggerReferenceEnum_oracle =
    const Hip3TriggerSpecTriggerReferenceEnum._('oracle');
const Hip3TriggerSpecTriggerReferenceEnum
    _$hip3TriggerSpecTriggerReferenceEnum_last =
    const Hip3TriggerSpecTriggerReferenceEnum._('last');
const Hip3TriggerSpecTriggerReferenceEnum
    _$hip3TriggerSpecTriggerReferenceEnum_unknownDefaultOpenApi =
    const Hip3TriggerSpecTriggerReferenceEnum._('unknownDefaultOpenApi');

Hip3TriggerSpecTriggerReferenceEnum
    _$hip3TriggerSpecTriggerReferenceEnumValueOf(String name) {
  switch (name) {
    case 'mark':
      return _$hip3TriggerSpecTriggerReferenceEnum_mark;
    case 'oracle':
      return _$hip3TriggerSpecTriggerReferenceEnum_oracle;
    case 'last':
      return _$hip3TriggerSpecTriggerReferenceEnum_last;
    case 'unknownDefaultOpenApi':
      return _$hip3TriggerSpecTriggerReferenceEnum_unknownDefaultOpenApi;
    default:
      return _$hip3TriggerSpecTriggerReferenceEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3TriggerSpecTriggerReferenceEnum>
    _$hip3TriggerSpecTriggerReferenceEnumValues = BuiltSet<
        Hip3TriggerSpecTriggerReferenceEnum>(const <Hip3TriggerSpecTriggerReferenceEnum>[
  _$hip3TriggerSpecTriggerReferenceEnum_mark,
  _$hip3TriggerSpecTriggerReferenceEnum_oracle,
  _$hip3TriggerSpecTriggerReferenceEnum_last,
  _$hip3TriggerSpecTriggerReferenceEnum_unknownDefaultOpenApi,
]);

const Hip3TriggerSpecExecutionTypeEnum
    _$hip3TriggerSpecExecutionTypeEnum_market =
    const Hip3TriggerSpecExecutionTypeEnum._('market');
const Hip3TriggerSpecExecutionTypeEnum
    _$hip3TriggerSpecExecutionTypeEnum_limit =
    const Hip3TriggerSpecExecutionTypeEnum._('limit');
const Hip3TriggerSpecExecutionTypeEnum
    _$hip3TriggerSpecExecutionTypeEnum_unknownDefaultOpenApi =
    const Hip3TriggerSpecExecutionTypeEnum._('unknownDefaultOpenApi');

Hip3TriggerSpecExecutionTypeEnum _$hip3TriggerSpecExecutionTypeEnumValueOf(
    String name) {
  switch (name) {
    case 'market':
      return _$hip3TriggerSpecExecutionTypeEnum_market;
    case 'limit':
      return _$hip3TriggerSpecExecutionTypeEnum_limit;
    case 'unknownDefaultOpenApi':
      return _$hip3TriggerSpecExecutionTypeEnum_unknownDefaultOpenApi;
    default:
      return _$hip3TriggerSpecExecutionTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3TriggerSpecExecutionTypeEnum>
    _$hip3TriggerSpecExecutionTypeEnumValues = BuiltSet<
        Hip3TriggerSpecExecutionTypeEnum>(const <Hip3TriggerSpecExecutionTypeEnum>[
  _$hip3TriggerSpecExecutionTypeEnum_market,
  _$hip3TriggerSpecExecutionTypeEnum_limit,
  _$hip3TriggerSpecExecutionTypeEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3TriggerSpecTriggerReferenceEnum>
    _$hip3TriggerSpecTriggerReferenceEnumSerializer =
    _$Hip3TriggerSpecTriggerReferenceEnumSerializer();
Serializer<Hip3TriggerSpecExecutionTypeEnum>
    _$hip3TriggerSpecExecutionTypeEnumSerializer =
    _$Hip3TriggerSpecExecutionTypeEnumSerializer();

class _$Hip3TriggerSpecTriggerReferenceEnumSerializer
    implements PrimitiveSerializer<Hip3TriggerSpecTriggerReferenceEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'mark': 'mark',
    'oracle': 'oracle',
    'last': 'last',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'mark': 'mark',
    'oracle': 'oracle',
    'last': 'last',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3TriggerSpecTriggerReferenceEnum
  ];
  @override
  final String wireName = 'Hip3TriggerSpecTriggerReferenceEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3TriggerSpecTriggerReferenceEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3TriggerSpecTriggerReferenceEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3TriggerSpecTriggerReferenceEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3TriggerSpecExecutionTypeEnumSerializer
    implements PrimitiveSerializer<Hip3TriggerSpecExecutionTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'market': 'market',
    'limit': 'limit',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'market': 'market',
    'limit': 'limit',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3TriggerSpecExecutionTypeEnum];
  @override
  final String wireName = 'Hip3TriggerSpecExecutionTypeEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3TriggerSpecExecutionTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3TriggerSpecExecutionTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3TriggerSpecExecutionTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3TriggerSpec extends Hip3TriggerSpec {
  @override
  final String? triggerPrice;
  @override
  final String? priceChangePercent;
  @override
  final Hip3TriggerSpecTriggerReferenceEnum triggerReference;
  @override
  final Hip3TriggerSpecExecutionTypeEnum executionType;
  @override
  final String? limitPrice;

  factory _$Hip3TriggerSpec([void Function(Hip3TriggerSpecBuilder)? updates]) =>
      (Hip3TriggerSpecBuilder()..update(updates))._build();

  _$Hip3TriggerSpec._(
      {this.triggerPrice,
      this.priceChangePercent,
      required this.triggerReference,
      required this.executionType,
      this.limitPrice})
      : super._();
  @override
  Hip3TriggerSpec rebuild(void Function(Hip3TriggerSpecBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3TriggerSpecBuilder toBuilder() => Hip3TriggerSpecBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3TriggerSpec &&
        triggerPrice == other.triggerPrice &&
        priceChangePercent == other.priceChangePercent &&
        triggerReference == other.triggerReference &&
        executionType == other.executionType &&
        limitPrice == other.limitPrice;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, triggerPrice.hashCode);
    _$hash = $jc(_$hash, priceChangePercent.hashCode);
    _$hash = $jc(_$hash, triggerReference.hashCode);
    _$hash = $jc(_$hash, executionType.hashCode);
    _$hash = $jc(_$hash, limitPrice.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3TriggerSpec')
          ..add('triggerPrice', triggerPrice)
          ..add('priceChangePercent', priceChangePercent)
          ..add('triggerReference', triggerReference)
          ..add('executionType', executionType)
          ..add('limitPrice', limitPrice))
        .toString();
  }
}

class Hip3TriggerSpecBuilder
    implements Builder<Hip3TriggerSpec, Hip3TriggerSpecBuilder> {
  _$Hip3TriggerSpec? _$v;

  String? _triggerPrice;
  String? get triggerPrice => _$this._triggerPrice;
  set triggerPrice(String? triggerPrice) => _$this._triggerPrice = triggerPrice;

  String? _priceChangePercent;
  String? get priceChangePercent => _$this._priceChangePercent;
  set priceChangePercent(String? priceChangePercent) =>
      _$this._priceChangePercent = priceChangePercent;

  Hip3TriggerSpecTriggerReferenceEnum? _triggerReference;
  Hip3TriggerSpecTriggerReferenceEnum? get triggerReference =>
      _$this._triggerReference;
  set triggerReference(Hip3TriggerSpecTriggerReferenceEnum? triggerReference) =>
      _$this._triggerReference = triggerReference;

  Hip3TriggerSpecExecutionTypeEnum? _executionType;
  Hip3TriggerSpecExecutionTypeEnum? get executionType => _$this._executionType;
  set executionType(Hip3TriggerSpecExecutionTypeEnum? executionType) =>
      _$this._executionType = executionType;

  String? _limitPrice;
  String? get limitPrice => _$this._limitPrice;
  set limitPrice(String? limitPrice) => _$this._limitPrice = limitPrice;

  Hip3TriggerSpecBuilder() {
    Hip3TriggerSpec._defaults(this);
  }

  Hip3TriggerSpecBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _triggerPrice = $v.triggerPrice;
      _priceChangePercent = $v.priceChangePercent;
      _triggerReference = $v.triggerReference;
      _executionType = $v.executionType;
      _limitPrice = $v.limitPrice;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3TriggerSpec other) {
    _$v = other as _$Hip3TriggerSpec;
  }

  @override
  void update(void Function(Hip3TriggerSpecBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3TriggerSpec build() => _build();

  _$Hip3TriggerSpec _build() {
    final _$result = _$v ??
        _$Hip3TriggerSpec._(
          triggerPrice: triggerPrice,
          priceChangePercent: priceChangePercent,
          triggerReference: BuiltValueNullFieldError.checkNotNull(
              triggerReference, r'Hip3TriggerSpec', 'triggerReference'),
          executionType: BuiltValueNullFieldError.checkNotNull(
              executionType, r'Hip3TriggerSpec', 'executionType'),
          limitPrice: limitPrice,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
