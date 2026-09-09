// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_plan_mode.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingPlanMode _$autoSingleSource =
    const FundingPlanMode._('autoSingleSource');
const FundingPlanMode _$unknownDefaultOpenApi =
    const FundingPlanMode._('unknownDefaultOpenApi');

FundingPlanMode _$valueOf(String name) {
  switch (name) {
    case 'autoSingleSource':
      return _$autoSingleSource;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingPlanMode> _$values =
    BuiltSet<FundingPlanMode>(const <FundingPlanMode>[
  _$autoSingleSource,
  _$unknownDefaultOpenApi,
]);

class _$FundingPlanModeMeta {
  const _$FundingPlanModeMeta();
  FundingPlanMode get autoSingleSource => _$autoSingleSource;
  FundingPlanMode get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  FundingPlanMode valueOf(String name) => _$valueOf(name);
  BuiltSet<FundingPlanMode> get values => _$values;
}

abstract class _$FundingPlanModeMixin {
  // ignore: non_constant_identifier_names
  _$FundingPlanModeMeta get FundingPlanMode => const _$FundingPlanModeMeta();
}

Serializer<FundingPlanMode> _$fundingPlanModeSerializer =
    _$FundingPlanModeSerializer();

class _$FundingPlanModeSerializer
    implements PrimitiveSerializer<FundingPlanMode> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'autoSingleSource': 'auto_single_source',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'auto_single_source': 'autoSingleSource',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingPlanMode];
  @override
  final String wireName = 'FundingPlanMode';

  @override
  Object serialize(Serializers serializers, FundingPlanMode object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingPlanMode deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingPlanMode.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
