import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/hip3_withdrawal_preview.dart';
import 'package:nobell/domain/models/hip3_withdrawal.dart';
import 'package:nobell/domain/models/portfolio_allocation.dart';
import 'package:nobell/domain/models/trading_account.dart';
import 'package:nobell/domain/models/wallet.dart';
import 'package:nobell/domain/services/hip3_typed_data_signer.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/feedback/app_toast.dart';
import 'package:nobell/ui/core/feedback/loading_skeleton.dart';
import 'package:nobell/ui/core/feedback/rwa_tooltip.dart';
import 'package:nobell/ui/core/formatters/token_amount_formatter.dart';
import 'package:nobell/ui/core/navigation/app_page_header.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/funding/hip3_withdrawal_blocker_message.dart';
import 'package:nobell/ui/features/funding/providers/hip3_withdrawal_providers.dart';
import 'package:nobell/ui/features/account/providers/account_providers.dart';
import 'package:nobell/ui/features/orders/views/hip3_cross_liquidation_impacts_card.dart';
import 'package:nobell/ui/features/portfolio/providers/portfolio_providers.dart';
import 'package:nobell/ui/core/widgets/venue_icon.dart';

import '../../../core/feedback/error_message.dart';

class PerpsWithdrawalScreen extends ConsumerStatefulWidget {
  const PerpsWithdrawalScreen({super.key});

  @override
  ConsumerState<PerpsWithdrawalScreen> createState() =>
      _PerpsWithdrawalScreenState();
}

class _PerpsWithdrawalScreenState extends ConsumerState<PerpsWithdrawalScreen> {
  final _amount = TextEditingController();
  Hip3WithdrawalPreview? _preview;
  Hip3Withdrawal? _withdrawal;
  Timer? _withdrawalRefresh;
  bool _withdrawalPolling = false;
  String? _previewInputAmount;
  String? _error;
  Timer? _previewDebounce;
  Timer? _previewRefresh;
  var _previewSequence = 0;
  var _previewing = false;
  var _reviewing = false;
  var _submitting = false;

  @override
  void initState() {
    super.initState();
    _amount.addListener(_schedulePreview);
  }

  @override
  void dispose() {
    _previewDebounce?.cancel();
    _previewRefresh?.cancel();
    _withdrawalRefresh?.cancel();
    _amount
      ..removeListener(_schedulePreview)
      ..dispose();
    super.dispose();
  }

  void _schedulePreview() {
    if (_withdrawal?.isPending == true) return;
    _previewDebounce?.cancel();
    _previewRefresh?.cancel();
    final sequence = ++_previewSequence;
    final amount = _amount.text.trim();
    final valid = _isPositiveUsdc(amount);
    setState(() {
      _preview = null;
      _previewInputAmount = null;
      _previewing = valid;
      _error = null;
    });
    if (!valid) return;
    _previewDebounce = Timer(
      const Duration(milliseconds: 500),
      () => unawaited(_requestPreview(sequence, amount)),
    );
  }

  Future<void> _requestPreview(
    int sequence,
    String amount, {
    bool forceRefresh = false,
  }) async {
    try {
      final preview = await ref
          .read(hip3WithdrawalCommandsProvider)
          .preview(amount, forceRefresh: forceRefresh);
      if (!mounted || sequence != _previewSequence) return;
      setState(() {
        _preview = preview;
        _previewInputAmount = amount;
        _previewing = false;
        _error = hip3WithdrawalBlockerMessage(
          preview,
          AppLocalizations.of(context),
        );
      });
      _schedulePreviewRefresh(preview, sequence, amount);
    } on Object catch (failure) {
      if (!mounted || sequence != _previewSequence) return;
      setState(() {
        _previewing = false;
        _error = _failureMessage(failure);
      });
      final current = _preview;
      if (current != null && _sameAmount(_previewInputAmount, amount)) {
        _schedulePreviewRefresh(current, sequence, amount, retry: true);
      }
    }
  }

  void _schedulePreviewRefresh(
    Hip3WithdrawalPreview preview,
    int sequence,
    String amount, {
    bool retry = false,
  }) {
    _previewRefresh?.cancel();
    final validUntil = preview.riskValidUntil;
    if (validUntil == null && !retry) return;
    final remaining =
        validUntil?.difference(DateTime.now().toUtc()) ?? Duration.zero;
    final delay = retry
        ? const Duration(seconds: 5)
        : remaining > Duration.zero
        ? remaining
        : const Duration(seconds: 1);
    _previewRefresh = Timer(delay, () {
      if (!mounted ||
          sequence != _previewSequence ||
          _reviewing ||
          _submitting ||
          _amount.text.trim() != amount) {
        return;
      }
      setState(() => _previewing = true);
      unawaited(_requestPreview(sequence, amount, forceRefresh: true));
    });
  }

  Future<void> _review() async {
    final value = _amount.text.trim();
    if (!_isPositiveUsdc(value)) {
      setState(
        () => _error = AppLocalizations.of(context).transferEnterPositiveAmount,
      );
      return;
    }
    final current = _preview;
    if (!_previewing &&
        current != null &&
        _sameAmount(_previewInputAmount, value) &&
        !current.isRiskExpired) {
      final blocker = hip3WithdrawalBlockerMessage(
        current,
        AppLocalizations.of(context),
      );
      _previewRefresh?.cancel();
      setState(() {
        _error = blocker;
        _reviewing = blocker == null && current.canProceed;
      });
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
    });
    await WidgetsBinding.instance.endOfFrame;
    if (!mounted) return;
    try {
      final preview = await ref
          .read(hip3WithdrawalCommandsProvider)
          .preview(value, forceRefresh: true);
      if (!mounted) return;
      final blocker = hip3WithdrawalBlockerMessage(
        preview,
        AppLocalizations.of(context),
      );
      setState(() {
        _preview = preview;
        _previewInputAmount = value;
        _error = blocker;
        _reviewing = blocker == null && preview.canProceed;
      });
      if (_reviewing) _previewRefresh?.cancel();
    } on Object catch (failure) {
      if (mounted) setState(() => _error = _failureMessage(failure));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _submit() async {
    var preview = _preview;
    if (preview == null || _submitting || _withdrawal?.isPending == true) {
      return;
    }
    final requestedAmount = _previewInputAmount ?? _amount.text.trim();
    setState(() {
      _submitting = true;
      _error = null;
    });
    await WidgetsBinding.instance.endOfFrame;
    if (!mounted) return;
    try {
      final commands = ref.read(hip3WithdrawalCommandsProvider);
      if (preview.isRiskExpired) {
        preview = await commands.preview(requestedAmount, forceRefresh: true);
        if (!mounted) return;
        final blocker = hip3WithdrawalBlockerMessage(
          preview,
          AppLocalizations.of(context),
        );
        setState(() {
          _preview = preview;
          _error = blocker;
          _reviewing = false;
        });
        _schedulePreviewRefresh(preview, _previewSequence, requestedAmount);
        return;
      }
      final prepared = await commands.prepare(
        requestedAmount,
        rail: preview.rail,
        payoutChainId: int.parse(preview.chainId),
      );
      final submitted = prepared.status == 'awaiting_signature'
          ? await commands.submit(prepared)
          : prepared;
      if (!mounted) return;
      _handleWithdrawalStatus(submitted);
    } on Hip3WithdrawalQuoteChanged {
      if (!mounted) return;
      setState(() => _reviewing = false);
      _schedulePreview();
    } on Object catch (failure) {
      if (mounted) setState(() => _error = _failureMessage(failure));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _handleWithdrawalStatus(Hip3Withdrawal withdrawal) {
    if (!mounted) return;
    final wasPending = _withdrawal?.isPending == true;
    _withdrawalRefresh?.cancel();
    _withdrawalRefresh = null;
    final l10n = AppLocalizations.of(context);
    if (withdrawal.status == 'completed') {
      _withdrawal = null;
      ref.invalidate(portfolioSummaryProvider);
      _amount.clear();
      setState(() {
        _preview = null;
        _previewInputAmount = null;
        _error = null;
        _reviewing = false;
      });
      AppToast.showSuccess(context, l10n.withdrawalSucceeded);
      return;
    }
    setState(() {
      _withdrawal = withdrawal;
      _error = withdrawal.requiresManualReview
          ? l10n.hip3PendingReview
          : withdrawal.status == 'failed' || withdrawal.status == 'expired'
          ? errorMessage(
              withdrawal.failureReason ?? '',
              fallback: l10n.transferFailed,
            )
          : null;
    });
    if (withdrawal.isPending &&
        !wasPending &&
        !withdrawal.requiresManualReview) {
      AppToast.showSuccess(context, l10n.transferWaitingArrival);
    }
    if (withdrawal.isPending) {
      _withdrawalRefresh = Timer.periodic(
        const Duration(seconds: 3),
        (_) => unawaited(_pollWithdrawal()),
      );
    }
  }

  Future<void> _pollWithdrawal() async {
    final current = _withdrawal;
    if (!mounted || current == null || _withdrawalPolling) return;
    setState(() => _withdrawalPolling = true);
    try {
      final withdrawal = await ref
          .read(hip3WithdrawalCommandsProvider)
          .refresh(current.id);
      _handleWithdrawalStatus(withdrawal);
    } on Object {
      // Keep the submitted intent visible; a read failure cannot release it.
    } finally {
      if (mounted) setState(() => _withdrawalPolling = false);
    }
  }

  String _failureMessage(Object failure) {
    final l10n = AppLocalizations.of(context);
    return switch (failure) {
      ApiFailure value => apiFailureMessage(
        value,
        fallback: l10n.prepareWithdrawalFailed,
      ),
      Hip3SigningFailure value =>
        value.reason ??
            switch (value.code) {
              Hip3SigningFailureCode.actionExpired =>
                l10n.hip3SigningRequestExpired,
              Hip3SigningFailureCode.walletUnavailable =>
                l10n.hip3SigningWalletUnavailable,
              Hip3SigningFailureCode.walletMismatch =>
                l10n.walletConnectRequired,
              _ => l10n.hip3SigningRequestInvalid,
            },
      _ => errorMessage(failure, fallback: l10n.prepareWithdrawalFailed),
    };
  }

  @override
  Widget build(BuildContext context) {
    final accounts = ref.watch(tradingAccountsProvider).value;
    final sourceAddress = accounts
        ?.where((account) => account.kind == TradingAccountKind.hip3)
        .map((account) => account.address)
        .whereType<String>()
        .firstOrNull;
    final walletAddress = ref
        .watch(walletsProvider(null))
        .value
        ?.items
        .where((wallet) => wallet.status == WalletState.active)
        .map((wallet) => wallet.address)
        .firstOrNull;
    final balance = ref.watch(hip3TransferBalanceProvider);
    final availableBalance = _preview?.maximumTransferable ?? balance.value;
    final recipientAddress = _preview?.destinationAddress ?? walletAddress;
    final perpsAllocation = ref
        .watch(portfolioRailAllocationProvider)
        .value
        ?.perps;
    return Scaffold(
      body: SafeArea(
        child: _reviewing && _preview != null
            ? _PerpsWithdrawalReview(
                preview: _preview!,
                sourceAddress: sourceAddress,
                onBack: () {
                  if (_withdrawal?.isPending == true) {
                    Navigator.of(context).maybePop();
                    return;
                  }
                  setState(() {
                    _reviewing = false;
                    _error = null;
                  });
                  scheduleMicrotask(_schedulePreview);
                },
                onSubmit: _submit,
                submitting: _submitting,
                pending: _withdrawal?.isPending == true,
                error: _error,
              )
            : _PerpsWithdrawalForm(
                amount: _amount,
                balance: availableBalance,
                balanceLoading: balance.isLoading && _preview == null,
                allocation: perpsAllocation,
                walletAddress: recipientAddress,
                preview: _preview,
                previewInputAmount: _previewInputAmount,
                previewing: _previewing,
                error: _error,
                submitting: _submitting,
                onReview: _review,
              ),
      ),
    );
  }
}

class _PerpsWithdrawalForm extends StatefulWidget {
  const _PerpsWithdrawalForm({
    required this.amount,
    required this.balance,
    required this.balanceLoading,
    required this.allocation,
    required this.walletAddress,
    required this.preview,
    required this.previewInputAmount,
    required this.previewing,
    required this.error,
    required this.submitting,
    required this.onReview,
  });

  final TextEditingController amount;
  final String? balance;
  final bool balanceLoading;
  final PortfolioAccountAllocation? allocation;
  final String? walletAddress;
  final Hip3WithdrawalPreview? preview;
  final String? previewInputAmount;
  final bool previewing;
  final String? error;
  final bool submitting;
  final VoidCallback onReview;

  @override
  State<_PerpsWithdrawalForm> createState() => _PerpsWithdrawalFormState();
}

class _PerpsWithdrawalFormState extends State<_PerpsWithdrawalForm> {
  @override
  void initState() {
    super.initState();
    widget.amount.addListener(_refresh);
  }

  @override
  void didUpdateWidget(covariant _PerpsWithdrawalForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.amount != widget.amount) {
      oldWidget.amount.removeListener(_refresh);
      widget.amount.addListener(_refresh);
    }
  }

  @override
  void dispose() {
    widget.amount.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final amount = widget.amount.text.trim();
    final positiveAmount = _isPositiveUsdc(amount);
    final previewMatches = _sameAmount(widget.previewInputAmount, amount);
    final deductedAmount = previewMatches ? widget.preview?.amount : amount;
    final withinBalance = _withinBalance(
      deductedAmount ?? amount,
      widget.balance,
    );
    final previewCanProceed = widget.preview?.canProceed == true;
    final previewCurrent = widget.preview?.isRiskExpired == false;
    final canSubmit =
        !widget.submitting &&
        !widget.previewing &&
        widget.walletAddress != null &&
        positiveAmount &&
        withinBalance &&
        previewMatches &&
        previewCanProceed &&
        previewCurrent;
    final validationError =
        widget.error ??
        _disabledReason(
          l10n: l10n,
          amountIsPositive: positiveAmount,
          loading: widget.previewing || widget.submitting,
          walletAddress: widget.walletAddress,
          balance: widget.balance,
          withinBalance: withinBalance,
          preview: widget.preview,
          previewMatches: previewMatches,
          previewCurrent: previewCurrent,
          previewCanProceed: previewCanProceed,
        );
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
          sliver: SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppPageHeader(
                  title: l10n.withdraw,
                  fallbackLocation: AppRoutes.withdrawalSelectPath,
                ),
                const SizedBox(height: 16),
                const _PerpsRouteCard(),
                const SizedBox(height: 16),
                _ReadOnlyDestinationCard(address: widget.walletAddress),
                const SizedBox(height: 16),
                Container(
                  key: const Key('perps-withdrawal-amount-card'),
                  height: 96,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.surfaceBase,
                    border: Border.all(color: colors.borderSubtle),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _MutedText(l10n.amount),
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: widget.balanceLoading
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            _MutedText(l10n.available),
                                            const SizedBox(width: 4),
                                            const SkeletonBlock(
                                              key: Key(
                                                'perps-withdrawal-balance-skeleton',
                                              ),
                                              width: 48,
                                              height: 10,
                                              radius: 4,
                                            ),
                                            const SizedBox(width: 4),
                                            const _MutedText('USDC'),
                                          ],
                                        )
                                      : Text(
                                          l10n.availableTokenAmount(
                                            widget.balance == null
                                                ? '—'
                                                : TokenAmountFormatter.formatText(
                                                    widget.balance!,
                                                  ),
                                            'USDC',
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: colors.textSecondary,
                                              ),
                                        ),
                                ),
                                const SizedBox(width: 3),
                                _PerpsAvailableTooltip(
                                  available: widget.balance,
                                  allocation: widget.allocation,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                key: const Key('perps-withdrawal-amount-field'),
                                controller: widget.amount,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
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
                            const Text('USDC', style: _strongText),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _MutedText(
                            amount.isEmpty ? r'≈ $0.00' : '≈ \$$amount',
                          ),
                          TextButton(
                            onPressed: widget.balance == null
                                ? null
                                : () => widget.amount.text = widget.balance!,
                            style: TextButton.styleFrom(
                              foregroundColor: colors.textPrimary,
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
                _EstimateCard(
                  preview: widget.preview,
                  loading: widget.previewing,
                ),
                if (widget.previewing) ...[
                  const SizedBox(height: 12),
                  const Hip3CrossLiquidationImpactsSkeleton(
                    key: Key('perps-withdrawal-position-impact-skeleton'),
                  ),
                ] else if (widget.preview?.crossLiquidationImpacts.isNotEmpty ==
                    true) ...[
                  const SizedBox(height: 12),
                  Hip3CrossLiquidationImpactsCard(
                    impacts: widget.preview!.crossLiquidationImpacts,
                  ),
                ],
                const Spacer(),
                if (validationError != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    validationError,
                    style: TextStyle(
                      color: Theme.of(context)
                          .extension<AppSemanticColors>()!
                          .danger,
                    ),
                  ),
                ],
                const SizedBox(height: 28),
                SizedBox(
                  height: 48,
                  child: FilledButton(
                    key: const Key('perps-withdrawal-review-button'),
                    onPressed: canSubmit ? widget.onReview : null,
                    child: widget.submitting
                        ? const SizedBox.square(
                            key: Key('perps-withdrawal-review-progress'),
                            dimension: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.reviewWithdrawal),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PerpsWithdrawalReview extends StatelessWidget {
  const _PerpsWithdrawalReview({
    required this.preview,
    required this.sourceAddress,
    required this.onBack,
    required this.onSubmit,
    required this.submitting,
    required this.error,
    required this.pending,
  });

  final Hip3WithdrawalPreview preview;
  final String? sourceAddress;
  final VoidCallback onBack;
  final VoidCallback onSubmit;
  final bool submitting;
  final bool pending;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final amount = '${TokenAmountFormatter.formatText(preview.amount)} USDC';
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      children: [
        AppPageHeader(title: l10n.reviewWithdrawal, onBack: onBack),
        const SizedBox(height: 24),
        _MutedText(l10n.youAreSending.toUpperCase()),
        const SizedBox(height: 4),
        Text(amount, style: _amountText),
        Text(
          '≈ \$${TokenAmountFormatter.formatText(preview.amount)}',
          style: Theme.of(context).textTheme.bodyLarge
              ?.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colors.surfaceSubtle,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.withdrawalDetails, style: _cardTitle),
              const SizedBox(height: 8),
              _DetailRow(
                label: l10n.fromPerpsAccount,
                value: _shortAddress(
                  sourceAddress ?? preview.destinationAddress,
                ),
              ),
              const SizedBox(height: 8),
              _DetailRow(
                label: l10n.to,
                value: _shortAddress(preview.destinationAddress),
              ),
              const SizedBox(height: 8),
              _DetailRow(
                label: l10n.network,
                value: _chainName(preview.chainId),
              ),
              const SizedBox(height: 8),
              _DetailRow(
                label: preview.rail == 'relay'
                    ? l10n.estimatedFee
                    : l10n.networkFee,
                value: '≈ ${TokenAmountFormatter.formatText(preview.fee)} USDC',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _BreakdownRow(
          label: l10n.recipientReceives,
          value:
              '${TokenAmountFormatter.formatText(preview.minimumReceived)} USDC',
          valueKey: const Key('perps-withdrawal-recipient-receives-value'),
          muted: true,
        ),
        const Divider(height: 17),
        _BreakdownRow(
          label: l10n.totalDeducted,
          value: amount,
          valueKey: const Key('perps-withdrawal-total-deducted-value'),
        ),
        if (preview.crossLiquidationImpacts.isNotEmpty) ...[
          const SizedBox(height: 20),
          Hip3CrossLiquidationImpactsCard(
            impacts: preview.crossLiquidationImpacts,
          ),
        ],
        if (error != null) ...[
          const SizedBox(height: 12),
          Text(
            error!,
            style: TextStyle(
              color: Theme.of(context).extension<AppSemanticColors>()!.danger,
            ),
          ),
        ],
        const SizedBox(height: 40),
        SizedBox(
          height: 48,
          child: FilledButton(
            key: const Key('perps-withdrawal-submit-button'),
            onPressed: submitting || pending ? null : onSubmit,
            child: submitting || pending
                ? const SizedBox.square(
                    key: Key('perps-withdrawal-submit-progress'),
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l10n.signAndWithdraw('USDC')),
          ),
        ),
      ],
    );
  }
}

class _PerpsRouteCard extends StatelessWidget {
  const _PerpsRouteCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _RouteContainer(
      children: [
        _RouteRow(
          label: l10n.token,
          value: 'USDC',
          icon: SvgPicture.asset('assets/figma/funding/usdc.svg'),
        ),
        _RouteRow(
          label: l10n.signatureFrom,
          value: l10n.perpsAccount,
          icon: VenueIcon('assets/figma/home_markets/venue_hyperliquid.svg'),
        ),
      ],
    );
  }
}

class _ReadOnlyDestinationCard extends StatelessWidget {
  const _ReadOnlyDestinationCard({required this.address});

  final String? address;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      key: const Key('perps-withdrawal-destination'),
      height: 80,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceBase,
        border: Border.all(color: colors.borderSubtle),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MutedText(l10n.recipientAddress),
          const SizedBox(height: 4),
          KeyedSubtree(
            key: ValueKey(address),
            child: TextFormField(
              key: const Key('perps-withdrawal-address-field'),
              initialValue: address,
              readOnly: true,
              enableInteractiveSelection: true,
              decoration: InputDecoration(
                hintText: l10n.enterWalletAddress,
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                isCollapsed: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: _strongText,
            ),
          ),
        ],
      ),
    );
  }
}

class _EstimateCard extends StatelessWidget {
  const _EstimateCard({required this.preview, required this.loading});

  final Hip3WithdrawalPreview? preview;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceSubtle,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _PreviewDetailRow(
            label: l10n.estimatedFee,
            value: preview == null
                ? '— USDC'
                : '${TokenAmountFormatter.formatText(preview!.fee)} USDC',
            loading: loading,
            skeletonKey: const Key('perps-withdrawal-preview-fee-skeleton'),
          ),
          const SizedBox(height: 8),
          _PreviewDetailRow(
            label: l10n.recipientReceives,
            value: preview == null
                ? '— USDC'
                : '${TokenAmountFormatter.formatText(preview!.minimumReceived)} USDC',
            loading: loading,
            skeletonKey: const Key('perps-withdrawal-preview-receive-skeleton'),
          ),
        ],
      ),
    );
  }
}

class _PreviewDetailRow extends StatelessWidget {
  const _PreviewDetailRow({
    required this.label,
    required this.value,
    required this.loading,
    required this.skeletonKey,
  });

  final String label;
  final String value;
  final bool loading;
  final Key skeletonKey;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _MutedText(label),
      if (loading)
        SkeletonBlock(key: skeletonKey, width: 56, height: 10, radius: 4)
      else
        Flexible(child: Text(value, textAlign: TextAlign.right)),
    ],
  );
}

class _PerpsAvailableTooltip extends StatelessWidget {
  const _PerpsAvailableTooltip({required this.available, this.allocation});

  final String? available;
  final PortfolioAccountAllocation? allocation;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final breakdown = allocation?.perpsBreakdown;
    return RwaRichTooltip(
      tooltipKey: const Key('perps-withdrawal-available-tooltip'),
      autoFlipVertically: true,
      message: WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: SizedBox(
          width: 216,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _PerpsTooltipAmountRow(
                label: l10n.perpsBalance,
                amount: _tooltipAmount(allocation?.valueUsd),
              ),
              _PerpsTooltipAmountRow(
                label: '– ${l10n.isolatedMargin}',
                amount: _tooltipAmount(breakdown?.isolatedMargin?.valueUsd),
              ),
              _PerpsTooltipAmountRow(
                label: '– ${l10n.crossMargin}',
                amount: _tooltipAmount(breakdown?.crossMargin?.valueUsd),
              ),
              _PerpsTooltipAmountRow(
                label: '– ${l10n.openOrderMargin}',
                amount: _tooltipAmount(breakdown?.openOrderMargin?.valueUsd),
              ),
              Divider(height: 13, color: colors.borderSubtle),
              _PerpsTooltipAmountRow(
                label: '= ${l10n.available}',
                amount: available == null
                    ? '—'
                    : '${TokenAmountFormatter.formatText(available!)} USDC',
                emphasized: true,
              ),
              const SizedBox(height: 2),
              Text(
                l10n.sharedMarginForCross,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 11,
                  height: 15 / 11,
                ),
              ),
            ],
          ),
        ),
      ),
      child: SizedBox.square(
        key: const Key('perps-withdrawal-available-help'),
        dimension: 14,
        child: Icon(Icons.help_outline, size: 14, color: colors.textSecondary),
      ),
    );
  }

  String _tooltipAmount(DecimalValue? value) =>
      value == null ? '—' : '${TokenAmountFormatter.formatValue(value)} USDC';
}

class _PerpsTooltipAmountRow extends StatelessWidget {
  const _PerpsTooltipAmountRow({
    required this.label,
    required this.amount,
    this.emphasized = false,
  });

  final String label;
  final String amount;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final style = TextStyle(
      color: emphasized ? colors.textPrimary : colors.textSecondary,
      fontSize: 12,
      height: 17 / 12,
      fontWeight: emphasized ? FontWeight.w600 : FontWeight.w400,
    );
    return Row(
      children: [
        Expanded(child: Text(label, style: style)),
        const SizedBox(width: 8),
        Text(amount, style: style, textAlign: TextAlign.right),
      ],
    );
  }
}

class _RouteContainer extends StatelessWidget {
  const _RouteContainer({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceBase,
        border: Border.all(color: colors.borderSubtle),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          for (var index = 0; index < children.length; index++) ...[
            SizedBox(height: 51, child: children[index]),
            if (index != children.length - 1) const Divider(),
          ],
        ],
      ),
    );
  }
}

class _RouteRow extends StatelessWidget {
  const _RouteRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final Widget icon;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        Expanded(child: Text(label)),
        SizedBox(width: 24, height: 24, child: icon),
        const SizedBox(width: 8),
        Text(value, style: _strongText),
      ],
    ),
  );
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _MutedText(label),
      Flexible(child: Text(value, textAlign: TextAlign.right)),
    ],
  );
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({
    required this.label,
    required this.value,
    this.valueKey,
    this.muted = false,
  });

  final String label;
  final String value;
  final Key? valueKey;
  final bool muted;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: muted
                ? Theme.of(context).extension<AppRwaColors>()!.textSecondary
                : null,
          ),
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: Text(
          value,
          key: valueKey,
          style: _strongText,
          textAlign: TextAlign.right,
        ),
      ),
    ],
  );
}

class _MutedText extends StatelessWidget {
  const _MutedText(this.value);

  final String value;

  @override
  Widget build(BuildContext context) => Text(
    value,
    style: Theme.of(context).textTheme.bodySmall?.copyWith(
      color: Theme.of(context).extension<AppRwaColors>()!.textSecondary,
    ),
  );
}

bool _isPositiveUsdc(String value) {
  try {
    final amount = DecimalValue(value);
    return amount.scale <= 6 && amount.compareTo(DecimalValue('0')) > 0;
  } on FormatException {
    return false;
  }
}

bool _withinBalance(String amount, String? balance) {
  if (balance == null) return false;
  try {
    return DecimalValue(amount).compareTo(DecimalValue(balance)) <= 0;
  } on FormatException {
    return false;
  }
}

bool _sameAmount(String? left, String right) {
  if (left == null) return false;
  try {
    return DecimalValue(left).compareTo(DecimalValue(right)) == 0;
  } on FormatException {
    return false;
  }
}

String? _disabledReason({
  required AppLocalizations l10n,
  required bool amountIsPositive,
  required bool loading,
  required String? walletAddress,
  required String? balance,
  required bool withinBalance,
  required Hip3WithdrawalPreview? preview,
  required bool previewMatches,
  required bool previewCurrent,
  required bool previewCanProceed,
}) {
  if (!amountIsPositive || loading) return null;
  if (walletAddress == null) return l10n.hip3SigningWalletUnavailable;
  if (balance == null) return l10n.prepareWithdrawalFailed;
  if (!withinBalance) {
    return l10n.transferInsufficientWithdrawableBalance(
      TokenAmountFormatter.formatText(balance),
    );
  }
  if (preview == null || !previewMatches) return l10n.prepareWithdrawalFailed;
  if (!previewCurrent) return l10n.transferQuoteExpired;
  if (!previewCanProceed) return l10n.transferBlocked;
  return null;
}

String _shortAddress(String? value) {
  if (value == null || value.isEmpty) return '—';
  if (value.length <= 18) return value;
  return '${value.substring(0, 10)}...${value.substring(value.length - 4)}';
}

String _chainName(String chainId) => switch (chainId) {
  '1' => 'Ethereum',
  '56' => 'BNB Smart Chain',
  '97' => 'BNB Smart Chain Testnet',
  '8453' => 'Base',
  '42161' => 'Arbitrum',
  '421614' => 'Arbitrum Sepolia',
  _ => chainId,
};

const _strongText = TextStyle(
  fontSize: 15,
  height: 22 / 15,
  fontWeight: FontWeight.w600,
);

const _amountText = TextStyle(
  fontSize: 32,
  height: 38 / 32,
  fontWeight: FontWeight.w700,
);

const _cardTitle = TextStyle(
  fontSize: 17,
  height: 22 / 17,
  fontWeight: FontWeight.w600,
);
