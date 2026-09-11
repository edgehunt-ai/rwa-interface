//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_private_channel.g.dart';

class RealtimePrivateChannel extends EnumClass {

  /// 当前由账户隔离 PostgreSQL projection 支持的私有频道。
  @BuiltValueEnumConst(wireName: r'orders')
  static const RealtimePrivateChannel orders = _$orders;
  /// 当前由账户隔离 PostgreSQL projection 支持的私有频道。
  @BuiltValueEnumConst(wireName: r'positions')
  static const RealtimePrivateChannel positions = _$positions;
  /// 当前由账户隔离 PostgreSQL projection 支持的私有频道。
  @BuiltValueEnumConst(wireName: r'transfers')
  static const RealtimePrivateChannel transfers = _$transfers;
  /// 当前由账户隔离 PostgreSQL projection 支持的私有频道。
  @BuiltValueEnumConst(wireName: r'claims')
  static const RealtimePrivateChannel claims = _$claims;
  /// 当前由账户隔离 PostgreSQL projection 支持的私有频道。
  @BuiltValueEnumConst(wireName: r'deposits')
  static const RealtimePrivateChannel deposits = _$deposits;
  /// 当前由账户隔离 PostgreSQL projection 支持的私有频道。
  @BuiltValueEnumConst(wireName: r'withdrawals')
  static const RealtimePrivateChannel withdrawals = _$withdrawals;
  /// 当前由账户隔离 PostgreSQL projection 支持的私有频道。
  @BuiltValueEnumConst(wireName: r'balances')
  static const RealtimePrivateChannel balances = _$balances;
  /// 当前由账户隔离 PostgreSQL projection 支持的私有频道。
  @BuiltValueEnumConst(wireName: r'activity')
  static const RealtimePrivateChannel activity = _$activity;
  /// 当前由账户隔离 PostgreSQL projection 支持的私有频道。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RealtimePrivateChannel unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<RealtimePrivateChannel> get serializer => _$realtimePrivateChannelSerializer;

  const RealtimePrivateChannel._(String name): super(name);

  static BuiltSet<RealtimePrivateChannel> get values => _$values;
  static RealtimePrivateChannel valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class RealtimePrivateChannelMixin = Object with _$RealtimePrivateChannelMixin;

