import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/funding_catalog.dart';
import 'package:rwa_interface/domain/models/funding_session.dart';
import 'package:rwa_interface/domain/models/funding_transfer.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/feedback/app_toast.dart';
import 'package:rwa_interface/ui/core/navigation/app_page_header.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/funding/providers/funding_transfer_providers.dart';
import 'package:rwa_interface/ui/features/funding/widgets/transfer_account_pair.dart';

/// Presents the internal Spot/Perps transfer flow.
///
/// Quotes and executes an internal Spot-to-Perps transfer through Riverpod.
class TransferScreen extends ConsumerStatefulWidget {
  const TransferScreen({super.key});

  @override
  ConsumerState<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends ConsumerState<TransferScreen> {
  final _amounts = <String, TextEditingController>{};
  bool _submitting = false;
  bool _quoting = false;
  FundingSessionSummary? _quote;
  Timer? _quoteDebounce;
  Timer? _quoteRefresh;
  Timer? _planRefresh;
  FundingPlan? _activePlan;
  bool _planPolling = false;
  int _quoteSequence = 0;
  String? _error;
  String? _statusMessage;
  bool _transferPending = false;
  bool _completionToastShown = false;

  Map<String, String> get _allocations => {
    for (final entry in _amounts.entries)
      if ((double.tryParse(entry.value.text.trim()) ?? 0) > 0)
        entry.key: entry.value.text.trim(),
  };

  void _scheduleQuote() {
    _quoteDebounce?.cancel();
    _quoteRefresh?.cancel();
    _quoteSequence++;
    final allocations = _allocations;
    if (allocations.isEmpty) {
      setState(() {
        _quote = null;
        _quoting = false;
        _statusMessage = null;
        _transferPending = false;
        _completionToastShown = false;
      });
      return;
    }
    setState(() {
      _quote = null;
      _quoting = true;
      _error = null;
      _statusMessage = null;
      _transferPending = false;
      _completionToastShown = false;
    });
    _quoteDebounce = Timer(const Duration(milliseconds: 500), _requestQuote);
  }

  Future<void> _requestQuote() async {
    final allocations = _allocations;
    if (allocations.isEmpty) return;
    final amount = allocations.values
        .map(double.parse)
        .fold<double>(0, (sum, value) => sum + value);
    final sequence = ++_quoteSequence;
    setState(() {
      _quoting = true;
      _error = null;
    });
    try {
      final quote = await ref
          .read(fundingTransferCommandsProvider)
          .quoteTransfer(
            destination: 'hip3_margin',
            amount: amount.toString(),
            allocations: allocations,
          );
      if (!mounted || sequence != _quoteSequence) return;
      setState(() {
        _quote = quote;
        _applySessionStatus(quote);
      });
      _scheduleQuoteRefresh(quote, sequence);
    } catch (error) {
      if (!mounted || sequence != _quoteSequence) return;
      setState(() {
        _quote = null;
        _error = error is ApiFailure
            ? apiFailureMessage(error, fallback: 'Unable to get a quote.')
            : 'Unable to get a quote.';
      });
    } finally {
      if (mounted && sequence == _quoteSequence) {
        setState(() => _quoting = false);
      }
    }
  }

  void _scheduleQuoteRefresh(FundingSessionSummary quote, int sequence) {
    _quoteRefresh?.cancel();
    if (quote.status == 'funded' ||
        quote.status == 'expired' ||
        quote.status == 'cancelled') {
      return;
    }
    _quoteRefresh = Timer(
      const Duration(seconds: 5),
      () => _refreshQuote(quote.sessionId, sequence),
    );
  }

  Future<void> _refreshQuote(String sessionId, int sequence) async {
    if (!mounted ||
        sequence != _quoteSequence ||
        _allocations.isEmpty ||
        _submitting) {
      return;
    }
    try {
      final quote = await ref
          .read(fundingTransferCommandsProvider)
          .refreshTransferQuote(sessionId);
      if (!mounted || sequence != _quoteSequence) return;
      setState(() {
        _quote = quote;
        _applySessionStatus(quote);
      });
      _scheduleQuoteRefresh(quote, sequence);
    } catch (_) {
      if (!mounted || sequence != _quoteSequence) return;
      // Keep the last usable quote visible and retry the refresh. A transfer
      // still requires the server to accept the session version.
      final current = _quote;
      if (current != null) _scheduleQuoteRefresh(current, sequence);
    }
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final allocations = _allocations;
    if (allocations.isEmpty) {
      setState(() => _error = l10n.transferEnterPositiveAmount);
      return;
    }
    final currentQuote = _quote;
    if (currentQuote == null || _quoting) {
      setState(() => _error = l10n.transferWaitForQuote);
      return;
    }
    if (currentQuote.status == 'funded') {
      setState(() => _applySessionStatus(currentQuote));
      return;
    }
    if (currentQuote.status == 'transferring') {
      setState(() => _applySessionStatus(currentQuote));
      return;
    }
    if (!currentQuote.canConfirmTransfer) {
      setState(() => _error = l10n.transferQuoteNotReady);
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
      _statusMessage = null;
    });
    _quoteRefresh?.cancel();
    final submitSequence = ++_quoteSequence;
    try {
      final commands = ref.read(fundingTransferCommandsProvider);
      final quote = await commands.refreshTransferQuote(currentQuote.sessionId);
      if (!mounted || submitSequence != _quoteSequence) return;
      setState(() {
        _quote = quote;
        _applySessionStatus(quote);
      });
      if (quote.status == 'funded') return;
      if (quote.status == 'transferring') {
        return;
      }
      if (!quote.canConfirmTransfer) {
        throw StateError(l10n.transferQuoteChanged);
      }
      final plan = await commands.planForSession(quote);
      await _advancePlan(plan);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = switch (error) {
          ApiFailure failure => apiFailureMessage(
            failure,
            fallback: l10n.transferStartFailed,
          ),
          StateError stateError => stateError.message.toString(),
          _ => l10n.transferStartFailed,
        };
        _statusMessage = null;
        _transferPending = false;
      });
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
        final latestQuote = _quote;
        if (latestQuote != null && submitSequence == _quoteSequence) {
          _scheduleQuoteRefresh(latestQuote, submitSequence);
        }
      }
    }
  }

  Future<void> _advancePlan(FundingPlan plan) async {
    final commands = ref.read(fundingTransferCommandsProvider);
    var current = plan;
    if (current.status == FundingPlanState.alreadyFunded) {
      _completeTransfer();
      return;
    }
    if (current.isActionable) {
      final authorization = await commands.authorize(current);
      await commands.create(plan: current, authorization: authorization);
      current = await commands.refresh(current.planId);
    }
    if (!mounted) return;
    if (current.status == FundingPlanState.alreadyFunded) {
      _completeTransfer();
      return;
    }
    final pending =
        current.isExecuting ||
        current.isActionable ||
        current.legs.any((leg) => leg.transferId != null);
    setState(() {
      _activePlan = current;
      _transferPending = pending;
      _statusMessage = pending
          ? AppLocalizations.of(context).transferWaitingArrival
          : null;
      if (!pending) _error = _planFailureMessage(current);
    });
    if (pending) _startPlanPolling();
  }

  void _startPlanPolling() {
    if (_planRefresh != null || !_transferPending) return;
    _quoteRefresh?.cancel();
    _planRefresh = Timer.periodic(
      const Duration(seconds: 2),
      (_) => unawaited(_pollPlan()),
    );
    unawaited(_pollPlan());
  }

  Future<void> _pollPlan() async {
    final plan = _activePlan;
    if (!mounted || !_transferPending || _planPolling || plan == null) return;
    _planPolling = true;
    try {
      final refreshed = await ref
          .read(fundingTransferCommandsProvider)
          .reconcile(plan);
      if (!mounted) return;
      if (refreshed.status == FundingPlanState.alreadyFunded) {
        _completeTransfer();
        return;
      }
      final pending =
          refreshed.isExecuting ||
          refreshed.isActionable ||
          refreshed.legs.any((leg) => leg.transferId != null);
      setState(() {
        _activePlan = refreshed;
        _transferPending = pending;
        if (!pending) {
          _statusMessage = null;
          _error = _planFailureMessage(refreshed);
        }
      });
      if (!pending) _stopPlanPolling();
    } on Object catch (error) {
      if (mounted && error is! ApiFailure) {
        setState(() => _error = error.toString());
      }
    } finally {
      _planPolling = false;
    }
  }

  String _planFailureMessage(FundingPlan plan) {
    if (plan.blocker case final blocker? when blocker.isNotEmpty) {
      return blocker;
    }
    final l10n = AppLocalizations.of(context);
    return switch (plan.status) {
      FundingPlanState.manualReview => l10n.transferRequiresManualReview,
      FundingPlanState.failed => l10n.transferFailed,
      FundingPlanState.expired => l10n.transferQuoteExpired,
      FundingPlanState.cancelled => l10n.transferCancelled,
      FundingPlanState.blocked => l10n.transferBlocked,
      _ => l10n.transferStartFailed,
    };
  }

  void _stopPlanPolling() {
    _planRefresh?.cancel();
    _planRefresh = null;
  }

  void _completeTransfer() {
    if (!mounted || _completionToastShown) return;
    _completionToastShown = true;
    _stopPlanPolling();
    ref.invalidate(transferFundingAccountProvider);
    ref.invalidate(transferOptionsProvider);
    AppToast.showSuccess(
      context,
      AppLocalizations.of(context).transferCompleted,
    );
    Navigator.of(context).maybePop();
  }

  void _applySessionStatus(FundingSessionSummary session) {
    switch (session.status) {
      case 'transferring':
        _transferPending = true;
        _statusMessage = AppLocalizations.of(context).transferInProgress;
        _error = null;
      case 'funded':
        _transferPending = false;
        _statusMessage = null;
        _error = null;
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _completeTransfer(),
        );
      default:
        if (!_submitting) {
          _transferPending = false;
          _statusMessage = null;
        }
    }
  }

  @override
  void dispose() {
    _quoteDebounce?.cancel();
    _quoteRefresh?.cancel();
    _planRefresh?.cancel();
    for (final controller in _amounts.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final options = ref.watch(transferOptionsProvider);
    final l10n = AppLocalizations.of(context);
    final send = l10n.spot;
    final receive = l10n.perps;
    final canSubmit =
        !_submitting &&
        !_transferPending &&
        !_quoting &&
        _allocations.isNotEmpty &&
        _quote?.canConfirmTransfer == true &&
        _quote?.status != 'transferring' &&
        _quote?.status != 'funded';

    return PopScope(
      canPop: !_submitting,
      child: Scaffold(
        backgroundColor: colors.canvas,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 38,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppPageHeader(title: l10n.transfer),
                      const SizedBox(height: 16),
                      TransferAccountPair(
                        send: send,
                        receive: receive,
                        onSwap: null,
                      ),
                      const SizedBox(height: 16),
                      _SectionLabel(l10n.sendAmount),
                      options.when(
                        data: (value) {
                          final positions = value.account.positions
                              .where((position) => position.eligible)
                              .toList(growable: false);
                          for (final position in positions) {
                            _amounts.putIfAbsent(position.positionId, () {
                              final controller = TextEditingController();
                              controller.addListener(_scheduleQuote);
                              return controller;
                            });
                          }
                          return _SendAmountCard(
                            positions: positions,
                            controllers: _amounts,
                          );
                        },
                        loading: () => const _TransferSkeleton(height: 216),
                        error: (error, _) => _LoadError(
                          error: error,
                          onRetry: () {
                            ref.invalidate(transferFundingAccountProvider);
                            ref.invalidate(fundingCatalogProvider);
                            ref.invalidate(transferOptionsProvider);
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      _SectionLabel(l10n.receiveAmount),
                      options.when(
                        data: (value) {
                          final target = value.catalog?.transferTarget;
                          final asset = _quote?.targetToken ?? target?.token;
                          final network =
                              _quote?.targetNetwork ?? target?.network;
                          return _ReceiveAmountCard(
                            asset: asset ?? '--',
                            network: network ?? '--',
                            value: _quoting
                                ? '...'
                                : _quote?.minimumReceived ?? '',
                          );
                        },
                        loading: () => const _TransferSkeleton(height: 59),
                        error: (_, _) => const _ReceiveAmountCard(
                          asset: '--',
                          network: '--',
                          value: '',
                        ),
                      ),
                      const SizedBox(height: 16),
                      _FeeSummary(
                        quote: _quote,
                        loading: _quoting || options.isLoading,
                      ),
                      if (_error case final error?) ...[
                        const SizedBox(height: 8),
                        Text(
                          error,
                          style: TextStyle(
                            color: Theme.of(context)
                                .extension<AppSemanticColors>()!
                                .loss,
                          ),
                        ),
                      ],
                      if (_statusMessage case final message?) ...[
                        const SizedBox(height: 8),
                        Text(
                          message,
                          style: TextStyle(
                            color: Theme.of(context)
                                .extension<AppSemanticColors>()!
                                .success,
                          ),
                        ),
                      ],
                      if (_transferPending) ...[
                        const SizedBox(height: 12),
                        OutlinedButton(
                          key: const Key('transfer-close-view-later'),
                          onPressed: () =>
                              context.goNamed(AppRoutes.activityName),
                          child: Text(l10n.closeViewLater),
                        ),
                      ],
                      const Spacer(),
                      const SizedBox(height: 28),
                      SizedBox(
                        height: 48,
                        child: FilledButton(
                          onPressed: canSubmit ? _submit : null,
                          child: _submitting
                              ? const SizedBox.square(
                                  dimension: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  _transferPending
                                      ? l10n.transferInProgress
                                      : l10n.signAndTransfer,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      label,
      style: Theme.of(context).textTheme.bodyMedium
          ?.copyWith(fontWeight: FontWeight.w500),
    ),
  );
}

class _LoadError extends StatelessWidget {
  const _LoadError({required this.error, required this.onRetry});
  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 96,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            error is ApiFailure
                ? apiFailureMessage(
                    error as ApiFailure,
                    fallback: AppLocalizations.of(context)
                        .transferOptionsLoadFailed,
                  )
                : AppLocalizations.of(context).transferOptionsLoadFailed,
          ),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: Text(AppLocalizations.of(context).retry),
          ),
        ],
      ),
    ),
  );
}

class _TransferSkeleton extends StatelessWidget {
  const _TransferSkeleton({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final compact = height < 80;
    return Semantics(
      label: AppLocalizations.of(context).loadingTransferDetails,
      child: Shimmer.fromColors(
        baseColor: colors.subtleSurface,
        highlightColor: colors.surface,
        child: Container(
          key: const Key('transfer-loading-skeleton'),
          height: height,
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: compact ? 10 : 16,
          ),
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border.all(color: colors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (
                var index = 0;
                index < math.max(1, (height / 58).floor());
                index++
              )
                Row(
                  children: [
                    _SkeletonBlock(
                      width: compact ? 24 : 28,
                      height: compact ? 24 : 28,
                      circular: true,
                    ),
                    const SizedBox(width: 8),
                    const Expanded(child: _SkeletonBlock(height: 14)),
                    const SizedBox(width: 24),
                    _SkeletonBlock(
                      width: height > 80 ? 88 : 56,
                      height: height > 80 ? 32 : 14,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkeletonBlock extends StatelessWidget {
  const _SkeletonBlock({
    this.width,
    required this.height,
    this.circular = false,
  });

  final double? width;
  final double height;
  final bool circular;

  @override
  Widget build(BuildContext context) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(circular ? height / 2 : 6),
    ),
  );
}

class _SendAmountCard extends StatefulWidget {
  const _SendAmountCard({required this.positions, required this.controllers});

  final List<FundingSourcePosition> positions;
  final Map<String, TextEditingController> controllers;

  @override
  State<_SendAmountCard> createState() => _SendAmountCardState();

  static String _assetPath(String token) => switch (token.toUpperCase()) {
    'USDT' => 'assets/figma/funding/usdt.png',
    'ETH' => 'assets/figma/funding/eth.svg',
    _ => 'assets/figma/funding/usdc.svg',
  };
}

class _SendAmountCardState extends State<_SendAmountCard> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: widget.positions.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Text(AppLocalizations.of(context).noEligibleFundingAssets),
            )
          : SizedBox(
              key: const Key('send-token-list'),
              height: math.min(72 + (widget.positions.length - 1) * 69, 279),
              child: RawScrollbar(
                controller: _scrollController,
                thumbVisibility: widget.positions.length > 4,
                radius: const Radius.circular(3),
                thickness: 4,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.zero,
                  itemCount: widget.positions.length,
                  itemBuilder: (context, index) {
                    final position = widget.positions[index];
                    return _AssetAmountRow(
                      asset: position.token,
                      network: position.network,
                      available: position.availableAmount.value,
                      assetPath: _SendAmountCard._assetPath(position.token),
                      controller: widget.controllers[position.positionId]!,
                      topPadding: index == 0 ? 16 : 12,
                    );
                  },
                ),
              ),
            ),
    );
  }
}

class _AssetAmountRow extends StatelessWidget {
  const _AssetAmountRow({
    required this.asset,
    required this.network,
    required this.available,
    required this.assetPath,
    required this.controller,
    this.topPadding = 12,
  });

  final String asset;
  final String network;
  final String available;
  final String assetPath;
  final TextEditingController controller;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return SizedBox(
      height: topPadding == 16 ? 72 : 69,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          topPadding,
          16,
          topPadding == 16 ? 20 : 21,
        ),
        child: Row(
          children: [
            assetPath.endsWith('.svg')
                ? SvgPicture.asset(assetPath, width: 28, height: 28)
                : Image.asset(assetPath, width: 28, height: 28),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        asset,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 18 / 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '($network)',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            height: 14 / 11,
                            color: colors.secondaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppLocalizations.of(context).availableAmount(available),
                    style: TextStyle(
                      fontSize: 11,
                      height: 14 / 11,
                      color: colors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 88,
              height: 32,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.subtleSurface,
                  border: Border.all(color: colors.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.right,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  style: TextStyle(
                    fontSize: 15,
                    height: 22 / 15,
                    fontWeight: FontWeight.w600,
                    color: colors.primaryText,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      left: 12,
                      right: 16,
                      top: 5,
                      bottom: 5,
                    ),
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

class _ReceiveAmountCard extends StatelessWidget {
  const _ReceiveAmountCard({
    required this.asset,
    required this.network,
    required this.value,
  });

  final String asset;
  final String network;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      height: 59,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (_SendAmountCard._assetPath(asset).endsWith('.svg'))
            SvgPicture.asset(
              _SendAmountCard._assetPath(asset),
              width: 28,
              height: 28,
            )
          else
            Image.asset(
              _SendAmountCard._assetPath(asset),
              width: 28,
              height: 28,
            ),
          const SizedBox(width: 4),
          Text(
            asset,
            style: TextStyle(
              fontSize: 13,
              height: 18 / 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              '($network)',
              style: TextStyle(
                fontSize: 11,
                height: 14 / 11,
                color: colors.secondaryText,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              height: 22 / 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeeSummary extends StatelessWidget {
  const _FeeSummary({required this.quote, required this.loading});

  final FundingSessionSummary? quote;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    if (loading) return const _TransferSkeleton(height: 116);
    final fees = quote?.fees;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.subtleSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _FeeRow(
            AppLocalizations.of(context).estimateTime,
            _formatEta(quote?.etaSeconds),
          ),
          const SizedBox(height: 8),
          _FeeRow(
            AppLocalizations.of(context).bridgeFee,
            _formatFee(fees?.bridgeFee, fees?.asset),
          ),
          const SizedBox(height: 8),
          _FeeRow(
            AppLocalizations.of(context).networkFee,
            _formatFee(fees?.networkFee, fees?.asset),
          ),
          const SizedBox(height: 8),
          _FeeRow(
            AppLocalizations.of(context).totalFee,
            _formatFee(fees?.totalFee, fees?.asset),
          ),
        ],
      ),
    );
  }

  static String _formatEta(int? seconds) {
    if (seconds == null) return '--';
    if (seconds < 60) return '${seconds}s';
    final minutes = (seconds / 60).ceil();
    return '~${minutes}min';
  }

  static String _formatFee(String? amount, String? asset) {
    if (amount == null || asset == null) return '--';
    return '$amount $asset';
  }
}

class _FeeRow extends StatelessWidget {
  const _FeeRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            height: 18 / 13,
            fontWeight: FontWeight.w500,
            color: colors.secondaryText,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            height: 18 / 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
