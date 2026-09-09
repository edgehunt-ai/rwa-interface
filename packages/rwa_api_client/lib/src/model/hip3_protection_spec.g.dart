// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_protection_spec.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3ProtectionSpecSizeModeEnum
    _$hip3ProtectionSpecSizeModeEnum_entirePosition =
    const Hip3ProtectionSpecSizeModeEnum._('entirePosition');
const Hip3ProtectionSpecSizeModeEnum _$hip3ProtectionSpecSizeModeEnum_quantity =
    const Hip3ProtectionSpecSizeModeEnum._('quantity');
const Hip3ProtectionSpecSizeModeEnum _$hip3ProtectionSpecSizeModeEnum_percent =
    const Hip3ProtectionSpecSizeModeEnum._('percent');
const Hip3ProtectionSpecSizeModeEnum
    _$hip3ProtectionSpecSizeModeEnum_unknownDefaultOpenApi =
    const Hip3ProtectionSpecSizeModeEnum._('unknownDefaultOpenApi');

Hip3ProtectionSpecSizeModeEnum _$hip3ProtectionSpecSizeModeEnumValueOf(
    String name) {
  switch (name) {
    case 'entirePosition':
      return _$hip3ProtectionSpecSizeModeEnum_entirePosition;
    case 'quantity':
      return _$hip3ProtectionSpecSizeModeEnum_quantity;
    case 'percent':
      return _$hip3ProtectionSpecSizeModeEnum_percent;
    case 'unknownDefaultOpenApi':
      return _$hip3ProtectionSpecSizeModeEnum_unknownDefaultOpenApi;
    default:
      return _$hip3ProtectionSpecSizeModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3ProtectionSpecSizeModeEnum>
    _$hip3ProtectionSpecSizeModeEnumValues = BuiltSet<
        Hip3ProtectionSpecSizeModeEnum>(const <Hip3ProtectionSpecSizeModeEnum>[
  _$hip3ProtectionSpecSizeModeEnum_entirePosition,
  _$hip3ProtectionSpecSizeModeEnum_quantity,
  _$hip3ProtectionSpecSizeModeEnum_percent,
  _$hip3ProtectionSpecSizeModeEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3ProtectionSpecSizeModeEnum>
    _$hip3ProtectionSpecSizeModeEnumSerializer =
    _$Hip3ProtectionSpecSizeModeEnumSerializer();

class _$Hip3ProtectionSpecSizeModeEnumSerializer
    implements PrimitiveSerializer<Hip3ProtectionSpecSizeModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'entirePosition': 'entire_position',
    'quantity': 'quantity',
    'percent': 'percent',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'entire_position': 'entirePosition',
    'quantity': 'quantity',
    'percent': 'percent',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3ProtectionSpecSizeModeEnum];
  @override
  final String wireName = 'Hip3ProtectionSpecSizeModeEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3ProtectionSpecSizeModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3ProtectionSpecSizeModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3ProtectionSpecSizeModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3ProtectionSpec extends Hip3ProtectionSpec {
  @override
  final Hip3ProtectionSpecSizeModeEnum sizeMode;
  @override
  final String? quantity;
  @override
  final String? percent;
  @override
  final Hip3TriggerSpec? takeProfit;
  @override
  final Hip3TriggerSpec? stopLoss;

  factory _$Hip3ProtectionSpec(
          [void Function(Hip3ProtectionSpecBuilder)? updates]) =>
      (Hip3ProtectionSpecBuilder()..update(updates))._build();

  _$Hip3ProtectionSpec._(
      {required this.sizeMode,
      this.quantity,
      this.percent,
      this.takeProfit,
      this.stopLoss})
      : super._();
  @override
  Hip3ProtectionSpec rebuild(
          void Function(Hip3ProtectionSpecBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3ProtectionSpecBuilder toBuilder() =>
      Hip3ProtectionSpecBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3ProtectionSpec &&
        sizeMode == other.sizeMode &&
        quantity == other.quantity &&
        percent == other.percent &&
        takeProfit == other.takeProfit &&
        stopLoss == other.stopLoss;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sizeMode.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, percent.hashCode);
    _$hash = $jc(_$hash, takeProfit.hashCode);
    _$hash = $jc(_$hash, stopLoss.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3ProtectionSpec')
          ..add('sizeMode', sizeMode)
          ..add('quantity', quantity)
          ..add('percent', percent)
          ..add('takeProfit', takeProfit)
          ..add('stopLoss', stopLoss))
        .toString();
  }
}

class Hip3ProtectionSpecBuilder
    implements Builder<Hip3ProtectionSpec, Hip3ProtectionSpecBuilder> {
  _$Hip3ProtectionSpec? _$v;

  Hip3ProtectionSpecSizeModeEnum? _sizeMode;
  Hip3ProtectionSpecSizeModeEnum? get sizeMode => _$this._sizeMode;
  set sizeMode(Hip3ProtectionSpecSizeModeEnum? sizeMode) =>
      _$this._sizeMode = sizeMode;

  String? _quantity;
  String? get quantity => _$this._quantity;
  set quantity(String? quantity) => _$this._quantity = quantity;

  String? _percent;
  String? get percent => _$this._percent;
  set percent(String? percent) => _$this._percent = percent;

  Hip3TriggerSpecBuilder? _takeProfit;
  Hip3TriggerSpecBuilder get takeProfit =>
      _$this._takeProfit ??= Hip3TriggerSpecBuilder();
  set takeProfit(Hip3TriggerSpecBuilder? takeProfit) =>
      _$this._takeProfit = takeProfit;

  Hip3TriggerSpecBuilder? _stopLoss;
  Hip3TriggerSpecBuilder get stopLoss =>
      _$this._stopLoss ??= Hip3TriggerSpecBuilder();
  set stopLoss(Hip3TriggerSpecBuilder? stopLoss) => _$this._stopLoss = stopLoss;

  Hip3ProtectionSpecBuilder() {
    Hip3ProtectionSpec._defaults(this);
  }

  Hip3ProtectionSpecBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sizeMode = $v.sizeMode;
      _quantity = $v.quantity;
      _percent = $v.percent;
      _takeProfit = $v.takeProfit?.toBuilder();
      _stopLoss = $v.stopLoss?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3ProtectionSpec other) {
    _$v = other as _$Hip3ProtectionSpec;
  }

  @override
  void update(void Function(Hip3ProtectionSpecBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3ProtectionSpec build() => _build();

  _$Hip3ProtectionSpec _build() {
    _$Hip3ProtectionSpec _$result;
    try {
      _$result = _$v ??
          _$Hip3ProtectionSpec._(
            sizeMode: BuiltValueNullFieldError.checkNotNull(
                sizeMode, r'Hip3ProtectionSpec', 'sizeMode'),
            quantity: quantity,
            percent: percent,
            takeProfit: _takeProfit?.build(),
            stopLoss: _stopLoss?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'takeProfit';
        _takeProfit?.build();
        _$failedField = 'stopLoss';
        _stopLoss?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3ProtectionSpec', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
