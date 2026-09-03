// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candle_point.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CandlePoint extends CandlePoint {
  @override
  final DateTime t;
  @override
  final String? o;
  @override
  final String? h;
  @override
  final String? l;
  @override
  final String c;
  @override
  final String? v;

  factory _$CandlePoint([void Function(CandlePointBuilder)? updates]) =>
      (CandlePointBuilder()..update(updates))._build();

  _$CandlePoint._(
      {required this.t, this.o, this.h, this.l, required this.c, this.v})
      : super._();
  @override
  CandlePoint rebuild(void Function(CandlePointBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CandlePointBuilder toBuilder() => CandlePointBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CandlePoint &&
        t == other.t &&
        o == other.o &&
        h == other.h &&
        l == other.l &&
        c == other.c &&
        v == other.v;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, t.hashCode);
    _$hash = $jc(_$hash, o.hashCode);
    _$hash = $jc(_$hash, h.hashCode);
    _$hash = $jc(_$hash, l.hashCode);
    _$hash = $jc(_$hash, c.hashCode);
    _$hash = $jc(_$hash, v.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CandlePoint')
          ..add('t', t)
          ..add('o', o)
          ..add('h', h)
          ..add('l', l)
          ..add('c', c)
          ..add('v', v))
        .toString();
  }
}

class CandlePointBuilder implements Builder<CandlePoint, CandlePointBuilder> {
  _$CandlePoint? _$v;

  DateTime? _t;
  DateTime? get t => _$this._t;
  set t(DateTime? t) => _$this._t = t;

  String? _o;
  String? get o => _$this._o;
  set o(String? o) => _$this._o = o;

  String? _h;
  String? get h => _$this._h;
  set h(String? h) => _$this._h = h;

  String? _l;
  String? get l => _$this._l;
  set l(String? l) => _$this._l = l;

  String? _c;
  String? get c => _$this._c;
  set c(String? c) => _$this._c = c;

  String? _v;
  String? get v => _$this._v;
  set v(String? v) => _$this._v = v;

  CandlePointBuilder() {
    CandlePoint._defaults(this);
  }

  CandlePointBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _t = $v.t;
      _o = $v.o;
      _h = $v.h;
      _l = $v.l;
      _c = $v.c;
      _v = $v.v;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CandlePoint other) {
    _$v = other as _$CandlePoint;
  }

  @override
  void update(void Function(CandlePointBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CandlePoint build() => _build();

  _$CandlePoint _build() {
    final _$result = _$v ??
        _$CandlePoint._(
          t: BuiltValueNullFieldError.checkNotNull(t, r'CandlePoint', 't'),
          o: o,
          h: h,
          l: l,
          c: BuiltValueNullFieldError.checkNotNull(c, r'CandlePoint', 'c'),
          v: v,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
