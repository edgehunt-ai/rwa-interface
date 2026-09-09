// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_action.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3Action extends Hip3Action {
  @override
  final Hip3ActionCreateRequest intent;
  @override
  final Hip3ClosePreview? closePreview;
  @override
  final String actionId;
  @override
  final Hip3Operation operation;
  @override
  final Hip3Environment environment;
  @override
  final String productId;
  @override
  final Hip3ActionStatus status;
  @override
  final String? orderId;
  @override
  final String? positionId;
  @override
  final String? currentStepId;
  @override
  final BuiltList<Hip3ActionStep> steps;
  @override
  final BuiltList<String> affectedOrderIds;
  @override
  final bool effectsApplied;
  @override
  final String? failureReason;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$Hip3Action([void Function(Hip3ActionBuilder)? updates]) =>
      (Hip3ActionBuilder()..update(updates))._build();

  _$Hip3Action._(
      {required this.intent,
      this.closePreview,
      required this.actionId,
      required this.operation,
      required this.environment,
      required this.productId,
      required this.status,
      this.orderId,
      this.positionId,
      this.currentStepId,
      required this.steps,
      required this.affectedOrderIds,
      required this.effectsApplied,
      this.failureReason,
      required this.createdAt,
      required this.updatedAt})
      : super._();
  @override
  Hip3Action rebuild(void Function(Hip3ActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3ActionBuilder toBuilder() => Hip3ActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3Action &&
        intent == other.intent &&
        closePreview == other.closePreview &&
        actionId == other.actionId &&
        operation == other.operation &&
        environment == other.environment &&
        productId == other.productId &&
        status == other.status &&
        orderId == other.orderId &&
        positionId == other.positionId &&
        currentStepId == other.currentStepId &&
        steps == other.steps &&
        affectedOrderIds == other.affectedOrderIds &&
        effectsApplied == other.effectsApplied &&
        failureReason == other.failureReason &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, intent.hashCode);
    _$hash = $jc(_$hash, closePreview.hashCode);
    _$hash = $jc(_$hash, actionId.hashCode);
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, environment.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, positionId.hashCode);
    _$hash = $jc(_$hash, currentStepId.hashCode);
    _$hash = $jc(_$hash, steps.hashCode);
    _$hash = $jc(_$hash, affectedOrderIds.hashCode);
    _$hash = $jc(_$hash, effectsApplied.hashCode);
    _$hash = $jc(_$hash, failureReason.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3Action')
          ..add('intent', intent)
          ..add('closePreview', closePreview)
          ..add('actionId', actionId)
          ..add('operation', operation)
          ..add('environment', environment)
          ..add('productId', productId)
          ..add('status', status)
          ..add('orderId', orderId)
          ..add('positionId', positionId)
          ..add('currentStepId', currentStepId)
          ..add('steps', steps)
          ..add('affectedOrderIds', affectedOrderIds)
          ..add('effectsApplied', effectsApplied)
          ..add('failureReason', failureReason)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class Hip3ActionBuilder implements Builder<Hip3Action, Hip3ActionBuilder> {
  _$Hip3Action? _$v;

  Hip3ActionCreateRequestBuilder? _intent;
  Hip3ActionCreateRequestBuilder get intent =>
      _$this._intent ??= Hip3ActionCreateRequestBuilder();
  set intent(Hip3ActionCreateRequestBuilder? intent) => _$this._intent = intent;

  Hip3ClosePreviewBuilder? _closePreview;
  Hip3ClosePreviewBuilder get closePreview =>
      _$this._closePreview ??= Hip3ClosePreviewBuilder();
  set closePreview(Hip3ClosePreviewBuilder? closePreview) =>
      _$this._closePreview = closePreview;

  String? _actionId;
  String? get actionId => _$this._actionId;
  set actionId(String? actionId) => _$this._actionId = actionId;

  Hip3Operation? _operation;
  Hip3Operation? get operation => _$this._operation;
  set operation(Hip3Operation? operation) => _$this._operation = operation;

  Hip3Environment? _environment;
  Hip3Environment? get environment => _$this._environment;
  set environment(Hip3Environment? environment) =>
      _$this._environment = environment;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  Hip3ActionStatus? _status;
  Hip3ActionStatus? get status => _$this._status;
  set status(Hip3ActionStatus? status) => _$this._status = status;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  String? _positionId;
  String? get positionId => _$this._positionId;
  set positionId(String? positionId) => _$this._positionId = positionId;

  String? _currentStepId;
  String? get currentStepId => _$this._currentStepId;
  set currentStepId(String? currentStepId) =>
      _$this._currentStepId = currentStepId;

  ListBuilder<Hip3ActionStep>? _steps;
  ListBuilder<Hip3ActionStep> get steps =>
      _$this._steps ??= ListBuilder<Hip3ActionStep>();
  set steps(ListBuilder<Hip3ActionStep>? steps) => _$this._steps = steps;

  ListBuilder<String>? _affectedOrderIds;
  ListBuilder<String> get affectedOrderIds =>
      _$this._affectedOrderIds ??= ListBuilder<String>();
  set affectedOrderIds(ListBuilder<String>? affectedOrderIds) =>
      _$this._affectedOrderIds = affectedOrderIds;

  bool? _effectsApplied;
  bool? get effectsApplied => _$this._effectsApplied;
  set effectsApplied(bool? effectsApplied) =>
      _$this._effectsApplied = effectsApplied;

  String? _failureReason;
  String? get failureReason => _$this._failureReason;
  set failureReason(String? failureReason) =>
      _$this._failureReason = failureReason;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  Hip3ActionBuilder() {
    Hip3Action._defaults(this);
  }

  Hip3ActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _intent = $v.intent.toBuilder();
      _closePreview = $v.closePreview?.toBuilder();
      _actionId = $v.actionId;
      _operation = $v.operation;
      _environment = $v.environment;
      _productId = $v.productId;
      _status = $v.status;
      _orderId = $v.orderId;
      _positionId = $v.positionId;
      _currentStepId = $v.currentStepId;
      _steps = $v.steps.toBuilder();
      _affectedOrderIds = $v.affectedOrderIds.toBuilder();
      _effectsApplied = $v.effectsApplied;
      _failureReason = $v.failureReason;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3Action other) {
    _$v = other as _$Hip3Action;
  }

  @override
  void update(void Function(Hip3ActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3Action build() => _build();

  _$Hip3Action _build() {
    _$Hip3Action _$result;
    try {
      _$result = _$v ??
          _$Hip3Action._(
            intent: intent.build(),
            closePreview: _closePreview?.build(),
            actionId: BuiltValueNullFieldError.checkNotNull(
                actionId, r'Hip3Action', 'actionId'),
            operation: BuiltValueNullFieldError.checkNotNull(
                operation, r'Hip3Action', 'operation'),
            environment: BuiltValueNullFieldError.checkNotNull(
                environment, r'Hip3Action', 'environment'),
            productId: BuiltValueNullFieldError.checkNotNull(
                productId, r'Hip3Action', 'productId'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'Hip3Action', 'status'),
            orderId: orderId,
            positionId: positionId,
            currentStepId: currentStepId,
            steps: steps.build(),
            affectedOrderIds: affectedOrderIds.build(),
            effectsApplied: BuiltValueNullFieldError.checkNotNull(
                effectsApplied, r'Hip3Action', 'effectsApplied'),
            failureReason: failureReason,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Hip3Action', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'Hip3Action', 'updatedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'intent';
        intent.build();
        _$failedField = 'closePreview';
        _closePreview?.build();

        _$failedField = 'steps';
        steps.build();
        _$failedField = 'affectedOrderIds';
        affectedOrderIds.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3Action', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
