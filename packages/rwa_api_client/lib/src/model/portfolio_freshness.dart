//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_freshness.g.dart';

class PortfolioFreshness extends EnumClass {
  /// 数据新鲜度。`live` 来自当前读取，`cached` 来自 fresh PostgreSQL snapshot， `stale` 来自仍在最大 stale 窗口内的 last-good snapshot。
  @BuiltValueEnumConst(wireName: r'live')
  static const PortfolioFreshness live = _$live;

  /// 数据新鲜度。`live` 来自当前读取，`cached` 来自 fresh PostgreSQL snapshot， `stale` 来自仍在最大 stale 窗口内的 last-good snapshot。
  @BuiltValueEnumConst(wireName: r'cached')
  static const PortfolioFreshness cached = _$cached;

  /// 数据新鲜度。`live` 来自当前读取，`cached` 来自 fresh PostgreSQL snapshot， `stale` 来自仍在最大 stale 窗口内的 last-good snapshot。
  @BuiltValueEnumConst(wireName: r'stale')
  static const PortfolioFreshness stale = _$stale;

  /// 数据新鲜度。`live` 来自当前读取，`cached` 来自 fresh PostgreSQL snapshot， `stale` 来自仍在最大 stale 窗口内的 last-good snapshot。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PortfolioFreshness unknownDefaultOpenApi =
      _$unknownDefaultOpenApi;

  static Serializer<PortfolioFreshness> get serializer =>
      _$portfolioFreshnessSerializer;

  const PortfolioFreshness._(String name) : super(name);

  static BuiltSet<PortfolioFreshness> get values => _$values;
  static PortfolioFreshness valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class PortfolioFreshnessMixin = Object with _$PortfolioFreshnessMixin;
