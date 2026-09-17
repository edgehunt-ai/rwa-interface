import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/trading_account.dart';
import 'package:rwa_interface/domain/models/wallet_action_execution.dart';
import 'package:rwa_interface/domain/models/withdrawal.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/adaptive/app_adaptive_dialogs.dart';
import 'package:rwa_interface/ui/core/feedback/empty_state.dart';
import 'package:rwa_interface/ui/core/feedback/failure_state.dart';
import 'package:rwa_interface/ui/core/feedback/app_toast.dart';
import 'package:rwa_interface/ui/core/feedback/loading_skeleton.dart';
import 'package:rwa_interface/ui/core/formatters/token_amount_formatter.dart';
import 'package:rwa_interface/ui/core/navigation/app_page_header.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/funding/providers/self_custodial_withdrawal_providers.dart';
import 'package:rwa_interface/ui/features/funding/providers/withdrawal_providers.dart';
import 'package:rwa_interface/ui/features/portfolio/providers/portfolio_providers.dart';

class WithdrawalScreen extends ConsumerStatefulWidget {
  const WithdrawalScreen({
    super.key,
    this.showSelector = false,
    this.token = 'USDC',
    this.chain = 'Arbitrum',
  });

  final bool showSelector;
  final String token;
  final String chain;

  @override
  ConsumerState<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends ConsumerState<WithdrawalScreen> {
  final address = TextEditingController();
  final amount = TextEditingController();
  WithdrawalQuote? quote;
  PreparedSelfCustodialWithdrawal? prepared;
  String? error;
  bool quoting = false;
  bool submitting = false;
  bool waitingForBalance = false;
  // Each visit to the review step asks the server for its own gas observation.
  int prepareAttempt = 0;

  static const _balancePollInterval = Duration(seconds: 2);
  static const _balancePollTimeout = Duration(seconds: 30);

  @override
  void dispose() {
    address.dispose();
    amount.dispose();
    super.dispose();
  }

  Future<void> _review() async {
    final raw = amount.text.trim();
    final recipient = address.text.trim();
    if (recipient.isEmpty || raw.isEmpty) {
      setState(
        () =>
            error = AppLocalizations.of(context).enterRecipientAddressAndAmount,
      );
      return;
    }
    if (!_isEvmAddress(recipient)) {
      setState(
        () => error = AppLocalizations.of(context).enterValidWalletAddress,
      );
      return;
    }
    DecimalValue value;
    try {
      value = DecimalValue(raw, asset: widget.token, unit: 'token');
    } on FormatException {
      setState(
        () =>
            error = AppLocalizations.of(context)
                .enterValidTokenAmount(widget.token),
      );
      return;
    }
    final candidate = WithdrawalQuote(
      quoteId: 'self-custodial-local',
      intent: WithdrawalIntent(
        chain: widget.chain,
        amount: value,
        address: recipient,
      ),
      // Self-custodial withdrawals pay network gas from the wallet in its
      // native asset, so there is no token-denominated fee.
      totalFee: DecimalValue('0', asset: widget.token, unit: 'token'),
      estimatedReceive: value,
      sufficient: true,
    );

    // Creating the intent is what produces the gas observation, so it happens
    // on the way into the review step and its fee is shown there. Each entry
    // takes a fresh observation: a wallet that has just topped up must not be
    // judged against a replayed estimate.
    setState(() {
      quoting = true;
      error = null;
      prepared = null;
      prepareAttempt++;
    });
    try {
      final intent = await ref
          .read(selfCustodialWithdrawalCommandsProvider)
          .prepare(quote: candidate, attempt: prepareAttempt);
      if (!mounted) return;
      setState(() {
        quoting = false;
        quote = candidate;
        prepared = intent;
        // Whether the wallet needs its own gas is only known once the server
        // has decided on sponsorship, so the review no longer pre-judges an
        // empty native balance. Confirming raises it if it turns out to apply.
        error = null;
      });
    } on Object {
      if (!mounted) return;
      setState(() {
        quoting = false;
        error = AppLocalizations.of(context).prepareWithdrawalFailed;
      });
    }
  }

  Future<void> _submit() async {
    final currentQuote = quote;
    final current = prepared;
    if (currentQuote == null || current == null || submitting) return;
    setState(() => submitting = true);
    final openingBalance = await _readWithdrawableBalance(currentQuote);
    if (!mounted) return;
    try {
      await ref
          .read(selfCustodialWithdrawalCommandsProvider)
          .execute(
            quote: currentQuote,
            prepared: current,
            confirmWalletUpgrade: _confirmWalletUpgrade,
          );
      await _waitForBalanceChange(currentQuote, openingBalance);
      if (mounted) {
        ref.invalidate(portfolioSummaryProvider);
        context.goNamed(AppRoutes.homeName);
        AppToast.showSuccess(
          context,
          AppLocalizations.of(context).withdrawalSucceeded,
        );
      }
    } on SponsoredGasUnavailable catch (refusal) {
      // Sponsorship was refused before any broadcast. Paying gas from the
      // wallet is a separate decision, so it needs its own confirmation — and
      // asking at all is pointless when the wallet cannot cover the fee.
      if (!mounted) return;
      final gas = current.gas;
      if (gas != null && !gas.canPayGas) {
        setState(() => error = _gasError(gas));
        return;
      }
      if (!refusal.fallbackAllowed || !await _confirmUserPaidGas(refusal)) {
        if (mounted) setState(() => submitting = false);
        return;
      }
      await _submitUserPaid(currentQuote, current, openingBalance);
    } on WalletUpgradeDeclined {
      if (mounted) setState(() => submitting = false);
    } on InsufficientWithdrawalGas catch (failure) {
      if (mounted) setState(() => error = _gasError(failure.estimate));
    } on Object {
      if (mounted) {
        AppToast.showFailure(
          context,
          AppLocalizations.of(context).prepareWithdrawalFailed,
        );
      }
    } finally {
      if (mounted) setState(() => submitting = false);
    }
  }

  Future<void> _submitUserPaid(
    WithdrawalQuote currentQuote,
    PreparedSelfCustodialWithdrawal current,
    DecimalValue? openingBalance,
  ) async {
    try {
      await ref
          .read(selfCustodialWithdrawalCommandsProvider)
          .executeUserPaid(quote: currentQuote, prepared: current);
      await _waitForBalanceChange(currentQuote, openingBalance);
      if (mounted) {
        ref.invalidate(portfolioSummaryProvider);
        context.goNamed(AppRoutes.homeName);
        AppToast.showSuccess(
          context,
          AppLocalizations.of(context).withdrawalSucceeded,
        );
      }
    } on InsufficientWithdrawalGas catch (failure) {
      if (mounted) setState(() => error = _gasError(failure.estimate));
    } on Object {
      if (mounted) {
        AppToast.showFailure(
          context,
          AppLocalizations.of(context).prepareWithdrawalFailed,
        );
      }
    }
  }

  Future<DecimalValue?> _readWithdrawableBalance(WithdrawalQuote quote) async {
    try {
      final accounts = await ref.read(tradingAccountsProvider.future);
      return _matchingBalance(accounts, quote);
    } on Object {
      return null;
    }
  }

  Future<void> _waitForBalanceChange(
    WithdrawalQuote quote,
    DecimalValue? openingBalance,
  ) async {
    if (openingBalance == null) return;
    if (mounted) setState(() => waitingForBalance = true);
    final deadline = DateTime.now().add(_balancePollTimeout);
    try {
      while (DateTime.now().isBefore(deadline)) {
        await Future<void>.delayed(_balancePollInterval);
        if (!mounted) return;
        try {
          final accounts = await ref.refresh(tradingAccountsProvider.future);
          final current = _matchingBalance(accounts, quote);
          if (current != null && current.compareTo(openingBalance) < 0) return;
        } on Object {
          // A transient balance request failure should not hide a submitted withdrawal.
        }
      }
      if (mounted) {
        AppToast.showFailure(
          context,
          AppLocalizations.of(context).balanceRefreshFailed,
        );
      }
    } finally {
      if (mounted) setState(() => waitingForBalance = false);
    }
  }

  DecimalValue? _matchingBalance(
    List<TradingAccount> accounts,
    WithdrawalQuote quote,
  ) {
    for (final account in accounts) {
      for (final token in account.balances) {
        final chain = token.chain ?? account.chain;
        if (token.symbol.toUpperCase() ==
                quote.intent.amount.asset?.toUpperCase() &&
            chain?.toLowerCase() == quote.intent.chain.toLowerCase()) {
          return token.balance;
        }
      }
    }
    return null;
  }

  /// The disclosure is shown in the app's own language. The server also sends
  /// [GasPaymentQuote.eip7702Notice], but it arrives in one language only, so
  /// the localized copy is what reaches the user.
  Future<bool> _confirmWalletUpgrade(GasPaymentQuote _) async {
    if (!mounted) return false;
    final l10n = AppLocalizations.of(context);
    final accepted = await showAppAlert(
      context: context,
      title: l10n.walletUpgradeTitle,
      message: l10n.walletUpgradeNotice,
      confirmLabel: l10n.walletUpgradeConfirm,
      cancelLabel: l10n.cancel,
    );
    return accepted ?? false;
  }

  Future<bool> _confirmUserPaidGas(SponsoredGasUnavailable refusal) async {
    if (!mounted) return false;
    final l10n = AppLocalizations.of(context);
    final gas = refusal.gasPayment;
    final accepted = await showAppAlert(
      context: context,
      title: l10n.sponsoredGasUnavailableTitle,
      message: l10n.sponsoredGasUnavailableMessage(
        gas.estimatedNativeFee.value,
        gas.nativeAsset,
      ),
      confirmLabel: l10n.sponsoredGasUnavailableConfirm,
      cancelLabel: l10n.cancel,
    );
    return accepted ?? false;
  }

  String? _gasError(SelfCustodialWithdrawalGasEstimate? gas) {
    if (gas == null || gas.canPayGas) return null;
    return AppLocalizations.of(context)
        .insufficientGasForWithdrawal(gas.nativeAsset);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showSelector) return const _AssetSelector();
    final selectedAsset = ref
        .watch(withdrawalAssetsProvider)
        .value
        ?.where(
          (asset) =>
              asset.symbol == widget.token && asset.chain == widget.chain,
        )
        .firstOrNull;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            quote == null
                ? _WithdrawalForm(
                    address: address,
                    amount: amount,
                    error: error,
                    submitting: quoting,
                    asset: selectedAsset,
                    token: widget.token,
                    chain: widget.chain,
                    onReview: _review,
                  )
                : _WithdrawalReview(
                    quote: quote!,
                    prepared: prepared,
                    error: error,
                    onBack: () => setState(() {
                      quote = null;
                      prepared = null;
                      error = null;
                    }),
                    onSubmit: _submit,
                    submitting: submitting || waitingForBalance,
                  ),
            if (submitting)
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.white70,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(
                          waitingForBalance
                              ? AppLocalizations.of(context)
                                    .confirmingWithdrawal
                              : AppLocalizations.of(context)
                                    .preparingWithdrawal,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _WithdrawalForm extends StatefulWidget {
  const _WithdrawalForm({
    required this.address,
    required this.amount,
    required this.error,
    required this.submitting,
    required this.asset,
    required this.token,
    required this.chain,
    required this.onReview,
  });

  final TextEditingController address;
  final TextEditingController amount;
  final String? error;
  final bool submitting;
  final WithdrawableAsset? asset;
  final String token;
  final String chain;
  final VoidCallback onReview;

  @override
  State<_WithdrawalForm> createState() => _WithdrawalFormState();
}

class _WithdrawalFormState extends State<_WithdrawalForm> {
  final _addressFocusNode = FocusNode();
  String? _addressError;

  @override
  void initState() {
    super.initState();
    widget.amount.addListener(_refresh);
    widget.address.addListener(_handleAddressChanged);
    _addressFocusNode.addListener(_handleAddressFocusChanged);
  }

  @override
  void didUpdateWidget(covariant _WithdrawalForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.amount != widget.amount) {
      oldWidget.amount.removeListener(_refresh);
      widget.amount.addListener(_refresh);
    }
    if (oldWidget.address != widget.address) {
      oldWidget.address.removeListener(_handleAddressChanged);
      widget.address.addListener(_handleAddressChanged);
    }
  }

  @override
  void dispose() {
    widget.amount.removeListener(_refresh);
    widget.address.removeListener(_handleAddressChanged);
    _addressFocusNode
      ..removeListener(_handleAddressFocusChanged)
      ..dispose();
    super.dispose();
  }

  void _refresh() => setState(() {});

  void _handleAddressChanged() {
    setState(() {
      if (_addressError != null) _addressError = null;
    });
  }

  void _handleAddressFocusChanged() {
    if (!_addressFocusNode.hasFocus) _validateAddress();
  }

  bool _validateAddress() {
    final value = widget.address.text.trim();
    final nextError = value.isNotEmpty && !_isEvmAddress(value)
        ? AppLocalizations.of(context).enterValidWalletAddress
        : null;
    if (_addressError != nextError) {
      setState(() => _addressError = nextError);
    }
    return nextError == null;
  }

  void _review() {
    _addressFocusNode.unfocus();
    if (!_validateAddress()) return;
    widget.onReview();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final rawAmount = widget.amount.text.trim();
    final displayAmount = rawAmount.isEmpty ? '0.00' : rawAmount;
    final parsedAmount = _parseAmount(rawAmount);
    final canSubmit =
        !widget.submitting &&
        widget.asset?.isWithdrawalSupported == true &&
        widget.address.text.trim().isNotEmpty &&
        parsedAmount != null &&
        parsedAmount.compareTo(
              DecimalValue(
                '0',
                asset: parsedAmount.asset,
                unit: parsedAmount.unit,
              ),
            ) >
            0 &&
        parsedAmount.compareTo(widget.asset!.balance) <= 0;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      children: [
        AppPageHeader(
          title: l10n.withdrawToken(widget.token),
          fallbackLocation: AppRoutes.withdrawalSelectPath,
        ),
        const SizedBox(height: 40),
        _RouteCard(token: widget.token, chain: widget.chain),
        const SizedBox(height: 36),
        _InputCard(
          key: const ValueKey('withdrawal-address-card'),
          height: _addressError == null ? 112 : 136,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FieldLabel(l10n.recipientAddress),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      key: const ValueKey('withdrawal-address-field'),
                      controller: widget.address,
                      focusNode: _addressFocusNode,
                      decoration: InputDecoration(
                        hintText: l10n.enterWalletAddress,
                        errorText: _addressError,
                        border: _withdrawalInputBorder(colors.border),
                        enabledBorder: _withdrawalInputBorder(colors.border),
                        focusedBorder: _withdrawalInputBorder(
                          colors.primaryText,
                          width: 1.5,
                        ),
                        disabledBorder: _withdrawalInputBorder(colors.border),
                        errorBorder: _withdrawalInputBorder(
                          Theme.of(context)
                              .extension<AppSemanticColors>()!
                              .loss,
                        ),
                        focusedErrorBorder: _withdrawalInputBorder(
                          Theme.of(context)
                              .extension<AppSemanticColors>()!
                              .loss,
                          width: 1.5,
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                      ),
                      style: _strongText,
                    ),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    key: const ValueKey('withdrawal-address-paste'),
                    onPressed: () async {
                      final data = await Clipboard.getData('text/plain');
                      if (data?.text case final text? when text.isNotEmpty) {
                        widget.address.text = text;
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: colors.primaryText,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(42, 24),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(l10n.paste, style: _strongText),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 36),
        _InputCard(
          key: const ValueKey('withdrawal-amount-card'),
          height: 128,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _FieldLabel(l10n.amount),
                  _FieldLabel(
                    widget.asset == null
                        ? l10n.availableToken(widget.token)
                        : l10n.availableTokenAmount(
                            TokenAmountFormatter.formatValue(
                              widget.asset!.balance,
                              decimals: widget.asset!.decimals,
                            ),
                            widget.token,
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      key: const ValueKey('withdrawal-amount-field'),
                      controller: widget.amount,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        hintText: '0.00',
                        border: _withdrawalInputBorder(colors.border),
                        enabledBorder: _withdrawalInputBorder(colors.border),
                        focusedBorder: _withdrawalInputBorder(
                          colors.primaryText,
                          width: 1.5,
                        ),
                        disabledBorder: _withdrawalInputBorder(colors.border),
                        errorBorder: _withdrawalInputBorder(
                          Theme.of(context)
                              .extension<AppSemanticColors>()!
                              .loss,
                        ),
                        focusedErrorBorder: _withdrawalInputBorder(
                          Theme.of(context)
                              .extension<AppSemanticColors>()!
                              .loss,
                          width: 1.5,
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                      ),
                      style: _strongText,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    widget.token,
                    key: const ValueKey('withdrawal-amount-unit'),
                    style: _strongText,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '≈ \$$displayAmount',
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: colors.secondaryText),
                  ),
                  TextButton(
                    onPressed: widget.asset == null
                        ? null
                        : () =>
                              widget.amount.text = widget.asset!.balance.value,
                    style: TextButton.styleFrom(
                      foregroundColor: colors.primaryText,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(36, 16),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(l10n.max, style: _strongText),
                  ),
                ],
              ),
            ],
          ),
        ),
        // No fee or recipient subtotal here: the network fee is only observed
        // when the intent is created on the way to the review step, and a
        // placeholder would just be noise.
        const SizedBox(height: 36),
        if (widget.error != null) ...[
          const SizedBox(height: 12),
          Text(
            widget.error!,
            style: TextStyle(
              color: Theme.of(context).extension<AppSemanticColors>()!.loss,
            ),
          ),
        ],
        const SizedBox(height: 60),
        FilledButton(
          onPressed: canSubmit ? _review : null,
          child: Text(
            widget.submitting
                ? l10n.preparingWithdrawal
                : l10n.reviewWithdrawal,
          ),
        ),
      ],
    );
  }

  DecimalValue? _parseAmount(String value) {
    if (value.isEmpty) return null;
    try {
      return DecimalValue(value, asset: widget.token, unit: 'token');
    } on FormatException {
      return null;
    }
  }
}

class _RouteCard extends StatelessWidget {
  const _RouteCard({required this.token, required this.chain});

  final String token;
  final String chain;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      height: 104,
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            child: _RouteRow(
              label: AppLocalizations.of(context).token,
              value: token,
              asset: _tokenIcon(token),
              raster: token == 'USDT',
            ),
          ),
          Divider(),
          Expanded(
            child: _RouteRow(
              label: AppLocalizations.of(context).network,
              value: chain,
              asset: _networkIcon(chain),
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteRow extends StatelessWidget {
  const _RouteRow({
    required this.label,
    required this.value,
    required this.asset,
    this.raster = false,
  });

  final String label;
  final String value;
  final String asset;
  final bool raster;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        Expanded(child: Text(label)),
        SizedBox(
          width: 24,
          height: 24,
          child: raster
              ? Image.asset(asset, width: 24, height: 24)
              : SvgPicture.asset(asset, width: 24, height: 24),
        ),
        const SizedBox(width: 8),
        Text(value, style: _strongText),
      ],
    ),
  );
}

class _WithdrawalReview extends StatelessWidget {
  const _WithdrawalReview({
    required this.quote,
    required this.prepared,
    required this.error,
    required this.onBack,
    required this.onSubmit,
    required this.submitting,
  });

  final WithdrawalQuote quote;
  final PreparedSelfCustodialWithdrawal? prepared;
  final String? error;
  final VoidCallback onBack;
  final VoidCallback onSubmit;
  final bool submitting;

  /// An empty native balance no longer blocks the review: the platform may
  /// cover the fee. Confirming asks the server first, and the wallet is only
  /// required to pay when sponsorship is refused, which raises the gas error
  /// then rather than pre-emptively.
  bool get _canSign => prepared != null;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final gas = prepared?.gas;
    final amount = TokenAmountFormatter.format(
      quote.intent.amount,
      symbol: 'USDC',
    );
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      children: [
        AppPageHeader(title: l10n.reviewWithdrawal, onBack: onBack),
        const SizedBox(height: 24),
        Text(
          l10n.youAreSending,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: colors.secondaryText),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 32,
            height: 38 / 32,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          '≈ \$${TokenAmountFormatter.formatValue(quote.intent.amount)}',
          style: Theme.of(context).textTheme.bodyLarge
              ?.copyWith(color: colors.secondaryText),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colors.subtleSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.withdrawalDetails,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              _ReviewDetail(
                label: l10n.to,
                value: _shortAddress(quote.intent.address),
              ),
              const SizedBox(height: 8),
              _ReviewDetail(label: l10n.network, value: quote.intent.chain),
              const SizedBox(height: 8),
              _ReviewDetail(
                label: l10n.networkFee,
                // Gas is paid from the wallet in the chain's native asset, not
                // in the token being withdrawn.
                value: gas == null
                    ? '—'
                    : '≈ ${TokenAmountFormatter.format(gas.estimatedNativeFee, symbol: gas.nativeAsset)}',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _BreakdownRow(
          label: l10n.recipientReceives,
          value: TokenAmountFormatter.format(
            quote.estimatedReceive,
            symbol: 'USDC',
          ),
          mutedLabel: true,
        ),
        const Divider(height: 17),
        _BreakdownRow(label: l10n.totalDeducted, value: amount),
        const SizedBox(height: 12),
        Text(
          l10n.finalNetworkFeeMayVary,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: colors.secondaryText),
        ),
        if (error != null) ...[
          const SizedBox(height: 12),
          Text(
            error!,
            style: TextStyle(
              color: Theme.of(context).extension<AppSemanticColors>()!.loss,
            ),
          ),
        ],
        const SizedBox(height: 40),
        FilledButton(
          onPressed: submitting || !_canSign ? null : onSubmit,
          child: Text(l10n.withdrawUsdc),
        ),
      ],
    );
  }

  static String _shortAddress(String value) {
    if (value.length <= 18) return value;
    return '${value.substring(0, 10)}...${value.substring(value.length - 4)}';
  }
}

class _AssetSelector extends ConsumerStatefulWidget {
  const _AssetSelector();

  @override
  ConsumerState<_AssetSelector> createState() => _AssetSelectorState();
}

class _AssetSelectorState extends ConsumerState<_AssetSelector> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final assets = ref.watch(withdrawalAssetsProvider);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
          children: [
            AppPageHeader(
              title: l10n.selectAsset,
              fallbackLocation: AppRoutes.assetsPath,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 44,
              child: TextField(
                onChanged: (value) => setState(() => query = value),
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      'assets/figma/home_markets/search.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        colors.primaryText,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  hintText: l10n.searchAssets,
                  fillColor: colors.subtleSurface,
                ),
              ),
            ),
            const SizedBox(height: 16),
            assets.when(
              loading: () => const SizedBox(
                height: 360,
                child: LoadingSkeleton(
                  rows: 4,
                  padding: EdgeInsets.only(top: 16),
                ),
              ),
              error: (_, _) => FailureState(
                height: 420,
                title: l10n.unableToLoadAssets,
                description: l10n.checkConnectionRetry,
                onRetry: () async {
                  ref.invalidate(tradingAccountsProvider);
                  await ref.read(tradingAccountsProvider.future);
                  ref.invalidate(withdrawalAssetsProvider);
                  await ref.read(withdrawalAssetsProvider.future);
                },
              ),
              data: (items) {
                final filtered = items
                    .where(
                      (asset) => '${asset.symbol} ${asset.chain}'
                          .toLowerCase()
                          .contains(query.toLowerCase()),
                    )
                    .toList(growable: false);
                if (filtered.isEmpty) {
                  return SizedBox(
                    height: 400,
                    child: EmptyState(
                      title: query.isEmpty
                          ? l10n.noAssetsAvailable
                          : l10n.noMatchingAssets,
                      description: query.isEmpty
                          ? l10n.assetsWithBalanceAppearHere
                          : l10n.tryDifferentAssetOrNetwork,
                    ),
                  );
                }
                return Column(
                  children: [
                    for (final asset in filtered) _AssetRow(asset: asset),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AssetRow extends StatelessWidget {
  const _AssetRow({required this.asset});

  final WithdrawableAsset asset;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => context.push(
      AppRoutes.withdrawalLocation(token: asset.symbol, chain: asset.chain),
    ),
    child: SizedBox(
      height: 72,
      child: Row(
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: asset.symbol == 'USDT'
                ? Image.asset(_tokenIcon(asset.symbol), width: 40, height: 40)
                : SvgPicture.asset(
                    _tokenIcon(asset.symbol),
                    width: 40,
                    height: 40,
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [Text(asset.symbol, style: _strongText)]),
                Text(
                  '${_assetName(asset.symbol)} · ${asset.chain}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .extension<AppRwaColors>()!
                        .secondaryText,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                TokenAmountFormatter.formatValue(
                  asset.balance,
                  decimals: asset.decimals,
                ),
                style: _strongText,
              ),
              Text(
                asset.valueUsd == null
                    ? '—'
                    : TokenAmountFormatter.formatUsd(asset.valueUsd!),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .extension<AppRwaColors>()!
                      .secondaryText,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _InputCard extends StatelessWidget {
  const _InputCard({super.key, required this.height, required this.child});

  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: Theme.of(context).textTheme.bodySmall?.copyWith(
      color: Theme.of(context).extension<AppRwaColors>()!.secondaryText,
    ),
  );
}

class _ReviewDetail extends StatelessWidget {
  const _ReviewDetail({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _FieldLabel(label),
      Flexible(child: Text(value, textAlign: TextAlign.right)),
    ],
  );
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({
    required this.label,
    required this.value,
    this.mutedLabel = false,
  });

  final String label;
  final String value;
  final bool mutedLabel;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: mutedLabel
              ? Theme.of(context).extension<AppRwaColors>()!.secondaryText
              : null,
        ),
      ),
      Text(value, style: _strongText),
    ],
  );
}

const _strongText = TextStyle(
  fontSize: 15,
  height: 22 / 15,
  fontWeight: FontWeight.w600,
);

OutlineInputBorder _withdrawalInputBorder(Color color, {double width = 1}) =>
    OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      borderSide: BorderSide(color: color, width: width),
    );

String _tokenIcon(String symbol) => switch (symbol.toUpperCase()) {
  'USDT' => 'assets/figma/funding/usdt.png',
  'NVDAB' => 'assets/figma/home_markets/nvidia.svg',
  'TSLAB' => 'assets/figma/home_markets/tesla.svg',
  _ => 'assets/figma/funding/usdc.svg',
};

String _networkIcon(String chain) => switch (chain.toLowerCase()) {
  'bsc' || 'bnb chain' => 'assets/figma/funding/bnb_chain.svg',
  _ => 'assets/figma/funding/arbitrum.svg',
};

String _assetName(String symbol) => switch (symbol.toUpperCase()) {
  'USDC' => 'USD Coin',
  'USDT' => 'Tether USD',
  'NVDAB' => 'NVIDIA',
  'TSLAB' => 'Tesla',
  _ => symbol,
};

bool _isEvmAddress(String value) =>
    RegExp(r'^0x[a-fA-F0-9]{40}$').hasMatch(value);
