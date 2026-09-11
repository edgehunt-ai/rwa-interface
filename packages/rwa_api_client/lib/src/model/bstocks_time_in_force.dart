//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_time_in_force.g.dart';

class BstocksTimeInForce extends EnumClass {

  /// bStocks 限价单的有效期。gtc 在 Router 上持续挂单；ioc 在同一笔 Router 交易中立即成交，未成交数量取消。
  @BuiltValueEnumConst(wireName: r'gtc')
  static const BstocksTimeInForce gtc = _$gtc;
  /// bStocks 限价单的有效期。gtc 在 Router 上持续挂单；ioc 在同一笔 Router 交易中立即成交，未成交数量取消。
  @BuiltValueEnumConst(wireName: r'ioc')
  static const BstocksTimeInForce ioc = _$ioc;
  /// bStocks 限价单的有效期。gtc 在 Router 上持续挂单；ioc 在同一笔 Router 交易中立即成交，未成交数量取消。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksTimeInForce unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<BstocksTimeInForce> get serializer => _$bstocksTimeInForceSerializer;

  const BstocksTimeInForce._(String name): super(name);

  static BuiltSet<BstocksTimeInForce> get values => _$values;
  static BstocksTimeInForce valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class BstocksTimeInForceMixin = Object with _$BstocksTimeInForceMixin;

