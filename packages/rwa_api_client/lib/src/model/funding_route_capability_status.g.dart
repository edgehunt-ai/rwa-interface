// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_route_capability_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingRouteCapabilityStatus _$available =
    const FundingRouteCapabilityStatus._('available');
const FundingRouteCapabilityStatus _$unavailable =
    const FundingRouteCapabilityStatus._('unavailable');
const FundingRouteCapabilityStatus _$unknownDefaultOpenApi =
    const FundingRouteCapabilityStatus._('unknownDefaultOpenApi');

FundingRouteCapabilityStatus _$valueOf(String name) {
  switch (name) {
    case 'available':
      return _$available;
    case 'unavailable':
      return _$unavailable;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingRouteCapabilityStatus> _$values =
    BuiltSet<FundingRouteCapabilityStatus>(const <FundingRouteCapabilityStatus>[
  _$available,
  _$unavailable,
  _$unknownDefaultOpenApi,
]);

class _$FundingRouteCapabilityStatusMeta {
  const _$FundingRouteCapabilityStatusMeta();
  FundingRouteCapabilityStatus get available => _$available;
  FundingRouteCapabilityStatus get unavailable => _$unavailable;
  FundingRouteCapabilityStatus get unknownDefaultOpenApi =>
      _$unknownDefaultOpenApi;
  FundingRouteCapabilityStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<FundingRouteCapabilityStatus> get values => _$values;
}

abstract class _$FundingRouteCapabilityStatusMixin {
  // ignore: non_constant_identifier_names
  _$FundingRouteCapabilityStatusMeta get FundingRouteCapabilityStatus =>
      const _$FundingRouteCapabilityStatusMeta();
}

Serializer<FundingRouteCapabilityStatus>
    _$fundingRouteCapabilityStatusSerializer =
    _$FundingRouteCapabilityStatusSerializer();

class _$FundingRouteCapabilityStatusSerializer
    implements PrimitiveSerializer<FundingRouteCapabilityStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'available': 'available',
    'unavailable': 'unavailable',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'available': 'available',
    'unavailable': 'unavailable',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingRouteCapabilityStatus];
  @override
  final String wireName = 'FundingRouteCapabilityStatus';

  @override
  Object serialize(Serializers serializers, FundingRouteCapabilityStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingRouteCapabilityStatus deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingRouteCapabilityStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
