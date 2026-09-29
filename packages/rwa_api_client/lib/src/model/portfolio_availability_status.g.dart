// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_availability_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioAvailabilityStatus _$available =
    const PortfolioAvailabilityStatus._('available');
const PortfolioAvailabilityStatus _$partial =
    const PortfolioAvailabilityStatus._('partial');
const PortfolioAvailabilityStatus _$unavailable =
    const PortfolioAvailabilityStatus._('unavailable');

PortfolioAvailabilityStatus _$valueOf(String name) {
  switch (name) {
    case 'available':
      return _$available;
    case 'partial':
      return _$partial;
    case 'unavailable':
      return _$unavailable;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PortfolioAvailabilityStatus> _$values =
    BuiltSet<PortfolioAvailabilityStatus>(const <PortfolioAvailabilityStatus>[
  _$available,
  _$partial,
  _$unavailable,
]);

class _$PortfolioAvailabilityStatusMeta {
  const _$PortfolioAvailabilityStatusMeta();
  PortfolioAvailabilityStatus get available => _$available;
  PortfolioAvailabilityStatus get partial => _$partial;
  PortfolioAvailabilityStatus get unavailable => _$unavailable;
  PortfolioAvailabilityStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<PortfolioAvailabilityStatus> get values => _$values;
}

abstract class _$PortfolioAvailabilityStatusMixin {
  // ignore: non_constant_identifier_names
  _$PortfolioAvailabilityStatusMeta get PortfolioAvailabilityStatus =>
      const _$PortfolioAvailabilityStatusMeta();
}

Serializer<PortfolioAvailabilityStatus>
    _$portfolioAvailabilityStatusSerializer =
    _$PortfolioAvailabilityStatusSerializer();

class _$PortfolioAvailabilityStatusSerializer
    implements PrimitiveSerializer<PortfolioAvailabilityStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'available': 'available',
    'partial': 'partial',
    'unavailable': 'unavailable',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'available': 'available',
    'partial': 'partial',
    'unavailable': 'unavailable',
  };

  @override
  final Iterable<Type> types = const <Type>[PortfolioAvailabilityStatus];
  @override
  final String wireName = 'PortfolioAvailabilityStatus';

  @override
  Object serialize(Serializers serializers, PortfolioAvailabilityStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioAvailabilityStatus deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioAvailabilityStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
