//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'deposit_rail_blocker.g.dart';

class DepositRailBlocker extends EnumClass {

  @BuiltValueEnumConst(wireName: r'observer_disabled')
  static const DepositRailBlocker observerDisabled = _$observerDisabled;
  @BuiltValueEnumConst(wireName: r'rpc_unavailable')
  static const DepositRailBlocker rpcUnavailable = _$rpcUnavailable;
  @BuiltValueEnumConst(wireName: r'chain_id_mismatch')
  static const DepositRailBlocker chainIdMismatch = _$chainIdMismatch;
  @BuiltValueEnumConst(wireName: r'token_contract_unavailable')
  static const DepositRailBlocker tokenContractUnavailable = _$tokenContractUnavailable;
  @BuiltValueEnumConst(wireName: r'token_metadata_mismatch')
  static const DepositRailBlocker tokenMetadataMismatch = _$tokenMetadataMismatch;
  @BuiltValueEnumConst(wireName: r'wallet_unavailable')
  static const DepositRailBlocker walletUnavailable = _$walletUnavailable;
  @BuiltValueEnumConst(wireName: r'activity_pipeline_unavailable')
  static const DepositRailBlocker activityPipelineUnavailable = _$activityPipelineUnavailable;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DepositRailBlocker unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<DepositRailBlocker> get serializer => _$depositRailBlockerSerializer;

  const DepositRailBlocker._(String name): super(name);

  static BuiltSet<DepositRailBlocker> get values => _$values;
  static DepositRailBlocker valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class DepositRailBlockerMixin = Object with _$DepositRailBlockerMixin;

