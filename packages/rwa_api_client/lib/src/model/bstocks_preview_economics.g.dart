// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_preview_economics.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksPreviewEconomicsInputSemanticsEnum
    _$bstocksPreviewEconomicsInputSemanticsEnum_quotedGrossInput =
    const BstocksPreviewEconomicsInputSemanticsEnum._('quotedGrossInput');
const BstocksPreviewEconomicsInputSemanticsEnum
    _$bstocksPreviewEconomicsInputSemanticsEnum_maximumFunding =
    const BstocksPreviewEconomicsInputSemanticsEnum._('maximumFunding');
const BstocksPreviewEconomicsInputSemanticsEnum
    _$bstocksPreviewEconomicsInputSemanticsEnum_unknownDefaultOpenApi =
    const BstocksPreviewEconomicsInputSemanticsEnum._('unknownDefaultOpenApi');

BstocksPreviewEconomicsInputSemanticsEnum
    _$bstocksPreviewEconomicsInputSemanticsEnumValueOf(String name) {
  switch (name) {
    case 'quotedGrossInput':
      return _$bstocksPreviewEconomicsInputSemanticsEnum_quotedGrossInput;
    case 'maximumFunding':
      return _$bstocksPreviewEconomicsInputSemanticsEnum_maximumFunding;
    case 'unknownDefaultOpenApi':
      return _$bstocksPreviewEconomicsInputSemanticsEnum_unknownDefaultOpenApi;
    default:
      return _$bstocksPreviewEconomicsInputSemanticsEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksPreviewEconomicsInputSemanticsEnum>
    _$bstocksPreviewEconomicsInputSemanticsEnumValues = BuiltSet<
        BstocksPreviewEconomicsInputSemanticsEnum>(const <BstocksPreviewEconomicsInputSemanticsEnum>[
  _$bstocksPreviewEconomicsInputSemanticsEnum_quotedGrossInput,
  _$bstocksPreviewEconomicsInputSemanticsEnum_maximumFunding,
  _$bstocksPreviewEconomicsInputSemanticsEnum_unknownDefaultOpenApi,
]);

Serializer<BstocksPreviewEconomicsInputSemanticsEnum>
    _$bstocksPreviewEconomicsInputSemanticsEnumSerializer =
    _$BstocksPreviewEconomicsInputSemanticsEnumSerializer();

class _$BstocksPreviewEconomicsInputSemanticsEnumSerializer
    implements PrimitiveSerializer<BstocksPreviewEconomicsInputSemanticsEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'quotedGrossInput': 'quoted_gross_input',
    'maximumFunding': 'maximum_funding',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'quoted_gross_input': 'quotedGrossInput',
    'maximum_funding': 'maximumFunding',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstocksPreviewEconomicsInputSemanticsEnum
  ];
  @override
  final String wireName = 'BstocksPreviewEconomicsInputSemanticsEnum';

  @override
  Object serialize(Serializers serializers,
          BstocksPreviewEconomicsInputSemanticsEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksPreviewEconomicsInputSemanticsEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksPreviewEconomicsInputSemanticsEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksPreviewEconomics extends BstocksPreviewEconomics {
  @override
  final BstocksFeeAsset inputAsset;
  @override
  final String? nominalInput;
  @override
  final String totalInput;
  @override
  final BstocksPreviewEconomicsInputSemanticsEnum inputSemantics;
  @override
  final BstocksPreviewFees fees;
  @override
  final BstocksPreviewEconomicsQuoteValidity quoteValidity;
  @override
  final bool indicative;
  @override
  final bool requiresNewQuote;
  @override
  final BstocksConfirmationBinding? confirmationBinding;

  factory _$BstocksPreviewEconomics(
          [void Function(BstocksPreviewEconomicsBuilder)? updates]) =>
      (BstocksPreviewEconomicsBuilder()..update(updates))._build();

  _$BstocksPreviewEconomics._(
      {required this.inputAsset,
      this.nominalInput,
      required this.totalInput,
      required this.inputSemantics,
      required this.fees,
      required this.quoteValidity,
      required this.indicative,
      required this.requiresNewQuote,
      this.confirmationBinding})
      : super._();
  @override
  BstocksPreviewEconomics rebuild(
          void Function(BstocksPreviewEconomicsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksPreviewEconomicsBuilder toBuilder() =>
      BstocksPreviewEconomicsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksPreviewEconomics &&
        inputAsset == other.inputAsset &&
        nominalInput == other.nominalInput &&
        totalInput == other.totalInput &&
        inputSemantics == other.inputSemantics &&
        fees == other.fees &&
        quoteValidity == other.quoteValidity &&
        indicative == other.indicative &&
        requiresNewQuote == other.requiresNewQuote &&
        confirmationBinding == other.confirmationBinding;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, inputAsset.hashCode);
    _$hash = $jc(_$hash, nominalInput.hashCode);
    _$hash = $jc(_$hash, totalInput.hashCode);
    _$hash = $jc(_$hash, inputSemantics.hashCode);
    _$hash = $jc(_$hash, fees.hashCode);
    _$hash = $jc(_$hash, quoteValidity.hashCode);
    _$hash = $jc(_$hash, indicative.hashCode);
    _$hash = $jc(_$hash, requiresNewQuote.hashCode);
    _$hash = $jc(_$hash, confirmationBinding.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksPreviewEconomics')
          ..add('inputAsset', inputAsset)
          ..add('nominalInput', nominalInput)
          ..add('totalInput', totalInput)
          ..add('inputSemantics', inputSemantics)
          ..add('fees', fees)
          ..add('quoteValidity', quoteValidity)
          ..add('indicative', indicative)
          ..add('requiresNewQuote', requiresNewQuote)
          ..add('confirmationBinding', confirmationBinding))
        .toString();
  }
}

class BstocksPreviewEconomicsBuilder
    implements
        Builder<BstocksPreviewEconomics, BstocksPreviewEconomicsBuilder> {
  _$BstocksPreviewEconomics? _$v;

  BstocksFeeAssetBuilder? _inputAsset;
  BstocksFeeAssetBuilder get inputAsset =>
      _$this._inputAsset ??= BstocksFeeAssetBuilder();
  set inputAsset(BstocksFeeAssetBuilder? inputAsset) =>
      _$this._inputAsset = inputAsset;

  String? _nominalInput;
  String? get nominalInput => _$this._nominalInput;
  set nominalInput(String? nominalInput) => _$this._nominalInput = nominalInput;

  String? _totalInput;
  String? get totalInput => _$this._totalInput;
  set totalInput(String? totalInput) => _$this._totalInput = totalInput;

  BstocksPreviewEconomicsInputSemanticsEnum? _inputSemantics;
  BstocksPreviewEconomicsInputSemanticsEnum? get inputSemantics =>
      _$this._inputSemantics;
  set inputSemantics(
          BstocksPreviewEconomicsInputSemanticsEnum? inputSemantics) =>
      _$this._inputSemantics = inputSemantics;

  BstocksPreviewFeesBuilder? _fees;
  BstocksPreviewFeesBuilder get fees =>
      _$this._fees ??= BstocksPreviewFeesBuilder();
  set fees(BstocksPreviewFeesBuilder? fees) => _$this._fees = fees;

  BstocksPreviewEconomicsQuoteValidityBuilder? _quoteValidity;
  BstocksPreviewEconomicsQuoteValidityBuilder get quoteValidity =>
      _$this._quoteValidity ??= BstocksPreviewEconomicsQuoteValidityBuilder();
  set quoteValidity(
          BstocksPreviewEconomicsQuoteValidityBuilder? quoteValidity) =>
      _$this._quoteValidity = quoteValidity;

  bool? _indicative;
  bool? get indicative => _$this._indicative;
  set indicative(bool? indicative) => _$this._indicative = indicative;

  bool? _requiresNewQuote;
  bool? get requiresNewQuote => _$this._requiresNewQuote;
  set requiresNewQuote(bool? requiresNewQuote) =>
      _$this._requiresNewQuote = requiresNewQuote;

  BstocksConfirmationBindingBuilder? _confirmationBinding;
  BstocksConfirmationBindingBuilder get confirmationBinding =>
      _$this._confirmationBinding ??= BstocksConfirmationBindingBuilder();
  set confirmationBinding(
          BstocksConfirmationBindingBuilder? confirmationBinding) =>
      _$this._confirmationBinding = confirmationBinding;

  BstocksPreviewEconomicsBuilder() {
    BstocksPreviewEconomics._defaults(this);
  }

  BstocksPreviewEconomicsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _inputAsset = $v.inputAsset.toBuilder();
      _nominalInput = $v.nominalInput;
      _totalInput = $v.totalInput;
      _inputSemantics = $v.inputSemantics;
      _fees = $v.fees.toBuilder();
      _quoteValidity = $v.quoteValidity.toBuilder();
      _indicative = $v.indicative;
      _requiresNewQuote = $v.requiresNewQuote;
      _confirmationBinding = $v.confirmationBinding?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksPreviewEconomics other) {
    _$v = other as _$BstocksPreviewEconomics;
  }

  @override
  void update(void Function(BstocksPreviewEconomicsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksPreviewEconomics build() => _build();

  _$BstocksPreviewEconomics _build() {
    _$BstocksPreviewEconomics _$result;
    try {
      _$result = _$v ??
          _$BstocksPreviewEconomics._(
            inputAsset: inputAsset.build(),
            nominalInput: nominalInput,
            totalInput: BuiltValueNullFieldError.checkNotNull(
                totalInput, r'BstocksPreviewEconomics', 'totalInput'),
            inputSemantics: BuiltValueNullFieldError.checkNotNull(
                inputSemantics, r'BstocksPreviewEconomics', 'inputSemantics'),
            fees: fees.build(),
            quoteValidity: quoteValidity.build(),
            indicative: BuiltValueNullFieldError.checkNotNull(
                indicative, r'BstocksPreviewEconomics', 'indicative'),
            requiresNewQuote: BuiltValueNullFieldError.checkNotNull(
                requiresNewQuote,
                r'BstocksPreviewEconomics',
                'requiresNewQuote'),
            confirmationBinding: _confirmationBinding?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'inputAsset';
        inputAsset.build();

        _$failedField = 'fees';
        fees.build();
        _$failedField = 'quoteValidity';
        quoteValidity.build();

        _$failedField = 'confirmationBinding';
        _confirmationBinding?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BstocksPreviewEconomics', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
