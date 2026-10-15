// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_single_protection_spec.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3SingleProtectionSpecSizeModeEnum
    _$hip3SingleProtectionSpecSizeModeEnum_entirePosition =
    const Hip3SingleProtectionSpecSizeModeEnum._('entirePosition');
const Hip3SingleProtectionSpecSizeModeEnum
    _$hip3SingleProtectionSpecSizeModeEnum_quantity =
    const Hip3SingleProtectionSpecSizeModeEnum._('quantity');
const Hip3SingleProtectionSpecSizeModeEnum
    _$hip3SingleProtectionSpecSizeModeEnum_percent =
    const Hip3SingleProtectionSpecSizeModeEnum._('percent');

Hip3SingleProtectionSpecSizeModeEnum
    _$hip3SingleProtectionSpecSizeModeEnumValueOf(String name) {
  switch (name) {
    case 'entirePosition':
      return _$hip3SingleProtectionSpecSizeModeEnum_entirePosition;
    case 'quantity':
      return _$hip3SingleProtectionSpecSizeModeEnum_quantity;
    case 'percent':
      return _$hip3SingleProtectionSpecSizeModeEnum_percent;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3SingleProtectionSpecSizeModeEnum>
    _$hip3SingleProtectionSpecSizeModeEnumValues = BuiltSet<
        Hip3SingleProtectionSpecSizeModeEnum>(const <Hip3SingleProtectionSpecSizeModeEnum>[
  _$hip3SingleProtectionSpecSizeModeEnum_entirePosition,
  _$hip3SingleProtectionSpecSizeModeEnum_quantity,
  _$hip3SingleProtectionSpecSizeModeEnum_percent,
]);

Serializer<Hip3SingleProtectionSpecSizeModeEnum>
    _$hip3SingleProtectionSpecSizeModeEnumSerializer =
    _$Hip3SingleProtectionSpecSizeModeEnumSerializer();

class _$Hip3SingleProtectionSpecSizeModeEnumSerializer
    implements PrimitiveSerializer<Hip3SingleProtectionSpecSizeModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'entirePosition': 'entire_position',
    'quantity': 'quantity',
    'percent': 'percent',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'entire_position': 'entirePosition',
    'quantity': 'quantity',
    'percent': 'percent',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3SingleProtectionSpecSizeModeEnum
  ];
  @override
  final String wireName = 'Hip3SingleProtectionSpecSizeModeEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3SingleProtectionSpecSizeModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3SingleProtectionSpecSizeModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3SingleProtectionSpecSizeModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3SingleProtectionSpec extends Hip3SingleProtectionSpec {
  @override
  final Hip3SingleProtectionSpecSizeModeEnum sizeMode;
  @override
  final String? quantity;
  @override
  final String? percent;
  @override
  final Hip3TriggerSpec? takeProfit;
  @override
  final Hip3TriggerSpec? stopLoss;

  factory _$Hip3SingleProtectionSpec(
          [void Function(Hip3SingleProtectionSpecBuilder)? updates]) =>
      (Hip3SingleProtectionSpecBuilder()..update(updates))._build();

  _$Hip3SingleProtectionSpec._(
      {required this.sizeMode,
      this.quantity,
      this.percent,
      this.takeProfit,
      this.stopLoss})
      : super._();
  @override
  Hip3SingleProtectionSpec rebuild(
          void Function(Hip3SingleProtectionSpecBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3SingleProtectionSpecBuilder toBuilder() =>
      Hip3SingleProtectionSpecBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3SingleProtectionSpec &&
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
    return (newBuiltValueToStringHelper(r'Hip3SingleProtectionSpec')
          ..add('sizeMode', sizeMode)
          ..add('quantity', quantity)
          ..add('percent', percent)
          ..add('takeProfit', takeProfit)
          ..add('stopLoss', stopLoss))
        .toString();
  }
}

class Hip3SingleProtectionSpecBuilder
    implements
        Builder<Hip3SingleProtectionSpec, Hip3SingleProtectionSpecBuilder> {
  _$Hip3SingleProtectionSpec? _$v;

  Hip3SingleProtectionSpecSizeModeEnum? _sizeMode;
  Hip3SingleProtectionSpecSizeModeEnum? get sizeMode => _$this._sizeMode;
  set sizeMode(Hip3SingleProtectionSpecSizeModeEnum? sizeMode) =>
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

  Hip3SingleProtectionSpecBuilder() {
    Hip3SingleProtectionSpec._defaults(this);
  }

  Hip3SingleProtectionSpecBuilder get _$this {
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
  void replace(Hip3SingleProtectionSpec other) {
    _$v = other as _$Hip3SingleProtectionSpec;
  }

  @override
  void update(void Function(Hip3SingleProtectionSpecBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3SingleProtectionSpec build() => _build();

  _$Hip3SingleProtectionSpec _build() {
    _$Hip3SingleProtectionSpec _$result;
    try {
      _$result = _$v ??
          _$Hip3SingleProtectionSpec._(
            sizeMode: BuiltValueNullFieldError.checkNotNull(
                sizeMode, r'Hip3SingleProtectionSpec', 'sizeMode'),
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
            r'Hip3SingleProtectionSpec', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
