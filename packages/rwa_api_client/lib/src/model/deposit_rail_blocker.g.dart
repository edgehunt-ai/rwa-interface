// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_rail_blocker.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DepositRailBlocker _$observerDisabled =
    const DepositRailBlocker._('observerDisabled');
const DepositRailBlocker _$rpcUnavailable =
    const DepositRailBlocker._('rpcUnavailable');
const DepositRailBlocker _$chainIdMismatch =
    const DepositRailBlocker._('chainIdMismatch');
const DepositRailBlocker _$tokenContractUnavailable =
    const DepositRailBlocker._('tokenContractUnavailable');
const DepositRailBlocker _$tokenMetadataMismatch =
    const DepositRailBlocker._('tokenMetadataMismatch');
const DepositRailBlocker _$walletUnavailable =
    const DepositRailBlocker._('walletUnavailable');
const DepositRailBlocker _$activityPipelineUnavailable =
    const DepositRailBlocker._('activityPipelineUnavailable');
const DepositRailBlocker _$unknownDefaultOpenApi =
    const DepositRailBlocker._('unknownDefaultOpenApi');

DepositRailBlocker _$valueOf(String name) {
  switch (name) {
    case 'observerDisabled':
      return _$observerDisabled;
    case 'rpcUnavailable':
      return _$rpcUnavailable;
    case 'chainIdMismatch':
      return _$chainIdMismatch;
    case 'tokenContractUnavailable':
      return _$tokenContractUnavailable;
    case 'tokenMetadataMismatch':
      return _$tokenMetadataMismatch;
    case 'walletUnavailable':
      return _$walletUnavailable;
    case 'activityPipelineUnavailable':
      return _$activityPipelineUnavailable;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<DepositRailBlocker> _$values =
    BuiltSet<DepositRailBlocker>(const <DepositRailBlocker>[
  _$observerDisabled,
  _$rpcUnavailable,
  _$chainIdMismatch,
  _$tokenContractUnavailable,
  _$tokenMetadataMismatch,
  _$walletUnavailable,
  _$activityPipelineUnavailable,
  _$unknownDefaultOpenApi,
]);

class _$DepositRailBlockerMeta {
  const _$DepositRailBlockerMeta();
  DepositRailBlocker get observerDisabled => _$observerDisabled;
  DepositRailBlocker get rpcUnavailable => _$rpcUnavailable;
  DepositRailBlocker get chainIdMismatch => _$chainIdMismatch;
  DepositRailBlocker get tokenContractUnavailable => _$tokenContractUnavailable;
  DepositRailBlocker get tokenMetadataMismatch => _$tokenMetadataMismatch;
  DepositRailBlocker get walletUnavailable => _$walletUnavailable;
  DepositRailBlocker get activityPipelineUnavailable =>
      _$activityPipelineUnavailable;
  DepositRailBlocker get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  DepositRailBlocker valueOf(String name) => _$valueOf(name);
  BuiltSet<DepositRailBlocker> get values => _$values;
}

abstract class _$DepositRailBlockerMixin {
  // ignore: non_constant_identifier_names
  _$DepositRailBlockerMeta get DepositRailBlocker =>
      const _$DepositRailBlockerMeta();
}

Serializer<DepositRailBlocker> _$depositRailBlockerSerializer =
    _$DepositRailBlockerSerializer();

class _$DepositRailBlockerSerializer
    implements PrimitiveSerializer<DepositRailBlocker> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'observerDisabled': 'observer_disabled',
    'rpcUnavailable': 'rpc_unavailable',
    'chainIdMismatch': 'chain_id_mismatch',
    'tokenContractUnavailable': 'token_contract_unavailable',
    'tokenMetadataMismatch': 'token_metadata_mismatch',
    'walletUnavailable': 'wallet_unavailable',
    'activityPipelineUnavailable': 'activity_pipeline_unavailable',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'observer_disabled': 'observerDisabled',
    'rpc_unavailable': 'rpcUnavailable',
    'chain_id_mismatch': 'chainIdMismatch',
    'token_contract_unavailable': 'tokenContractUnavailable',
    'token_metadata_mismatch': 'tokenMetadataMismatch',
    'wallet_unavailable': 'walletUnavailable',
    'activity_pipeline_unavailable': 'activityPipelineUnavailable',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositRailBlocker];
  @override
  final String wireName = 'DepositRailBlocker';

  @override
  Object serialize(Serializers serializers, DepositRailBlocker object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositRailBlocker deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositRailBlocker.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
