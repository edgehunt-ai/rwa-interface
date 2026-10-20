// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'native_delivery_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NativeDeliveryState _$prepared = const NativeDeliveryState._('prepared');
const NativeDeliveryState _$dispatching =
    const NativeDeliveryState._('dispatching');
const NativeDeliveryState _$rejected = const NativeDeliveryState._('rejected');
const NativeDeliveryState _$voided = const NativeDeliveryState._('voided');
const NativeDeliveryState _$cancelled =
    const NativeDeliveryState._('cancelled');

NativeDeliveryState _$valueOf(String name) {
  switch (name) {
    case 'prepared':
      return _$prepared;
    case 'dispatching':
      return _$dispatching;
    case 'rejected':
      return _$rejected;
    case 'voided':
      return _$voided;
    case 'cancelled':
      return _$cancelled;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<NativeDeliveryState> _$values =
    BuiltSet<NativeDeliveryState>(const <NativeDeliveryState>[
  _$prepared,
  _$dispatching,
  _$rejected,
  _$voided,
  _$cancelled,
]);

class _$NativeDeliveryStateMeta {
  const _$NativeDeliveryStateMeta();
  NativeDeliveryState get prepared => _$prepared;
  NativeDeliveryState get dispatching => _$dispatching;
  NativeDeliveryState get rejected => _$rejected;
  NativeDeliveryState get voided => _$voided;
  NativeDeliveryState get cancelled => _$cancelled;
  NativeDeliveryState valueOf(String name) => _$valueOf(name);
  BuiltSet<NativeDeliveryState> get values => _$values;
}

abstract class _$NativeDeliveryStateMixin {
  // ignore: non_constant_identifier_names
  _$NativeDeliveryStateMeta get NativeDeliveryState =>
      const _$NativeDeliveryStateMeta();
}

Serializer<NativeDeliveryState> _$nativeDeliveryStateSerializer =
    _$NativeDeliveryStateSerializer();

class _$NativeDeliveryStateSerializer
    implements PrimitiveSerializer<NativeDeliveryState> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'prepared': 'prepared',
    'dispatching': 'dispatching',
    'rejected': 'rejected',
    'voided': 'voided',
    'cancelled': 'cancelled',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'prepared': 'prepared',
    'dispatching': 'dispatching',
    'rejected': 'rejected',
    'voided': 'voided',
    'cancelled': 'cancelled',
  };

  @override
  final Iterable<Type> types = const <Type>[NativeDeliveryState];
  @override
  final String wireName = 'NativeDeliveryState';

  @override
  Object serialize(Serializers serializers, NativeDeliveryState object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  NativeDeliveryState deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      NativeDeliveryState.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
