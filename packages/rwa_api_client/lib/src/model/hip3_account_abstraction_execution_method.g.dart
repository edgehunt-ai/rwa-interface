// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_account_abstraction_execution_method.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3AccountAbstractionExecutionMethod _$agent =
    const Hip3AccountAbstractionExecutionMethod._('agent');
const Hip3AccountAbstractionExecutionMethod _$user =
    const Hip3AccountAbstractionExecutionMethod._('user');

Hip3AccountAbstractionExecutionMethod _$valueOf(String name) {
  switch (name) {
    case 'agent':
      return _$agent;
    case 'user':
      return _$user;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3AccountAbstractionExecutionMethod> _$values = BuiltSet<
    Hip3AccountAbstractionExecutionMethod>(const <Hip3AccountAbstractionExecutionMethod>[
  _$agent,
  _$user,
]);

class _$Hip3AccountAbstractionExecutionMethodMeta {
  const _$Hip3AccountAbstractionExecutionMethodMeta();
  Hip3AccountAbstractionExecutionMethod get agent => _$agent;
  Hip3AccountAbstractionExecutionMethod get user => _$user;
  Hip3AccountAbstractionExecutionMethod valueOf(String name) => _$valueOf(name);
  BuiltSet<Hip3AccountAbstractionExecutionMethod> get values => _$values;
}

abstract class _$Hip3AccountAbstractionExecutionMethodMixin {
  // ignore: non_constant_identifier_names
  _$Hip3AccountAbstractionExecutionMethodMeta
      get Hip3AccountAbstractionExecutionMethod =>
          const _$Hip3AccountAbstractionExecutionMethodMeta();
}

Serializer<Hip3AccountAbstractionExecutionMethod>
    _$hip3AccountAbstractionExecutionMethodSerializer =
    _$Hip3AccountAbstractionExecutionMethodSerializer();

class _$Hip3AccountAbstractionExecutionMethodSerializer
    implements PrimitiveSerializer<Hip3AccountAbstractionExecutionMethod> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'agent': 'agent',
    'user': 'user',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'agent': 'agent',
    'user': 'user',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3AccountAbstractionExecutionMethod
  ];
  @override
  final String wireName = 'Hip3AccountAbstractionExecutionMethod';

  @override
  Object serialize(
          Serializers serializers, Hip3AccountAbstractionExecutionMethod object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3AccountAbstractionExecutionMethod deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3AccountAbstractionExecutionMethod.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
