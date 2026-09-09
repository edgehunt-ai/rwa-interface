// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_notice.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PortfolioNotice extends PortfolioNotice {
  @override
  final PortfolioWarningCode code;
  @override
  final PortfolioNoticeSeverity severity;
  @override
  final String message;
  @override
  final String? userAction;

  factory _$PortfolioNotice([void Function(PortfolioNoticeBuilder)? updates]) =>
      (PortfolioNoticeBuilder()..update(updates))._build();

  _$PortfolioNotice._(
      {required this.code,
      required this.severity,
      required this.message,
      this.userAction})
      : super._();
  @override
  PortfolioNotice rebuild(void Function(PortfolioNoticeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortfolioNoticeBuilder toBuilder() => PortfolioNoticeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortfolioNotice &&
        code == other.code &&
        severity == other.severity &&
        message == other.message &&
        userAction == other.userAction;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, severity.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, userAction.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortfolioNotice')
          ..add('code', code)
          ..add('severity', severity)
          ..add('message', message)
          ..add('userAction', userAction))
        .toString();
  }
}

class PortfolioNoticeBuilder
    implements Builder<PortfolioNotice, PortfolioNoticeBuilder> {
  _$PortfolioNotice? _$v;

  PortfolioWarningCode? _code;
  PortfolioWarningCode? get code => _$this._code;
  set code(PortfolioWarningCode? code) => _$this._code = code;

  PortfolioNoticeSeverity? _severity;
  PortfolioNoticeSeverity? get severity => _$this._severity;
  set severity(PortfolioNoticeSeverity? severity) =>
      _$this._severity = severity;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _userAction;
  String? get userAction => _$this._userAction;
  set userAction(String? userAction) => _$this._userAction = userAction;

  PortfolioNoticeBuilder() {
    PortfolioNotice._defaults(this);
  }

  PortfolioNoticeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _severity = $v.severity;
      _message = $v.message;
      _userAction = $v.userAction;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PortfolioNotice other) {
    _$v = other as _$PortfolioNotice;
  }

  @override
  void update(void Function(PortfolioNoticeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortfolioNotice build() => _build();

  _$PortfolioNotice _build() {
    final _$result = _$v ??
        _$PortfolioNotice._(
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'PortfolioNotice', 'code'),
          severity: BuiltValueNullFieldError.checkNotNull(
              severity, r'PortfolioNotice', 'severity'),
          message: BuiltValueNullFieldError.checkNotNull(
              message, r'PortfolioNotice', 'message'),
          userAction: userAction,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
