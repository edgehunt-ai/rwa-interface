//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_target_balance_source.g.dart';

class FundingTargetBalanceSource extends EnumClass {
  @BuiltValueEnumConst(wireName: r'bsc_rpc')
  static const FundingTargetBalanceSource bscRpc = _$bscRpc;
  @BuiltValueEnumConst(wireName: r'hyperliquid_info')
  static const FundingTargetBalanceSource hyperliquidInfo = _$hyperliquidInfo;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingTargetBalanceSource unknownDefaultOpenApi =
      _$unknownDefaultOpenApi;

  static Serializer<FundingTargetBalanceSource> get serializer =>
      _$fundingTargetBalanceSourceSerializer;

  const FundingTargetBalanceSource._(String name) : super(name);

  static BuiltSet<FundingTargetBalanceSource> get values => _$values;
  static FundingTargetBalanceSource valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class FundingTargetBalanceSourceMixin = Object
    with _$FundingTargetBalanceSourceMixin;
