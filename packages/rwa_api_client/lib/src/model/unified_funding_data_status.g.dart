// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unified_funding_data_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UnifiedFundingDataStatus _$complete =
    const UnifiedFundingDataStatus._('complete');
const UnifiedFundingDataStatus _$partial =
    const UnifiedFundingDataStatus._('partial');
const UnifiedFundingDataStatus _$unavailable =
    const UnifiedFundingDataStatus._('unavailable');
const UnifiedFundingDataStatus _$unknownDefaultOpenApi =
    const UnifiedFundingDataStatus._('unknownDefaultOpenApi');

UnifiedFundingDataStatus _$valueOf(String name) {
  switch (name) {
    case 'complete':
      return _$complete;
    case 'partial':
      return _$partial;
    case 'unavailable':
      return _$unavailable;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<UnifiedFundingDataStatus> _$values =
    BuiltSet<UnifiedFundingDataStatus>(const <UnifiedFundingDataStatus>[
  _$complete,
  _$partial,
  _$unavailable,
  _$unknownDefaultOpenApi,
]);

class _$UnifiedFundingDataStatusMeta {
  const _$UnifiedFundingDataStatusMeta();
  UnifiedFundingDataStatus get complete => _$complete;
  UnifiedFundingDataStatus get partial => _$partial;
  UnifiedFundingDataStatus get unavailable => _$unavailable;
  UnifiedFundingDataStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  UnifiedFundingDataStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<UnifiedFundingDataStatus> get values => _$values;
}

abstract class _$UnifiedFundingDataStatusMixin {
  // ignore: non_constant_identifier_names
  _$UnifiedFundingDataStatusMeta get UnifiedFundingDataStatus =>
      const _$UnifiedFundingDataStatusMeta();
}

Serializer<UnifiedFundingDataStatus> _$unifiedFundingDataStatusSerializer =
    _$UnifiedFundingDataStatusSerializer();

class _$UnifiedFundingDataStatusSerializer
    implements PrimitiveSerializer<UnifiedFundingDataStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'complete': 'complete',
    'partial': 'partial',
    'unavailable': 'unavailable',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'complete': 'complete',
    'partial': 'partial',
    'unavailable': 'unavailable',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[UnifiedFundingDataStatus];
  @override
  final String wireName = 'UnifiedFundingDataStatus';

  @override
  Object serialize(Serializers serializers, UnifiedFundingDataStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UnifiedFundingDataStatus deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UnifiedFundingDataStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
