//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_time_in_force.g.dart';

class Hip3TimeInForce extends EnumClass {

  /// gtc 持续挂单；ioc 立即成交剩余取消；alo 仅做 maker。market 只允许 ioc；limit 缺省 gtc，不得静默转换为 ioc。
  @BuiltValueEnumConst(wireName: r'gtc')
  static const Hip3TimeInForce gtc = _$gtc;
  /// gtc 持续挂单；ioc 立即成交剩余取消；alo 仅做 maker。market 只允许 ioc；limit 缺省 gtc，不得静默转换为 ioc。
  @BuiltValueEnumConst(wireName: r'ioc')
  static const Hip3TimeInForce ioc = _$ioc;
  /// gtc 持续挂单；ioc 立即成交剩余取消；alo 仅做 maker。market 只允许 ioc；limit 缺省 gtc，不得静默转换为 ioc。
  @BuiltValueEnumConst(wireName: r'alo')
  static const Hip3TimeInForce alo = _$alo;
  /// gtc 持续挂单；ioc 立即成交剩余取消；alo 仅做 maker。market 只允许 ioc；limit 缺省 gtc，不得静默转换为 ioc。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3TimeInForce unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<Hip3TimeInForce> get serializer => _$hip3TimeInForceSerializer;

  const Hip3TimeInForce._(String name): super(name);

  static BuiltSet<Hip3TimeInForce> get values => _$values;
  static Hip3TimeInForce valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class Hip3TimeInForceMixin = Object with _$Hip3TimeInForceMixin;

