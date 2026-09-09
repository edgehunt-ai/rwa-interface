//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'session_kind.g.dart';

class SessionKind extends EnumClass {

  /// 美股交易时段：盘前 / 开盘 / 盘后 / 隔夜 / 周末休市 / 节假日休市
  @BuiltValueEnumConst(wireName: r'premarket')
  static const SessionKind premarket = _$premarket;
  /// 美股交易时段：盘前 / 开盘 / 盘后 / 隔夜 / 周末休市 / 节假日休市
  @BuiltValueEnumConst(wireName: r'regular')
  static const SessionKind regular = _$regular;
  /// 美股交易时段：盘前 / 开盘 / 盘后 / 隔夜 / 周末休市 / 节假日休市
  @BuiltValueEnumConst(wireName: r'after')
  static const SessionKind after = _$after;
  /// 美股交易时段：盘前 / 开盘 / 盘后 / 隔夜 / 周末休市 / 节假日休市
  @BuiltValueEnumConst(wireName: r'overnight')
  static const SessionKind overnight = _$overnight;
  /// 美股交易时段：盘前 / 开盘 / 盘后 / 隔夜 / 周末休市 / 节假日休市
  @BuiltValueEnumConst(wireName: r'weekend')
  static const SessionKind weekend = _$weekend;
  /// 美股交易时段：盘前 / 开盘 / 盘后 / 隔夜 / 周末休市 / 节假日休市
  @BuiltValueEnumConst(wireName: r'holiday')
  static const SessionKind holiday = _$holiday;
  /// 美股交易时段：盘前 / 开盘 / 盘后 / 隔夜 / 周末休市 / 节假日休市
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SessionKind unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<SessionKind> get serializer => _$sessionKindSerializer;

  const SessionKind._(String name): super(name);

  static BuiltSet<SessionKind> get values => _$values;
  static SessionKind valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class SessionKindMixin = Object with _$SessionKindMixin;

