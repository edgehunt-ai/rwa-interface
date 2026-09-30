// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_withdrawal_preview.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3WithdrawalPreviewBlockersEnum
    _$hip3WithdrawalPreviewBlockersEnum_insufficientWithdrawableBalance =
    const Hip3WithdrawalPreviewBlockersEnum._(
        'insufficientWithdrawableBalance');

Hip3WithdrawalPreviewBlockersEnum _$hip3WithdrawalPreviewBlockersEnumValueOf(
    String name) {
  switch (name) {
    case 'insufficientWithdrawableBalance':
      return _$hip3WithdrawalPreviewBlockersEnum_insufficientWithdrawableBalance;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3WithdrawalPreviewBlockersEnum>
    _$hip3WithdrawalPreviewBlockersEnumValues = BuiltSet<
        Hip3WithdrawalPreviewBlockersEnum>(const <Hip3WithdrawalPreviewBlockersEnum>[
  _$hip3WithdrawalPreviewBlockersEnum_insufficientWithdrawableBalance,
]);

Serializer<Hip3WithdrawalPreviewBlockersEnum>
    _$hip3WithdrawalPreviewBlockersEnumSerializer =
    _$Hip3WithdrawalPreviewBlockersEnumSerializer();

class _$Hip3WithdrawalPreviewBlockersEnumSerializer
    implements PrimitiveSerializer<Hip3WithdrawalPreviewBlockersEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'insufficientWithdrawableBalance': 'insufficient_withdrawable_balance',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'insufficient_withdrawable_balance': 'insufficientWithdrawableBalance',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3WithdrawalPreviewBlockersEnum];
  @override
  final String wireName = 'Hip3WithdrawalPreviewBlockersEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3WithdrawalPreviewBlockersEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3WithdrawalPreviewBlockersEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3WithdrawalPreviewBlockersEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3WithdrawalPreview extends Hip3WithdrawalPreview {
  @override
  final String amount;
  @override
  final String fee;
  @override
  final String minimumReceived;
  @override
  final Hip3WithdrawalRail rail;
  @override
  final String destinationAddress;
  @override
  final String chainId;
  @override
  final String maximumTransferable;
  @override
  final BuiltList<Hip3WithdrawalPreviewBlockersEnum> blockers;
  @override
  final int estimatedArrivalSeconds;
  @override
  final BuiltList<Hip3WithdrawalFeeDetail> feeDetails;
  @override
  final Hip3CollateralRiskPreview riskPreview;

  factory _$Hip3WithdrawalPreview(
          [void Function(Hip3WithdrawalPreviewBuilder)? updates]) =>
      (Hip3WithdrawalPreviewBuilder()..update(updates))._build();

  _$Hip3WithdrawalPreview._(
      {required this.amount,
      required this.fee,
      required this.minimumReceived,
      required this.rail,
      required this.destinationAddress,
      required this.chainId,
      required this.maximumTransferable,
      required this.blockers,
      required this.estimatedArrivalSeconds,
      required this.feeDetails,
      required this.riskPreview})
      : super._();
  @override
  Hip3WithdrawalPreview rebuild(
          void Function(Hip3WithdrawalPreviewBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3WithdrawalPreviewBuilder toBuilder() =>
      Hip3WithdrawalPreviewBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3WithdrawalPreview &&
        amount == other.amount &&
        fee == other.fee &&
        minimumReceived == other.minimumReceived &&
        rail == other.rail &&
        destinationAddress == other.destinationAddress &&
        chainId == other.chainId &&
        maximumTransferable == other.maximumTransferable &&
        blockers == other.blockers &&
        estimatedArrivalSeconds == other.estimatedArrivalSeconds &&
        feeDetails == other.feeDetails &&
        riskPreview == other.riskPreview;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, fee.hashCode);
    _$hash = $jc(_$hash, minimumReceived.hashCode);
    _$hash = $jc(_$hash, rail.hashCode);
    _$hash = $jc(_$hash, destinationAddress.hashCode);
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, maximumTransferable.hashCode);
    _$hash = $jc(_$hash, blockers.hashCode);
    _$hash = $jc(_$hash, estimatedArrivalSeconds.hashCode);
    _$hash = $jc(_$hash, feeDetails.hashCode);
    _$hash = $jc(_$hash, riskPreview.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3WithdrawalPreview')
          ..add('amount', amount)
          ..add('fee', fee)
          ..add('minimumReceived', minimumReceived)
          ..add('rail', rail)
          ..add('destinationAddress', destinationAddress)
          ..add('chainId', chainId)
          ..add('maximumTransferable', maximumTransferable)
          ..add('blockers', blockers)
          ..add('estimatedArrivalSeconds', estimatedArrivalSeconds)
          ..add('feeDetails', feeDetails)
          ..add('riskPreview', riskPreview))
        .toString();
  }
}

class Hip3WithdrawalPreviewBuilder
    implements Builder<Hip3WithdrawalPreview, Hip3WithdrawalPreviewBuilder> {
  _$Hip3WithdrawalPreview? _$v;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _fee;
  String? get fee => _$this._fee;
  set fee(String? fee) => _$this._fee = fee;

  String? _minimumReceived;
  String? get minimumReceived => _$this._minimumReceived;
  set minimumReceived(String? minimumReceived) =>
      _$this._minimumReceived = minimumReceived;

  Hip3WithdrawalRail? _rail;
  Hip3WithdrawalRail? get rail => _$this._rail;
  set rail(Hip3WithdrawalRail? rail) => _$this._rail = rail;

  String? _destinationAddress;
  String? get destinationAddress => _$this._destinationAddress;
  set destinationAddress(String? destinationAddress) =>
      _$this._destinationAddress = destinationAddress;

  String? _chainId;
  String? get chainId => _$this._chainId;
  set chainId(String? chainId) => _$this._chainId = chainId;

  String? _maximumTransferable;
  String? get maximumTransferable => _$this._maximumTransferable;
  set maximumTransferable(String? maximumTransferable) =>
      _$this._maximumTransferable = maximumTransferable;

  ListBuilder<Hip3WithdrawalPreviewBlockersEnum>? _blockers;
  ListBuilder<Hip3WithdrawalPreviewBlockersEnum> get blockers =>
      _$this._blockers ??= ListBuilder<Hip3WithdrawalPreviewBlockersEnum>();
  set blockers(ListBuilder<Hip3WithdrawalPreviewBlockersEnum>? blockers) =>
      _$this._blockers = blockers;

  int? _estimatedArrivalSeconds;
  int? get estimatedArrivalSeconds => _$this._estimatedArrivalSeconds;
  set estimatedArrivalSeconds(int? estimatedArrivalSeconds) =>
      _$this._estimatedArrivalSeconds = estimatedArrivalSeconds;

  ListBuilder<Hip3WithdrawalFeeDetail>? _feeDetails;
  ListBuilder<Hip3WithdrawalFeeDetail> get feeDetails =>
      _$this._feeDetails ??= ListBuilder<Hip3WithdrawalFeeDetail>();
  set feeDetails(ListBuilder<Hip3WithdrawalFeeDetail>? feeDetails) =>
      _$this._feeDetails = feeDetails;

  Hip3CollateralRiskPreviewBuilder? _riskPreview;
  Hip3CollateralRiskPreviewBuilder get riskPreview =>
      _$this._riskPreview ??= Hip3CollateralRiskPreviewBuilder();
  set riskPreview(Hip3CollateralRiskPreviewBuilder? riskPreview) =>
      _$this._riskPreview = riskPreview;

  Hip3WithdrawalPreviewBuilder() {
    Hip3WithdrawalPreview._defaults(this);
  }

  Hip3WithdrawalPreviewBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _fee = $v.fee;
      _minimumReceived = $v.minimumReceived;
      _rail = $v.rail;
      _destinationAddress = $v.destinationAddress;
      _chainId = $v.chainId;
      _maximumTransferable = $v.maximumTransferable;
      _blockers = $v.blockers.toBuilder();
      _estimatedArrivalSeconds = $v.estimatedArrivalSeconds;
      _feeDetails = $v.feeDetails.toBuilder();
      _riskPreview = $v.riskPreview.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3WithdrawalPreview other) {
    _$v = other as _$Hip3WithdrawalPreview;
  }

  @override
  void update(void Function(Hip3WithdrawalPreviewBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3WithdrawalPreview build() => _build();

  _$Hip3WithdrawalPreview _build() {
    _$Hip3WithdrawalPreview _$result;
    try {
      _$result = _$v ??
          _$Hip3WithdrawalPreview._(
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, r'Hip3WithdrawalPreview', 'amount'),
            fee: BuiltValueNullFieldError.checkNotNull(
                fee, r'Hip3WithdrawalPreview', 'fee'),
            minimumReceived: BuiltValueNullFieldError.checkNotNull(
                minimumReceived, r'Hip3WithdrawalPreview', 'minimumReceived'),
            rail: BuiltValueNullFieldError.checkNotNull(
                rail, r'Hip3WithdrawalPreview', 'rail'),
            destinationAddress: BuiltValueNullFieldError.checkNotNull(
                destinationAddress,
                r'Hip3WithdrawalPreview',
                'destinationAddress'),
            chainId: BuiltValueNullFieldError.checkNotNull(
                chainId, r'Hip3WithdrawalPreview', 'chainId'),
            maximumTransferable: BuiltValueNullFieldError.checkNotNull(
                maximumTransferable,
                r'Hip3WithdrawalPreview',
                'maximumTransferable'),
            blockers: blockers.build(),
            estimatedArrivalSeconds: BuiltValueNullFieldError.checkNotNull(
                estimatedArrivalSeconds,
                r'Hip3WithdrawalPreview',
                'estimatedArrivalSeconds'),
            feeDetails: feeDetails.build(),
            riskPreview: riskPreview.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'blockers';
        blockers.build();

        _$failedField = 'feeDetails';
        feeDetails.build();
        _$failedField = 'riskPreview';
        riskPreview.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3WithdrawalPreview', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
