// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_eip712_types.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3Eip712Types extends Hip3Eip712Types {
  @override
  final BuiltList<Hip3Eip712Field> agent;

  factory _$Hip3Eip712Types([void Function(Hip3Eip712TypesBuilder)? updates]) =>
      (Hip3Eip712TypesBuilder()..update(updates))._build();

  _$Hip3Eip712Types._({required this.agent}) : super._();
  @override
  Hip3Eip712Types rebuild(void Function(Hip3Eip712TypesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3Eip712TypesBuilder toBuilder() => Hip3Eip712TypesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3Eip712Types && agent == other.agent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, agent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3Eip712Types')
          ..add('agent', agent))
        .toString();
  }
}

class Hip3Eip712TypesBuilder
    implements Builder<Hip3Eip712Types, Hip3Eip712TypesBuilder> {
  _$Hip3Eip712Types? _$v;

  ListBuilder<Hip3Eip712Field>? _agent;
  ListBuilder<Hip3Eip712Field> get agent =>
      _$this._agent ??= ListBuilder<Hip3Eip712Field>();
  set agent(ListBuilder<Hip3Eip712Field>? agent) => _$this._agent = agent;

  Hip3Eip712TypesBuilder() {
    Hip3Eip712Types._defaults(this);
  }

  Hip3Eip712TypesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _agent = $v.agent.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3Eip712Types other) {
    _$v = other as _$Hip3Eip712Types;
  }

  @override
  void update(void Function(Hip3Eip712TypesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3Eip712Types build() => _build();

  _$Hip3Eip712Types _build() {
    _$Hip3Eip712Types _$result;
    try {
      _$result = _$v ??
          _$Hip3Eip712Types._(
            agent: agent.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'agent';
        agent.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3Eip712Types', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
