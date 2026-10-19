import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/portfolio_asset.dart';
import 'package:nobell/domain/models/trading_account.dart';
import 'package:nobell/domain/models/wallet_action_execution.dart';
import 'package:nobell/domain/models/withdrawal.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/adaptive/app_adaptive_dialogs.dart';
import 'package:nobell/ui/core/feedback/empty_state.dart';
import 'package:nobell/ui/core/feedback/failure_state.dart';
import 'package:nobell/ui/core/feedback/app_toast.dart';
import 'package:nobell/ui/core/feedback/loading_skeleton.dart';
import 'package:nobell/ui/core/formatters/token_amount_formatter.dart';
import 'package:nobell/ui/core/navigation/app_page_header.dart';
import 'package:nobell/ui/core/network/network_icon_assets.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/core/widgets/app_filter_menu.dart';
import 'package:nobell/ui/features/funding/providers/self_custodial_withdrawal_providers.dart';
import 'package:nobell/ui/features/funding/providers/withdrawal_providers.dart';
import 'package:nobell/ui/features/portfolio/providers/portfolio_providers.dart';
import 'package:nobell/ui/features/markets/views/market_product_widgets.dart';

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
    } on Object catch (failure) {
      if (!mounted) return;
      setState(() {
        quoting = false;
        error = _withdrawalErrorMessage(failure);
      });
    }
  }

  Future<void> _submit() async {
    final currentQuote = quote;
    final current = prepared;
    if (currentQuote == null || current == null || submitting) return;
    setState(() => submitting = true);
    // Let the disabled button and progress indicator paint before wallet or
    // network work starts. Some embedded-wallet calls can otherwise keep the
    // first visible frame waiting long enough to make the tap look ignored.
    await WidgetsBinding.instance.endOfFrame;
    if (!mounted) return;
    final openingBalance = await _readWithdrawableBalance(currentQuote);
    if (!mounted) return;
    try {
      await ref
          .read(selfCustodialWithdrawalCommandsProvider)
          .execute(quote: currentQuote, prepared: current);
      final balanceUpdated = await _waitForBalanceChange(
        currentQuote,
        openingBalance,
      );
      if (mounted) {
        ref.invalidate(portfolioSummaryProvider);
        _completeSubmission(
          balanceUpdated
              ? AppLocalizations.of(context).withdrawalSucceeded
              : AppLocalizations.of(context).balanceRefreshFailed,
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
    } on InsufficientWithdrawalGas catch (failure) {
      if (mounted) setState(() => error = _gasError(failure.estimate));
    } on Object catch (failure) {
      if (mounted) {
        AppToast.showFailure(context, _withdrawalErrorMessage(failure));
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
      final balanceUpdated = await _waitForBalanceChange(
        currentQuote,
        openingBalance,
      );
      if (mounted) {
        ref.invalidate(portfolioSummaryProvider);
        _completeSubmission(
          balanceUpdated
              ? AppLocalizations.of(context).withdrawalSucceeded
              : AppLocalizations.of(context).balanceRefreshFailed,
        );
      }
    } on InsufficientWithdrawalGas catch (failure) {
      if (mounted) setState(() => error = _gasError(failure.estimate));
    } on Object catch (failure) {
      if (mounted) {
        AppToast.showFailure(context, _withdrawalErrorMessage(failure));
      }
    }
  }

  void _completeSubmission(String message) {
    address.clear();
    amount.clear();
    setState(() {
      quote = null;
      prepared = null;
      error = null;
      submitting = false;
      waitingForBalance = false;
    });
    AppToast.showSuccess(context, message);
  }

  String _withdrawalErrorMessage(Object failure) {
    if (failure is ApiFailure) {
      return apiFailureMessage(
        failure,
        fallback: AppLocalizations.of(context).prepareWithdrawalFailed,
      );
    }
    if (failure is FormatException && failure.message.trim().isNotEmpty) {
      return failure.message;
    }
    final message = failure.toString().trim();
    if (message.isNotEmpty && message != 'null') return message;
    return AppLocalizations.of(context).prepareWithdrawalFailed;
  }

  Future<DecimalValue?> _readWithdrawableBalance(WithdrawalQuote quote) async {
    try {
      final accounts = await ref.read(tradingAccountsProvider.future);
      return _matchingBalance(accounts, quote);
    } on Object {
      return null;
    }
  }

  Future<bool> _waitForBalanceChange(
    WithdrawalQuote quote,
    DecimalValue? openingBalance,
  ) async {
    if (openingBalance == null) return true;
    if (mounted) setState(() => waitingForBalance = true);
    final attempts =
        _balancePollTimeout.inMilliseconds ~/
        _balancePollInterval.inMilliseconds;
    try {
      for (var attempt = 0; attempt < attempts; attempt++) {
        await Future<void>.delayed(_balancePollInterval);
        if (!mounted) return false;
        try {
          final accounts = await ref.refresh(tradingAccountsProvider.future);
          final current = _matchingBalance(accounts, quote);
          if (current != null && current.compareTo(openingBalance) < 0) {
            return true;
          }
        } on Object {
          // A transient balance request failure should not hide a submitted withdrawal.
        }
      }
      return false;
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
    final accounts = ref.watch(tradingAccountsProvider).value;
    final selectedAsset = ref
        .watch(withdrawalAssetsProvider)
        .value
        ?.where(
          (asset) =>
              asset.symbol == widget.token &&
              normalizeChainLabel(asset.chain) ==
                  normalizeChainLabel(widget.chain),
        )
        .firstOrNull;
    final sourceAddress = accounts
        ?.where((account) => account.kind != TradingAccountKind.hip3)
        .where(
          (account) =>
              normalizeChainLabel(account.chain ?? '') ==
              normalizeChainLabel(widget.chain),
        )
        .map((account) => account.address)
        .whereType<String>()
        .firstOrNull;
    return Scaffold(
      body: SafeArea(
        child: quote == null
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
                sourceAddress: sourceAddress,
                error: error,
                onBack: () => setState(() {
                  quote = null;
                  prepared = null;
                  error = null;
                }),
                onSubmit: _submit,
                submitting: submitting || waitingForBalance,
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
    final availableBalance = widget.asset?.availableBalance;
    final hasAvailableBalance =
        availableBalance != null &&
        availableBalance.compareTo(
              DecimalValue('0', asset: widget.token, unit: 'token'),
            ) >
            0;
    final canSubmit =
        !widget.submitting &&
        widget.asset?.isWithdrawalSupported == true &&
        hasAvailableBalance &&
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
        parsedAmount.compareTo(availableBalance) <= 0;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      children: [
        AppPageHeader(
          title: l10n.withdraw,
          fallbackLocation: AppRoutes.withdrawalAssetSelectPath,
        ),
        const SizedBox(height: 16),
        _RouteCard(
          token: widget.token,
          chain: widget.chain,
          onSelectAsset: () =>
              context.push(AppRoutes.withdrawalAssetSelectPath),
        ),
        const SizedBox(height: 16),
        _InputCard(
          key: const ValueKey('withdrawal-address-card'),
          height: _addressError == null ? 80 : 104,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FieldLabel(l10n.recipientAddress),
              const SizedBox(height: 4),
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
                        filled: false,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        isCollapsed: true,
                        contentPadding: EdgeInsets.zero,
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
        const SizedBox(height: 16),
        _InputCard(
          key: const ValueKey('withdrawal-amount-card'),
          height: 96,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _FieldLabel(l10n.amount),
                  _FieldLabel(
                    l10n.availableTokenAmount(
                      availableBalance == null
                          ? '—'
                          : TokenAmountFormatter.formatValue(
                              availableBalance,
                              decimals: widget.asset!.decimals,
                            ),
                      widget.token,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      key: const ValueKey('withdrawal-amount-field'),
                      controller: widget.amount,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        hintText: '0.00',
                        filled: false,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        isCollapsed: true,
                        contentPadding: EdgeInsets.zero,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '≈ \$$displayAmount',
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: colors.secondaryText),
                  ),
                  TextButton(
                    onPressed: hasAvailableBalance
                        ? () => widget.amount.text = availableBalance.value
                        : null,
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
        const SizedBox(height: 16),
        _WithdrawalEstimateCard(amount: parsedAmount, token: widget.token),
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
          child: widget.submitting
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.reviewWithdrawal),
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
  const _RouteCard({
    required this.token,
    required this.chain,
    required this.onSelectAsset,
  });

  final String token;
  final String chain;
  final VoidCallback onSelectAsset;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      key: const ValueKey('withdrawal-route-card'),
      height: 155,
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            child: _RouteRow(
              key: const ValueKey('withdrawal-network-selector'),
              label: AppLocalizations.of(context).network,
              value: networkDisplayName(chain),
              onTap: onSelectAsset,
              showChevron: true,
              chevronKey: const ValueKey('withdrawal-network-selector-arrow'),
              icon: SvgPicture.asset(
                _networkIcon(chain),
                width: 24,
                height: 24,
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: _RouteRow(
              key: const ValueKey('withdrawal-token-selector'),
              label: AppLocalizations.of(context).token,
              value: token,
              onTap: onSelectAsset,
              showChevron: true,
              chevronKey: const ValueKey('withdrawal-token-selector-arrow'),
              icon: _WithdrawalAssetMark(
                symbol: token,
                chain: chain,
                isBstock: false,
                size: 24,
                showNetworkMark: false,
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: _RouteRow(
              label: AppLocalizations.of(context).signatureFrom,
              value: AppLocalizations.of(context).spotAccount,
              valueKey: const ValueKey('withdrawal-from-value'),
              icon: SvgPicture.asset(
                'assets/figma/funding/venue_bnb_chain_24.svg',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteRow extends StatelessWidget {
  const _RouteRow({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.onTap,
    this.showChevron = false,
    this.chevronKey,
    this.valueKey,
  });

  final String label;
  final String value;
  final Widget icon;
  final VoidCallback? onTap;
  final bool showChevron;
  final Key? chevronKey;
  final Key? valueKey;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(label)),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 24, height: 24, child: icon),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    value,
                    key: valueKey,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: _strongText,
                  ),
                ),
                if (showChevron) ...[
                  const SizedBox(width: 8),
                  SvgPicture.asset(
                    'assets/figma/funding/chevron_right.svg',
                    key: chevronKey,
                    width: 20,
                    height: 20,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
    if (onTap == null) return content;
    return Semantics(
      button: true,
      child: InkWell(onTap: onTap, child: content),
    );
  }
}

class _WithdrawalEstimateCard extends StatelessWidget {
  const _WithdrawalEstimateCard({required this.amount, required this.token});

  final DecimalValue? amount;
  final String token;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.subtleSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: _ReviewDetail(
        label: l10n.recipientReceives,
        value: amount == null
            ? '— $token'
            : TokenAmountFormatter.format(amount!, symbol: token),
      ),
    );
  }
}

class _WithdrawalReview extends StatelessWidget {
  const _WithdrawalReview({
    required this.quote,
    required this.prepared,
    required this.sourceAddress,
    required this.error,
    required this.onBack,
    required this.onSubmit,
    required this.submitting,
  });

  final WithdrawalQuote quote;
  final PreparedSelfCustodialWithdrawal? prepared;
  final String? sourceAddress;
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
    final amount = TokenAmountFormatter.format(
      quote.intent.amount,
      symbol: quote.intent.amount.asset ?? 'USDC',
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
                label: l10n.fromSpotAccount,
                value: _shortAddress(
                  prepared?.transaction.from ?? sourceAddress ?? '—',
                ),
              ),
              const SizedBox(height: 8),
              _ReviewDetail(
                label: l10n.to,
                value: _shortAddress(quote.intent.address),
              ),
              const SizedBox(height: 8),
              _ReviewDetail(
                label: l10n.network,
                value: networkDisplayName(quote.intent.chain),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _BreakdownRow(
          label: l10n.recipientReceives,
          value: TokenAmountFormatter.format(
            quote.estimatedReceive,
            symbol: quote.intent.amount.asset ?? 'USDC',
          ),
          mutedLabel: true,
        ),
        const Divider(height: 17),
        _BreakdownRow(label: l10n.totalDeducted, value: amount),
        const SizedBox(height: 12),
        Text(
          l10n.networkFeeCoveredByPlatform,
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
        SizedBox(
          height: 48,
          child: FilledButton(
            onPressed: submitting || !_canSign ? null : onSubmit,
            child: submitting
                ? const SizedBox.square(
                    key: ValueKey('withdrawal-submit-progress'),
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    l10n.signAndWithdraw(quote.intent.amount.asset ?? 'USDC'),
                  ),
          ),
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
  String? network;

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
            Row(
              children: [
                Expanded(
                  child: AppPageHeader(
                    title: l10n.withdraw,
                    fallbackLocation: AppRoutes.withdrawalSelectPath,
                  ),
                ),
                TextButton.icon(
                  onPressed: () =>
                      context.go('${AppRoutes.activityPath}?tab=cash'),
                  style: TextButton.styleFrom(
                    foregroundColor: colors.secondaryText,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  icon: SvgPicture.asset(
                    'assets/figma/funding/activity.svg',
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      colors.secondaryText,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: Text(l10n.history),
                ),
              ],
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
            Text(
              l10n.availableToWithdraw,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: colors.tertiaryText),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: AppFilterMenu<String?>(
                key: const ValueKey('withdrawal-network-filter'),
                value: network,
                label: network ?? l10n.allNetworks,
                onChanged: (value) => setState(() => network = value),
                options: [
                  AppFilterOption(value: null, label: l10n.allNetworks),
                  for (final value
                      in (assets.value ?? const <WithdrawableAsset>[])
                          .map((asset) => asset.chain)
                          .toSet())
                    AppFilterOption(value: value, label: value),
                ],
              ),
            ),
            const SizedBox(height: 8),
            assets.when(
              loading: () => const SizedBox(
                height: 360,
                child: LoadingSkeleton(
                  rows: 4,
                  padding: EdgeInsets.only(top: 16),
                ),
              ),
              error: (error, _) => FailureState(
                error: error,
                height: 420,
                title: l10n.unableToLoadAssets,
                description: l10n.checkConnectionRetry,
                onRetry: () async {
                  ref.invalidate(withdrawalAssetsProvider);
                  await ref.read(withdrawalAssetsProvider.future);
                },
              ),
              data: (items) {
                final filtered = items
                    .where(
                      (asset) =>
                          (network == null || asset.chain == network) &&
                          '${asset.symbol} ${asset.chain}'
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
                    for (final (index, asset) in filtered.indexed) ...[
                      _AssetRow(asset: asset),
                      if (index != filtered.length - 1)
                        const SizedBox(height: 8),
                    ],
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
  Widget build(BuildContext context) {
    final isBstock = asset.productId != null;
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final returnText = _holdingReturnText(asset);
    return InkWell(
      onTap: () => context.push(
        AppRoutes.withdrawalLocation(token: asset.symbol, chain: asset.chain),
      ),
      child: SizedBox(
        key: ValueKey('withdrawal-asset-row-${asset.key}'),
        height: isBstock ? 76 : 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                _WithdrawalAssetMark(
                  symbol: asset.symbol,
                  chain: asset.chain,
                  isBstock: isBstock,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(asset.symbol, style: _strongText),
                      const SizedBox(height: 2),
                      if (isBstock)
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/figma/home_markets/venue_bnb.svg',
                              width: 14,
                              height: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              AppLocalizations.of(context).bstocks,
                              style: _assetMetaStyle(colors),
                            ),
                          ],
                        )
                      else
                        Text(
                          AppLocalizations.of(context).cash,
                          style: _assetMetaStyle(colors),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
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
                    const SizedBox(height: 2),
                    Text(
                      asset.valueUsd == null
                          ? '—'
                          : TokenAmountFormatter.formatUsd(asset.valueUsd!),
                      style: _assetMetaStyle(colors),
                    ),
                  ],
                ),
              ],
            ),
            if (isBstock && returnText != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const SizedBox(width: 52),
                  Text(
                    AppLocalizations.of(context).holdingReturn,
                    style: _assetMetaStyle(colors),
                  ),
                  const Spacer(),
                  Text(
                    returnText,
                    style: _assetMetaStyle(colors)
                        .copyWith(color: _holdingReturnColor(context, asset)),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

TextStyle _assetMetaStyle(AppRwaColors colors) =>
    TextStyle(fontSize: 12, height: 16 / 12, color: colors.secondaryText);

String? _holdingReturnText(WithdrawableAsset asset) {
  final amount = asset.holdingReturnAmountUsd;
  final percent = asset.holdingReturnPercent;
  if (amount == null && percent == null) return null;
  final amountText = amount == null ? null : _formatSignedUsd(amount);
  final percentText = percent == null
      ? null
      : TokenAmountFormatter.formatPercent(
          percent,
          maxFractionDigits: 2,
          trimInsignificantZeros: false,
        );
  if (amountText == null) return '($percentText)';
  if (percentText == null) return amountText;
  return '$amountText ($percentText)';
}

String _formatSignedUsd(DecimalValue value) {
  final formatted = TokenAmountFormatter.formatUsdFixed(value);
  return value.value.startsWith('-') ||
          RegExp(r'^0(?:\.0+)?$').hasMatch(value.value)
      ? formatted
      : '+$formatted';
}

Color _holdingReturnColor(BuildContext context, WithdrawableAsset asset) {
  final value =
      asset.holdingReturnAmountUsd?.value ?? asset.holdingReturnPercent?.value;
  final semantic = Theme.of(context).extension<AppSemanticColors>()!;
  return value?.startsWith('-') ?? false ? semantic.loss : semantic.success;
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(12),
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

class _WithdrawalAssetMark extends StatelessWidget {
  const _WithdrawalAssetMark({
    required this.symbol,
    required this.chain,
    required this.isBstock,
    this.size = 40,
    this.showNetworkMark = true,
  });

  final String symbol;
  final String chain;
  final bool isBstock;
  final double size;
  final bool showNetworkMark;

  @override
  Widget build(BuildContext context) {
    final networkAsset = networkIconAssetPath(
      chain,
      variant: NetworkIconVariant.mark,
    );
    return SizedBox.square(
      dimension: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(child: _assetMark()),
          if (showNetworkMark && networkAsset != null)
            Positioned(
              right: 0,
              bottom: 0,
              child: _WithdrawalNetworkMark(
                chain: chain,
                key: ValueKey('withdrawal-network-mark-$chain'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _assetMark() {
    if (isBstock) {
      return MarketProductMark(
        product: MarketProductRef(
          symbol: symbol,
          kind: MarketProductKind.bstock,
        ),
        size: size,
      );
    }
    return switch (symbol.toUpperCase()) {
      'USDT' => Image.asset(
        'assets/figma/funding/usdt.png',
        width: size,
        height: size,
      ),
      'USDC' => SvgPicture.asset(
        'assets/figma/funding/usdc.svg',
        width: size,
        height: size,
      ),
      _ => MarketAssetLookupMark(symbol: symbol, size: size),
    };
  }
}

class _WithdrawalNetworkMark extends StatelessWidget {
  const _WithdrawalNetworkMark({super.key, required this.chain});

  final String chain;

  @override
  Widget build(BuildContext context) {
    final kind = networkKind(chain);
    if (kind == NetworkKind.bsc) {
      return SvgPicture.asset(
        'assets/figma/funding/withdrawal_network_bsc.svg',
        width: 16,
        height: 16,
      );
    }
    if (kind == NetworkKind.arbitrum || kind == NetworkKind.ethereum) {
      final asset = kind == NetworkKind.arbitrum
          ? NetworkIconAssets.arbitrumMark
          : NetworkIconAssets.ethereumMark;
      return Container(
        width: 16,
        height: 16,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kind == NetworkKind.arbitrum
              ? const Color(0xFF2F3749)
              : const Color(0xFF627EEA),
          border: Border.all(
            color: Theme.of(context).extension<AppRwaColors>()!.border,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: SvgPicture.asset(
          asset,
          width: kind == NetworkKind.arbitrum ? 10.7 : 7.5,
          height: 12,
        ),
      );
    }
    final asset = networkIconAssetPath(chain, variant: NetworkIconVariant.mark);
    return asset == null
        ? const SizedBox.shrink()
        : SvgPicture.asset(asset, width: 16, height: 16);
  }
}

String _networkIcon(String chain) =>
    networkIconAssetPath(chain) ?? NetworkIconAssets.arbitrum;

bool _isEvmAddress(String value) =>
    RegExp(r'^0x[a-fA-F0-9]{40}$').hasMatch(value);
