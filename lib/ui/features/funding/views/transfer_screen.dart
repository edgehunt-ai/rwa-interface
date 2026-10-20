import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/funding_catalog.dart';
import 'package:nobell/domain/models/funding_session.dart';
import 'package:nobell/domain/models/funding_transfer.dart';
import 'package:nobell/domain/models/hip3_withdrawal.dart';
import 'package:nobell/domain/models/hip3_withdrawal_preview.dart';
import 'package:nobell/domain/services/hip3_typed_data_signer.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/feedback/app_toast.dart';
import 'package:nobell/ui/core/feedback/inline_error_notice.dart';
import 'package:nobell/ui/core/feedback/loading_skeleton.dart';
import 'package:nobell/ui/core/formatters/token_amount_formatter.dart';
import 'package:nobell/ui/core/motion/animated_number_text.dart';
import 'package:nobell/ui/core/navigation/app_page_header.dart';
import 'package:nobell/ui/core/network/network_icon_assets.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/core/widgets/app_filter_menu.dart';
import 'package:nobell/ui/features/activity/providers/activity_provider.dart';
import 'package:nobell/ui/features/funding/providers/funding_transfer_providers.dart';
import 'package:nobell/ui/features/funding/providers/hip3_withdrawal_providers.dart';
import 'package:nobell/ui/features/funding/hip3_withdrawal_blocker_message.dart';
import 'package:nobell/ui/features/funding/widgets/transfer_account_pair.dart';
import 'package:nobell/ui/features/orders/views/hip3_cross_liquidation_impacts_card.dart';

import '../../../core/feedback/error_message.dart';

/// Presents the internal Spot/Perps transfer flow.
///
/// Quotes and executes an internal Spot-to-Perps transfer through Riverpod.
class TransferScreen extends ConsumerStatefulWidget {
  const TransferScreen({super.key, this.initialToken, this.initialNetwork});

  final String? initialToken;
  final String? initialNetwork;

  @override
  ConsumerState<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends ConsumerState<TransferScreen> {
  final _amounts = <String, TextEditingController>{};
  final _withdrawalAmount = TextEditingController();
  bool _submitting = false;
  bool _quoting = false;
  FundingSessionSummary? _quote;
  Timer? _quoteDebounce;
  Timer? _quoteRefresh;
  Timer? _planRefresh;
  Timer? _withdrawalRefresh;
  Timer? _withdrawalPreviewDebounce;
  Timer? _withdrawalPreviewRefresh;
  bool _withdrawalPreviewing = false;
  Hip3WithdrawalPreview? _withdrawalPreview;
  int _withdrawalPreviewSequence = 0;
  bool _withdrawalPolling = false;
  Hip3Withdrawal? _withdrawal;
  FundingPlan? _activePlan;
  String? _activePlanSessionId;
  bool _planPolling = false;
  int _planGeneration = 0;
  int _quoteSequence = 0;
  String? _error;
  String? _withdrawalSubmissionError;
  bool _transferPending = false;
  bool _resumeRequired = false;
  bool _planActionRequired = false;
  bool _completionToastShown = false;
  bool _sendFromSpot = true;
  bool _selectingToken = false;
  String? _selectedPositionId;
  Map<String, FundingSourcePosition> _positions = const {};
  UnifiedFundingAccountSummary? _account;
  String _tokenQuery = '';
  String? _tokenNetworkFilter;

  Map<String, String> get _allocations {
    final options = ref.read(transferOptionsProvider);
    if (options.isLoading || options.hasError) return const {};
    final account = options.value?.account;
    final position = identical(account, _account)
        ? _positions[_selectedPositionId]
        : account?.positions
              .where((position) => position.positionId == _selectedPositionId)
              .firstOrNull;
    final amount = _amounts[_selectedPositionId]?.text.trim();
    if (position == null || amount == null || !position.canAllocate(amount)) {
      return const {};
    }
    return {position.positionId: amount};
  }

  void _preparePositions(List<FundingSourcePosition> positions) {
    _positions = {
      for (final position in positions)
        if (position.eligible) position.positionId: position,
    };
    if (_selectedPositionId == null &&
        widget.initialToken != null &&
        widget.initialNetwork != null) {
      final requestedToken = widget.initialToken!.trim().toUpperCase();
      final requestedNetwork = widget.initialNetwork!.trim().toLowerCase();
      _selectedPositionId = _positions.values
          .where(
            (position) =>
                position.token.trim().toUpperCase() == requestedToken &&
                position.network.trim().toLowerCase() == requestedNetwork,
          )
          .firstOrNull
          ?.positionId;
    }
    if (!_positions.containsKey(_selectedPositionId) &&
        !_submitting &&
        !_transferPending) {
      if (_selectedPositionId != null) {
        _quoteDebounce?.cancel();
        _quoteRefresh?.cancel();
        _quoteSequence++;
        _quote = null;
        _quoting = false;
      }
      _selectedPositionId = _positions.values.firstOrNull?.positionId;
    }
    for (final position in _positions.values) {
      _amounts.putIfAbsent(position.positionId, () {
        final controller = TextEditingController();
        controller.addListener(_scheduleQuote);
        return controller;
      });
    }
  }

  void _openTokenSelector() {
    if (_positions.length <= 1 || _submitting || _transferPending) return;
    setState(() => _selectingToken = true);
  }

  void _closeTokenSelector() {
    setState(() {
      _selectingToken = false;
      _tokenQuery = '';
      _tokenNetworkFilter = null;
    });
  }

  void _selectToken(FundingSourcePosition position) {
    if (_submitting || _transferPending) return;
    _quoteDebounce?.cancel();
    _quoteRefresh?.cancel();
    _quoteSequence++;
    _planGeneration++;
    setState(() {
      _selectedPositionId = position.positionId;
      _selectingToken = false;
      _tokenQuery = '';
      _tokenNetworkFilter = null;
      _quote = null;
      _activePlan = null;
      _activePlanSessionId = null;
      _quoting = false;
      _error = null;
      _transferPending = false;
      _resumeRequired = false;
      _planActionRequired = false;
      _completionToastShown = false;
    });
    _scheduleQuote();
  }

  void _scheduleQuote() {
    if (_submitting || _transferPending) return;
    _quoteDebounce?.cancel();
    _quoteRefresh?.cancel();
    _quoteSequence++;
    _planGeneration++;
    if (!_sendFromSpot) return;
    final allocations = _allocations;
    if (allocations.isEmpty) {
      setState(() {
        _quote = null;
        _activePlan = null;
        _activePlanSessionId = null;
        _quoting = false;
        _transferPending = false;
        _resumeRequired = false;
        _planActionRequired = false;
        _completionToastShown = false;
      });
      return;
    }
    setState(() {
      _quote = null;
      _activePlan = null;
      _activePlanSessionId = null;
      _quoting = true;
      _error = null;
      _transferPending = false;
      _resumeRequired = false;
      _planActionRequired = false;
      _completionToastShown = false;
    });
    _quoteDebounce = Timer(const Duration(milliseconds: 500), _requestQuote);
  }

  void _swapAccounts() {
    if (_submitting || _transferPending) return;
    _quoteDebounce?.cancel();
    _quoteRefresh?.cancel();
    _quoteSequence++;
    _planGeneration++;
    _withdrawalPreviewDebounce?.cancel();
    _withdrawalPreviewRefresh?.cancel();
    _withdrawalPreviewSequence++;
    setState(() {
      _sendFromSpot = !_sendFromSpot;
      _quote = null;
      _activePlan = null;
      _activePlanSessionId = null;
      _quoting = false;
      _error = null;
      _withdrawal = null;
      _withdrawalPreview = null;
      _withdrawalPreviewing = false;
    });
    if (_sendFromSpot) {
      _scheduleQuote();
    } else {
      _scheduleHip3Preview();
    }
  }

  bool _sameWithdrawalAmount(String? left, String right) {
    if (left == null) return false;
    try {
      return DecimalValue(left).compareTo(DecimalValue(right)) == 0;
    } on FormatException {
      return false;
    }
  }

  void _scheduleHip3Preview() {
    if (_sendFromSpot || _submitting || _transferPending) return;
    _withdrawalPreviewDebounce?.cancel();
    _withdrawalPreviewRefresh?.cancel();
    final sequence = ++_withdrawalPreviewSequence;
    final amount = _withdrawalAmount.text.trim();
    setState(() {
      _error = null;
      _withdrawal = null;
      _withdrawalPreview = null;
      _withdrawalPreviewing = false;
    });
    if (amount.isEmpty) return;
    try {
      final parsed = DecimalValue(amount);
      if (parsed.scale > 6 || parsed.compareTo(DecimalValue('0')) <= 0) {
        return;
      }
    } on FormatException {
      return;
    }
    setState(() => _withdrawalPreviewing = true);
    _withdrawalPreviewDebounce = Timer(
      const Duration(milliseconds: 500),
      () => _requestHip3Preview(sequence, amount),
    );
  }

  Future<void> _requestHip3Preview(
    int sequence,
    String amount, {
    bool forceRefresh = false,
  }) async {
    if (_submitting || _transferPending) return;
    try {
      final preview = await ref
          .read(hip3WithdrawalCommandsProvider)
          .preview(amount, forceRefresh: forceRefresh);
      if (!mounted || sequence != _withdrawalPreviewSequence) return;
      setState(() {
        _withdrawalPreview = preview;
        _withdrawalPreviewing = false;
        _error = hip3WithdrawalBlockerMessage(
          preview,
          AppLocalizations.of(context),
        );
      });
      _scheduleHip3PreviewRefresh(preview, sequence, amount);
    } catch (error) {
      if (!mounted || sequence != _withdrawalPreviewSequence) return;
      setState(() {
        _withdrawalPreviewing = false;
        _error = errorMessage(
          error,
          fallback: AppLocalizations.of(context).transferFailed,
        );
      });
      final current = _withdrawalPreview;
      if (current != null && _sameWithdrawalAmount(current.amount, amount)) {
        _scheduleHip3PreviewRefresh(current, sequence, amount);
      }
    }
  }

  void _scheduleHip3PreviewRefresh(
    Hip3WithdrawalPreview preview,
    int sequence,
    String amount,
  ) {
    _withdrawalPreviewRefresh?.cancel();
    final validUntil = preview.riskValidUntil;
    if (validUntil == null) return;
    final remaining = validUntil.difference(DateTime.now().toUtc());
    final delay = remaining > Duration.zero
        ? remaining
        : const Duration(seconds: 1);
    _withdrawalPreviewRefresh = Timer(delay, () {
      if (!mounted ||
          sequence != _withdrawalPreviewSequence ||
          _sendFromSpot ||
          _submitting ||
          _transferPending ||
          _withdrawalAmount.text.trim() != amount) {
        return;
      }
      setState(() => _withdrawalPreviewing = true);
      unawaited(_requestHip3Preview(sequence, amount, forceRefresh: true));
    });
  }

  Future<void> _requestQuote() async {
    if (!_sendFromSpot || _submitting || _transferPending) return;
    final allocations = _allocations;
    if (allocations.isEmpty) return;
    final amount = allocations.values.single;
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
            amount: amount,
            allocations: allocations,
          );
      if (!mounted || sequence != _quoteSequence) return;
      setState(() => _applyQuote(quote));
      if (_quote != null) _scheduleQuoteRefresh(quote, sequence);
    } catch (error) {
      if (!mounted || sequence != _quoteSequence) return;
      setState(() {
        _quote = null;
        _error = errorMessage(error, fallback: 'Unable to get a quote.');
      });
    } finally {
      if (mounted && sequence == _quoteSequence) {
        setState(() => _quoting = false);
      }
    }
  }

  void _applyQuote(FundingSessionSummary quote) {
    _quote = quote;
    if (quote.status != 'transferring' && quote.status != 'funded') {
      _preparePositions(quote.positions);
      if (_allocations.isEmpty) {
        _quote = null;
        _quoting = false;
        _error = AppLocalizations.of(context).transferQuoteChanged;
      }
    }
    _applySessionStatus(quote);
  }

  void _scheduleQuoteRefresh(FundingSessionSummary quote, int sequence) {
    _quoteRefresh?.cancel();
    if (_activePlan != null ||
        _planRefresh != null ||
        quote.status == 'funded' ||
        quote.status == 'manualReview' ||
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
        _activePlan != null ||
        _planRefresh != null ||
        (!_transferPending && _allocations.isEmpty) ||
        _submitting) {
      return;
    }
    try {
      final quote = await ref
          .read(fundingTransferCommandsProvider)
          .refreshTransferQuote(sessionId);
      if (!mounted || sequence != _quoteSequence) return;
      setState(() {
        _error = null;
        _applyQuote(quote);
      });
      if (_quote != null) _scheduleQuoteRefresh(quote, sequence);
    } catch (error) {
      if (!mounted || sequence != _quoteSequence) return;
      final current = _quote;
      if (!_transferPending) {
        setState(() {
          _error = errorMessage(
            error,
            fallback: AppLocalizations.of(context).transferQuoteChanged,
          );
        });
      }
      if (current != null) _scheduleQuoteRefresh(current, sequence);
    }
  }

  Future<void> _submit() async {
    if (!_sendFromSpot) {
      await _submitHip3Withdrawal();
      return;
    }
    if (_submitting) return;
    if (_planActionRequired) {
      await _continueActivePlan();
      return;
    }
    if (_transferPending) return;
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
    if (!_resumeRequired &&
        (!currentQuote.canConfirmTransfer ||
            !_sessionIsEditable(currentQuote.status))) {
      setState(() => _error = l10n.transferQuoteNotReady);
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
    });
    _quoteRefresh?.cancel();
    final submitSequence = ++_quoteSequence;
    try {
      final commands = ref.read(fundingTransferCommandsProvider);
      final quote = await commands.refreshTransferQuote(currentQuote.sessionId);
      if (!mounted || submitSequence != _quoteSequence) return;
      setState(() => _applyQuote(quote));
      if (quote.status == 'funded') return;
      if (quote.status == 'manualReview' ||
          quote.status == 'expired' ||
          quote.status == 'cancelled') {
        return;
      }
      if (_allocations.isEmpty ||
          (quote.status != 'transferring' &&
              (!quote.canConfirmTransfer ||
                  !_sessionIsEditable(quote.status)))) {
        throw StateError(l10n.transferQuoteChanged);
      }
      final plan = await commands.planForSession(quote);
      await _advancePlan(plan, sessionId: quote.sessionId);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = switch (error) {
          ApiFailure failure => apiFailureMessage(
            failure,
            fallback: l10n.transferStartFailed,
          ),
          StateError stateError => stateError.message.toString(),
          _ => errorMessage(error, fallback: l10n.transferStartFailed),
        };
        _transferPending = false;
        _resumeRequired = false;
        _planActionRequired = false;
      });
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
        final latestQuote = _quote;
        if (latestQuote != null &&
            submitSequence == _quoteSequence &&
            _activePlan == null) {
          _scheduleQuoteRefresh(latestQuote, submitSequence);
        }
      }
    }
  }

  Future<void> _submitHip3Withdrawal() async {
    if (_submitting || _transferPending) return;
    setState(() => _withdrawalSubmissionError = null);
    final l10n = AppLocalizations.of(context);
    final amount = _withdrawalAmount.text.trim();
    try {
      final parsed = DecimalValue(amount);
      if (parsed.scale > 6 || parsed.compareTo(DecimalValue('0')) <= 0) {
        throw const FormatException('Invalid USDC amount');
      }
    } on FormatException {
      setState(() => _error = l10n.transferEnterPositiveAmount);
      return;
    }
    _withdrawalPreviewDebounce?.cancel();
    _withdrawalPreviewRefresh?.cancel();
    ++_withdrawalPreviewSequence;
    setState(() {
      _submitting = true;
      _withdrawalPreviewing = false;
      _error = null;
    });
    try {
      final commands = ref.read(hip3WithdrawalCommandsProvider);
      var preview = _withdrawalPreview;
      if (preview == null ||
          !_sameWithdrawalAmount(preview.amount, amount) ||
          !preview.canProceed) {
        throw StateError(AppLocalizations.of(context).transferWaitForQuote);
      }
      if (preview.isRiskExpired) {
        final sequence = _withdrawalPreviewSequence;
        final refreshed = await commands.preview(amount, forceRefresh: true);
        if (!mounted || sequence != _withdrawalPreviewSequence) return;
        setState(() {
          _withdrawalPreview = refreshed;
          _error = hip3WithdrawalBlockerMessage(refreshed, l10n);
        });
        if (!refreshed.canProceed || refreshed.isRiskExpired) {
          throw StateError(_error ?? l10n.transferWaitForQuote);
        }
        if (preview.rail != refreshed.rail ||
            preview.chainId != refreshed.chainId ||
            preview.destinationAddress.toLowerCase() !=
                refreshed.destinationAddress.toLowerCase() ||
            (preview.rail != 'relay' &&
                (!_sameWithdrawalAmount(preview.fee, refreshed.fee) ||
                    !_sameWithdrawalAmount(
                      preview.minimumReceived,
                      refreshed.minimumReceived,
                    )))) {
          throw StateError(l10n.transferQuoteChanged);
        }
        preview = refreshed;
      }
      final prepared = await commands.prepare(
        amount,
        rail: preview.rail,
        payoutChainId: int.parse(preview.chainId),
      );
      if (!mounted) return;
      if (prepared.status != 'awaiting_signature') {
        _handleWithdrawalStatus(prepared);
        return;
      }
      setState(() => _withdrawal = prepared);
      try {
        final submitted = await commands.submit(prepared);
        if (!mounted) return;
        _handleWithdrawalStatus(submitted);
      } catch (_) {
        // A lost submission response may still mean the venue accepted it.
        try {
          final latest = await commands.refresh(prepared.id);
          if (!mounted) return;
          if (latest.status != 'awaiting_signature') {
            _handleWithdrawalStatus(latest);
            return;
          }
        } catch (_) {
          // Preserve the frozen intent for a later retry.
        }
        rethrow;
      }
    } on Hip3WithdrawalQuoteChanged {
      // Refresh while this attempt still owns the loading state. Never sign
      // different transfer terms without another explicit user submission.
      try {
        final refreshed = await ref
            .read(hip3WithdrawalCommandsProvider)
            .preview(amount, forceRefresh: true);
        if (!mounted) return;
        setState(() {
          _withdrawalPreview = refreshed;
          _withdrawalSubmissionError =
              hip3WithdrawalBlockerMessage(refreshed, l10n) ??
              l10n.transferQuoteChanged;
        });
      } catch (error) {
        if (!mounted) return;
        setState(() {
          _withdrawalSubmissionError = errorMessage(
            error,
            fallback: l10n.transferQuoteChanged,
          );
        });
      }
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _withdrawalSubmissionError = switch (error) {
          ApiFailure failure => apiFailureMessage(
            failure,
            fallback: l10n.transferStartFailed,
          ),
          Hip3SigningFailure failure =>
            failure.reason ??
                switch (failure.code) {
                  Hip3SigningFailureCode.actionExpired =>
                    l10n.hip3SigningRequestExpired,
                  Hip3SigningFailureCode.walletUnavailable =>
                    l10n.hip3SigningWalletUnavailable,
                  Hip3SigningFailureCode.walletMismatch =>
                    l10n.walletConnectRequired,
                  Hip3SigningFailureCode.invalidPayload =>
                    l10n.hip3SigningRequestInvalid,
                  Hip3SigningFailureCode.rejected => l10n.signatureCancelled,
                  Hip3SigningFailureCode.actionNotReady =>
                    l10n.transferStartFailed,
                },
          StateError failure => failure.message.toString(),
          _ => errorMessage(error, fallback: l10n.transferStartFailed),
        };
      });
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
        if (!_transferPending && !_completionToastShown) {
          if (_withdrawalPreview case final preview?) {
            _scheduleHip3PreviewRefresh(
              preview,
              _withdrawalPreviewSequence,
              amount,
            );
          }
        }
      }
    }
  }

  void _handleWithdrawalStatus(Hip3Withdrawal withdrawal) {
    if (!mounted) return;
    if (withdrawal.status == 'completed') {
      _completeTransfer();
      return;
    }
    setState(() {
      _withdrawal = withdrawal;
      _transferPending = withdrawal.isPending;
      _withdrawalSubmissionError = withdrawal.requiresManualReview
          ? AppLocalizations.of(context).hip3PendingReview
          : withdrawal.status == 'failed' || withdrawal.status == 'expired'
          ? errorMessage(
              withdrawal.failureReason ?? '',
              fallback: AppLocalizations.of(context).transferFailed,
            )
          : null;
    });
    if (withdrawal.isPending && _withdrawalRefresh == null) {
      _withdrawalRefresh = Timer.periodic(
        const Duration(seconds: 3),
        (_) => unawaited(_pollWithdrawal()),
      );
    } else if (!withdrawal.isPending) {
      _withdrawalRefresh?.cancel();
      _withdrawalRefresh = null;
    }
  }

  Future<void> _pollWithdrawal() async {
    final id = _withdrawal?.id;
    if (!mounted || id == null || _withdrawalPolling) return;
    _withdrawalPolling = true;
    try {
      final current = await ref
          .read(hip3WithdrawalCommandsProvider)
          .refresh(id);
      _handleWithdrawalStatus(current);
    } on Object {
      // Keep polling authoritative status after transient connectivity errors.
    } finally {
      _withdrawalPolling = false;
    }
  }

  Future<void> _advancePlan(FundingPlan plan, {String? sessionId}) async {
    final generation = ++_planGeneration;
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
    if (!mounted || generation != _planGeneration) return;
    if (current.status == FundingPlanState.alreadyFunded) {
      _completeTransfer();
      return;
    }
    final pending = _isPlanPending(current);
    setState(() {
      _activePlan = pending ? current : null;
      _activePlanSessionId = pending ? sessionId ?? _activePlanSessionId : null;
      _transferPending = pending;
      _resumeRequired = false;
      _planActionRequired = false;
      if (!pending) _error = _planFailureMessage(current);
    });
    if (pending) {
      _startPlanPolling();
    } else {
      _stopPlanPolling();
      commands.forgetTransferDraft(_quote?.sessionId ?? '');
    }
  }

  Future<void> _continueActivePlan() async {
    final plan = _activePlan;
    if (_submitting || !_planActionRequired || plan == null) return;
    final generation = ++_planGeneration;
    setState(() {
      _submitting = true;
      _planActionRequired = false;
      _error = null;
    });
    try {
      final refreshed = await ref
          .read(fundingTransferCommandsProvider)
          .reconcile(plan);
      if (!mounted || generation != _planGeneration) return;
      await _advancePlan(refreshed);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _planActionRequired = true;
        _error = errorMessage(
          error,
          fallback: AppLocalizations.of(context).transferStartFailed,
        );
      });
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  bool _isPlanPending(FundingPlan plan) => switch (plan.status) {
    FundingPlanState.executing || FundingPlanState.partiallyFunded => true,
    FundingPlanState.ready => plan.isActionable,
    _ => false,
  };

  bool _sessionIsEditable(String status) =>
      status == 'editing' ||
      status == 'readyToConfirm' ||
      status == 'ready_to_confirm';

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
    if (!mounted ||
        !_transferPending ||
        _submitting ||
        _planPolling ||
        plan == null) {
      return;
    }
    final generation = _planGeneration;
    _planPolling = true;
    try {
      final progress = await ref
          .read(fundingTransferCommandsProvider)
          .inspect(plan);
      if (!mounted || generation != _planGeneration) return;
      final refreshed = progress.plan;
      if (refreshed.status == FundingPlanState.alreadyFunded) {
        _completeTransfer();
        return;
      }
      final pending = _isPlanPending(refreshed);
      setState(() {
        _activePlan = pending ? refreshed : null;
        _transferPending = pending;
        _planActionRequired = pending && progress.requiresUserAction;
        if (!pending) {
          _resumeRequired = false;
          _error = _planFailureMessage(refreshed);
        }
      });
      if (!pending) {
        _planGeneration++;
        _activePlanSessionId = null;
        ref
            .read(fundingTransferCommandsProvider)
            .forgetTransferDraft(_quote?.sessionId ?? '');
        _stopPlanPolling();
      }
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
    _withdrawalRefresh?.cancel();
    ref
        .read(fundingTransferCommandsProvider)
        .forgetTransferDraft(_quote?.sessionId ?? '');
    ref.invalidate(hip3TransferBalanceProvider);
    ref.invalidate(transferFundingAccountProvider);
    ref.invalidate(transferOptionsProvider);
    ref.invalidate(activityProvider);
    AppToast.showSuccess(
      context,
      AppLocalizations.of(context).transferCompleted,
    );
    Navigator.of(context).maybePop();
  }

  void _applySessionStatus(FundingSessionSummary session) {
    switch (session.status) {
      case 'transferring':
        final planKnown =
            _activePlan != null && _activePlanSessionId == session.sessionId;
        _transferPending = planKnown;
        _resumeRequired = !planKnown;
        if (!planKnown) {
          _planActionRequired = false;
          _error = null;
        }
      case 'funded':
        _transferPending = false;
        _resumeRequired = false;
        _planActionRequired = false;
        _error = null;
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _completeTransfer(),
        );
      case 'manualReview':
        _transferPending = false;
        _resumeRequired = false;
        _planActionRequired = false;
        _error = AppLocalizations.of(context).transferRequiresManualReview;
        ref
            .read(fundingTransferCommandsProvider)
            .forgetTransferDraft(session.sessionId);
      case 'expired':
        _transferPending = false;
        _resumeRequired = false;
        _planActionRequired = false;
        _error = AppLocalizations.of(context).transferQuoteExpired;
      case 'cancelled':
        _transferPending = false;
        _resumeRequired = false;
        _planActionRequired = false;
        _error = AppLocalizations.of(context).transferCancelled;
      default:
        if (!_submitting) {
          _transferPending = false;
          _resumeRequired = false;
          _planActionRequired = false;
        }
    }
  }

  @override
  void dispose() {
    _quoteDebounce?.cancel();
    _quoteRefresh?.cancel();
    _planRefresh?.cancel();
    _withdrawalRefresh?.cancel();
    _withdrawalPreviewDebounce?.cancel();
    _withdrawalPreviewRefresh?.cancel();
    _withdrawalAmount.dispose();
    for (final controller in _amounts.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final options = ref.watch(transferOptionsProvider);
    final account = options.value?.account;
    if (account != null &&
        !identical(account, _account) &&
        !_submitting &&
        !_transferPending) {
      _account = account;
      _preparePositions(account.positions);
    }
    if (_sendFromSpot &&
        !_submitting &&
        !_transferPending &&
        (_quote != null || _quoting) &&
        _allocations.isEmpty) {
      _quoteDebounce?.cancel();
      _quoteRefresh?.cancel();
      _quoteSequence++;
      _quote = null;
      _quoting = false;
    }
    final positions = _positions.values.toList(growable: false);
    final hip3Balance = _sendFromSpot
        ? null
        : ref.watch(hip3TransferBalanceProvider);
    final l10n = AppLocalizations.of(context);
    final send = _sendFromSpot ? l10n.spot : l10n.perps;
    final visibleError = _sendFromSpot
        ? _error
        : _withdrawalSubmissionError ?? _error;
    final receive = _sendFromSpot ? l10n.perps : l10n.spot;
    final quote = _quote;
    final canSubmit =
        !_submitting &&
        (_sendFromSpot
            ? (_planActionRequired &&
                      _transferPending &&
                      _activePlan != null) ||
                  _resumeRequired ||
                  (!_transferPending &&
                      !_quoting &&
                      _allocations.isNotEmpty &&
                      quote?.canConfirmTransfer == true &&
                      quote != null &&
                      _sessionIsEditable(quote.status))
            : !_transferPending &&
                  _withdrawalAmount.text.trim().isNotEmpty &&
                  !_withdrawalPreviewing &&
                  _withdrawalPreview?.canProceed == true &&
                  _withdrawalPreview?.isRiskExpired == false &&
                  _sameWithdrawalAmount(
                    _withdrawalPreview?.amount,
                    _withdrawalAmount.text.trim(),
                  ));

    if (_selectingToken) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) _closeTokenSelector();
        },
        child: Scaffold(
          backgroundColor: colors.canvas,
          body: SafeArea(
            child: options.when(
              data: (value) {
                return _TokenSelector(
                  positions: positions,
                  query: _tokenQuery,
                  networkFilter: _tokenNetworkFilter,
                  onBack: _closeTokenSelector,
                  onQueryChanged: (value) =>
                      setState(() => _tokenQuery = value),
                  onNetworkChanged: (value) =>
                      setState(() => _tokenNetworkFilter = value),
                  onSelected: _selectToken,
                );
              },
              loading: () => const Center(
                child: SizedBox(
                  width: 353,
                  child: _TransferSkeleton(height: 64),
                ),
              ),
              error: (error, _) => Center(
                child: _LoadError(
                  error: error,
                  onRetry: () => ref.invalidate(transferOptionsProvider),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return PopScope(
      canPop: !_submitting,
      child: Scaffold(
        backgroundColor: colors.canvas,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                sliver: SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppPageHeader(title: l10n.transfer),
                      const SizedBox(height: 16),
                      TransferAccountPair(
                        send: send,
                        receive: receive,
                        sendIsSpot: _sendFromSpot,
                        onSwap: _submitting || _transferPending
                            ? null
                            : _swapAccounts,
                      ),
                      if (_sendFromSpot) ...[
                        const SizedBox(height: 16),
                        _SectionLabel(l10n.sendAmount),
                        options.when(
                          data: (value) {
                            final selected = positions
                                .where(
                                  (position) =>
                                      position.positionId ==
                                      _selectedPositionId,
                                )
                                .firstOrNull;
                            return _SendAmountCard(
                              position: selected,
                              controller: selected == null
                                  ? null
                                  : _amounts[selected.positionId],
                              enabled: !_submitting && !_transferPending,
                              canSelect: positions.length > 1,
                              onSelect: _openTokenSelector,
                            );
                          },
                          loading: () => const _TransferSkeleton(height: 64),
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
                            final asset =
                                _quote?.targetToken ?? target?.token ?? 'USDC';
                            final network =
                                _quote?.targetNetwork ??
                                target?.network ??
                                'Hyperliquid';
                            return _ReceiveAmountCard(
                              asset: asset,
                              network: network,
                              value:
                                  _quote?.estimatedReceived ??
                                  _quote?.minimumReceived ??
                                  '',
                              loading: _quoting,
                            );
                          },
                          loading: () => const _TransferSkeleton(height: 59),
                          error: (_, _) => const _ReceiveAmountCard(
                            asset: '-',
                            network: '-',
                            value: '',
                          ),
                        ),
                        const SizedBox(height: 16),
                        _FeeSummary(
                          quote: _quote,
                          loading: _quoting || options.isLoading,
                        ),
                        if (_quoting || options.isLoading) ...[
                          const SizedBox(height: 12),
                          const Hip3CrossLiquidationImpactsSkeleton(
                            key: Key('transfer-position-impact-skeleton'),
                          ),
                        ] else if (_quote?.crossLiquidationImpacts.isNotEmpty ==
                            true) ...[
                          const SizedBox(height: 12),
                          Hip3CrossLiquidationImpactsCard(
                            impacts: _quote!.crossLiquidationImpacts,
                          ),
                        ],
                      ] else ...[
                        const SizedBox(height: 16),
                        _SectionLabel(l10n.sendAmount),
                        _Hip3SendAmountCard(
                          controller: _withdrawalAmount,
                          enabled: !_submitting && !_transferPending,
                          balance: hip3Balance?.value,
                          balanceLoading: hip3Balance?.isLoading ?? true,
                          onChanged: _scheduleHip3Preview,
                        ),
                        if (hip3Balance?.hasError ?? false)
                          _LoadError(
                            error: hip3Balance!.error!,
                            onRetry: () =>
                                ref.invalidate(hip3TransferBalanceProvider),
                          ),
                        const SizedBox(height: 16),
                        _SectionLabel(l10n.receiveAmount),
                        _ReceiveAmountCard(
                          asset: 'USDC',
                          network: 'Arbitrum',
                          value:
                              _withdrawal?.minimumReceived ??
                              _withdrawalPreview?.minimumReceived ??
                              '',
                          loading: _withdrawalPreviewing,
                        ),
                        const SizedBox(height: 16),
                        _Hip3FeeSummary(
                          preview: _withdrawalPreview,
                          withdrawal: _withdrawal,
                          loading: _withdrawalPreviewing,
                        ),
                        if (_withdrawalPreviewing) ...[
                          const SizedBox(height: 12),
                          const Hip3CrossLiquidationImpactsSkeleton(
                            key: Key('transfer-position-impact-skeleton'),
                          ),
                        ] else if (_withdrawalPreview
                                ?.crossLiquidationImpacts
                                .isNotEmpty ==
                            true) ...[
                          const SizedBox(height: 12),
                          Hip3CrossLiquidationImpactsCard(
                            impacts:
                                _withdrawalPreview!.crossLiquidationImpacts,
                          ),
                        ],
                      ],
                      const Spacer(),
                      if (visibleError case final error?) ...[
                        const SizedBox(height: 28),
                        InlineErrorNotice(
                          key: const Key('transfer-error'),
                          message: error,
                        ),
                        const SizedBox(height: 8),
                      ] else
                        const SizedBox(height: 28),
                      SizedBox(
                        height: 48,
                        child: FilledButton(
                          onPressed: canSubmit ? _submit : null,
                          child:
                              _submitting ||
                                  (_transferPending && !_planActionRequired)
                              ? const SizedBox.square(
                                  dimension: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(l10n.signAndTransfer),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
            errorMessage(
              error,
              fallback: AppLocalizations.of(context).transferOptionsLoadFailed,
            ),
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

class _SendAmountCard extends StatelessWidget {
  const _SendAmountCard({
    required this.position,
    required this.controller,
    required this.canSelect,
    required this.onSelect,
    required this.enabled,
  });

  final FundingSourcePosition? position;
  final TextEditingController? controller;
  final bool canSelect;
  final VoidCallback onSelect;
  final bool enabled;

  static String _assetPath(String token) => switch (token.toUpperCase()) {
    'USDT' => 'assets/figma/funding/usdt.png',
    'ETH' => 'assets/figma/funding/eth.svg',
    _ => 'assets/figma/funding/usdc.svg',
  };

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final selected = position;
    return Container(
      key: const Key('send-token-card'),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: selected == null || controller == null
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Text(AppLocalizations.of(context).noEligibleFundingAssets),
            )
          : _AssetAmountRow(
              asset: selected.token,
              network: selected.network,
              available: selected.availableAmount.value,
              assetPath: _assetPath(selected.token),
              controller: controller!,
              enabled: enabled,
              canSelect: canSelect,
              onSelect: canSelect && enabled ? onSelect : null,
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
    required this.canSelect,
    required this.onSelect,
    required this.enabled,
  });

  final String asset;
  final String network;
  final String available;
  final String assetPath;
  final TextEditingController controller;
  final bool canSelect;
  final VoidCallback? onSelect;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 64),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                key: const Key('transfer-token-selector'),
                onTap: onSelect,
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  children: [
                    assetPath.endsWith('.svg')
                        ? SvgPicture.asset(assetPath, width: 28, height: 28)
                        : Image.asset(assetPath, width: 28, height: 28),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
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
                              if (canSelect) ...[
                                const SizedBox(width: 2),
                                SvgPicture.asset(
                                  'assets/figma/portfolio/chevron_down.svg',
                                  key: const Key('transfer-token-chevron'),
                                  width: 18,
                                  height: 18,
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            AppLocalizations.of(context).availableAmount(
                              TokenAmountFormatter.formatText(available),
                            ),
                            style: TextStyle(
                              fontSize: 11,
                              height: 14 / 11,
                              color: colors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                  enabled: enabled,
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

class _TokenSelector extends StatelessWidget {
  const _TokenSelector({
    required this.positions,
    required this.query,
    required this.networkFilter,
    required this.onBack,
    required this.onQueryChanged,
    required this.onNetworkChanged,
    required this.onSelected,
  });

  final List<FundingSourcePosition> positions;
  final String query;
  final String? networkFilter;
  final VoidCallback onBack;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<String?> onNetworkChanged;
  final ValueChanged<FundingSourcePosition> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final normalizedQuery = query.trim().toLowerCase();
    final networks =
        positions
            .map((position) => position.network)
            .toSet()
            .toList(growable: false)
          ..sort();
    final filtered = positions
        .where(
          (position) =>
              (networkFilter == null || position.network == networkFilter) &&
              (normalizedQuery.isEmpty ||
                  '${position.token} ${position.network}'
                      .toLowerCase()
                      .contains(normalizedQuery)),
        )
        .toList(growable: false);

    return LayoutBuilder(
      builder: (context, constraints) => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: CustomScrollView(
            key: const Key('transfer-token-picker'),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppPageHeader(
                              title: l10n.transfer,
                              onBack: onBack,
                            ),
                          ),
                          TextButton.icon(
                            key: const Key('transfer-token-history'),
                            onPressed: () =>
                                context.goNamed(AppRoutes.activityName),
                            style: TextButton.styleFrom(
                              foregroundColor: colors.secondaryText,
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(76, 34),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: SvgPicture.asset(
                              'assets/figma/funding/activity.svg',
                              width: 20,
                              height: 20,
                              colorFilter: ColorFilter.mode(
                                colors.primaryText,
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
                          key: const Key('transfer-token-search'),
                          onChanged: onQueryChanged,
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
                        style: TextStyle(
                          fontSize: 12,
                          height: 16 / 12,
                          color: colors.tertiaryText,
                        ),
                      ),
                      const SizedBox(height: 16),
                      AppFilterMenu<String?>(
                        key: const Key('transfer-token-network-filter'),
                        value: networkFilter,
                        label: networkFilter ?? l10n.allNetworks,
                        options: [
                          AppFilterOption(value: null, label: l10n.allNetworks),
                          for (final network in networks)
                            AppFilterOption(value: network, label: network),
                        ],
                        onChanged: onNetworkChanged,
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              if (filtered.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text(l10n.noMatchingAssets)),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  sliver: SliverList.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final position = filtered[index];
                      return _TokenSelectorRow(
                        position: position,
                        onTap: () => onSelected(position),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TokenSelectorRow extends StatelessWidget {
  const _TokenSelectorRow({required this.position, required this.onTap});

  final FundingSourcePosition position;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return InkWell(
      key: Key('transfer-token-${position.positionId}'),
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: 64,
        child: Row(
          children: [
            _PositionIcon(position: position),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    position.token,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 22 / 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppLocalizations.of(context).cash,
                    style: TextStyle(
                      fontSize: 12,
                      height: 16 / 12,
                      color: colors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              TokenAmountFormatter.formatText(position.availableAmount.value),
              style: const TextStyle(
                fontSize: 15,
                height: 22 / 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PositionIcon extends StatelessWidget {
  const _PositionIcon({required this.position});

  final FundingSourcePosition position;

  @override
  Widget build(BuildContext context) {
    final tokenPath = _SendAmountCard._assetPath(position.token);
    final networkPath = networkIconAssetPath(position.network);
    return SizedBox.square(
      dimension: 40,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: tokenPath.endsWith('.svg')
                ? SvgPicture.asset(tokenPath)
                : Image.asset(tokenPath),
          ),
          if (networkPath != null)
            Positioned(
              right: -1,
              bottom: -1,
              child: Container(
                width: 16,
                height: 16,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Theme.of(context).extension<AppRwaColors>()!.surface,
                  border: Border.all(
                    color: Theme.of(context).extension<AppRwaColors>()!.border,
                    width: 0.8,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SvgPicture.asset(networkPath),
              ),
            ),
        ],
      ),
    );
  }
}

class _Hip3SendAmountCard extends StatelessWidget {
  const _Hip3SendAmountCard({
    required this.controller,
    required this.enabled,
    required this.balance,
    required this.balanceLoading,
    required this.onChanged,
  });

  final TextEditingController controller;
  final bool enabled;
  final String? balance;
  final bool balanceLoading;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/figma/funding/usdc.svg',
            width: 28,
            height: 28,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'USDC',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                if (balanceLoading)
                  const SkeletonBlock(
                    key: Key('transfer-balance-skeleton'),
                    width: 72,
                    height: 14,
                    radius: 4,
                  )
                else
                  Text(
                    AppLocalizations.of(context).availableAmount(
                      balance == null
                          ? '-'
                          : TokenAmountFormatter.formatText(balance!),
                    ),
                    style: TextStyle(fontSize: 11, color: colors.secondaryText),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 88,
            height: 32,
            child: TextField(
              key: const Key('hip3-transfer-amount'),
              enabled: enabled,
              controller: controller,
              onChanged: (_) => onChanged(),
              textAlign: TextAlign.right,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                filled: true,
                fillColor: colors.subtleSurface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Hip3FeeSummary extends StatelessWidget {
  const _Hip3FeeSummary({this.preview, this.withdrawal, required this.loading});

  final Hip3WithdrawalPreview? preview;
  final Hip3Withdrawal? withdrawal;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final feeValue = withdrawal?.fee ?? preview?.fee;
    final fee = feeValue == null
        ? '-'
        : '${TokenAmountFormatter.formatText(feeValue)} USDC';
    final details = preview?.feeDetails ?? const <Hip3WithdrawalFeeDetail>[];
    final withdrawalFee = _formatDetail(
      details,
      type: 'withdrawal',
      payer: 'user',
    );
    final networkFee = _formatDetail(
      details,
      type: 'network',
      payer: 'user',
      zeroWhenMissing: true,
    );
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
            _formatEta(preview?.estimatedArrivalSeconds),
            loading: loading,
            skeletonKey: const Key('transfer-quote-eta-skeleton'),
          ),
          const SizedBox(height: 8),
          _FeeRow(
            AppLocalizations.of(context).bridgeFee,
            withdrawalFee,
            loading: loading,
            skeletonKey: const Key('transfer-quote-bridge-fee-skeleton'),
          ),
          const SizedBox(height: 8),
          _FeeRow(
            AppLocalizations.of(context).networkFee,
            networkFee,
            loading: loading,
            skeletonKey: const Key('transfer-quote-network-fee-skeleton'),
          ),
          const SizedBox(height: 8),
          _FeeRow(
            (preview?.rail ?? withdrawal?.rail) == 'relay'
                ? AppLocalizations.of(context).estimatedFee
                : AppLocalizations.of(context).totalFee,
            fee,
            loading: loading,
            skeletonKey: const Key('transfer-quote-total-fee-skeleton'),
          ),
        ],
      ),
    );
  }

  static String _formatEta(int? seconds) {
    if (seconds == null) return '-';
    if (seconds < 60) return '${seconds}s';
    return '~${(seconds / 60).ceil()}min';
  }

  static String _formatDetail(
    List<Hip3WithdrawalFeeDetail> details, {
    required String type,
    required String payer,
    bool zeroWhenMissing = false,
  }) {
    for (final detail in details) {
      if (detail.type == type && detail.payer == payer) {
        final amount = detail.amount;
        if (amount == null) {
          return zeroWhenMissing ? '0 ${detail.currency}' : '-';
        }
        return '${TokenAmountFormatter.formatText(amount)} ${detail.currency}';
      }
    }
    return zeroWhenMissing ? '0 USDC' : '-';
  }
}

class _ReceiveAmountCard extends StatelessWidget {
  const _ReceiveAmountCard({
    required this.asset,
    required this.network,
    required this.value,
    this.loading = false,
  });

  final String asset;
  final String network;
  final String value;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      key: const Key('transfer-receive-amount-card'),
      constraints: const BoxConstraints(minHeight: 59),
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
          if (loading)
            const SkeletonBlock(
              key: Key('transfer-receive-amount-skeleton'),
              width: 56,
              height: 14,
              radius: 4,
            )
          else
            Expanded(
              child: AnimatedNumberText(
                TokenAmountFormatter.formatText(value),
                key: const Key('transfer-receive-amount-value'),
                textAlign: TextAlign.end,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 15,
                  height: 22 / 15,
                  fontWeight: FontWeight.w600,
                ),
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
            loading: loading,
            skeletonKey: const Key('transfer-quote-eta-skeleton'),
          ),
          const SizedBox(height: 8),
          _FeeRow(
            AppLocalizations.of(context).minimumReceived,
            _formatAmount(quote?.minimumReceived, quote?.targetToken),
            valueKey: const Key('transfer-minimum-received-value'),
            comparisonValue: quote?.minimumReceived,
            loading: loading,
            skeletonKey: const Key('transfer-quote-minimum-received-skeleton'),
          ),
          const SizedBox(height: 8),
          _FeeRow(
            AppLocalizations.of(context).slippageTolerance,
            _formatSlippage(quote?.slippageBps),
            valueKey: const Key('transfer-slippage-value'),
            comparisonValue: quote?.slippageBps?.toString(),
            loading: loading,
            skeletonKey: const Key('transfer-quote-slippage-skeleton'),
          ),
          const SizedBox(height: 8),
          _FeeRow(
            AppLocalizations.of(context).bridgeFee,
            _formatFee(fees?.crossChainFee, fees?.asset),
            valueKey: const Key('transfer-bridge-fee-value'),
            comparisonValue: fees?.crossChainFee,
            loading: loading,
            skeletonKey: const Key('transfer-quote-bridge-fee-skeleton'),
          ),
          const SizedBox(height: 8),
          _FeeRow(
            AppLocalizations.of(context).networkFee,
            _formatFee(fees?.networkFee, fees?.asset),
            valueKey: const Key('transfer-network-fee-value'),
            comparisonValue: fees?.networkFee,
            loading: loading,
            skeletonKey: const Key('transfer-quote-network-fee-skeleton'),
          ),
          const SizedBox(height: 8),
          _FeeRow(
            AppLocalizations.of(context).totalFee,
            _formatFee(fees?.totalFee, fees?.asset),
            valueKey: const Key('transfer-total-fee-value'),
            comparisonValue: fees?.totalFee,
            loading: loading,
            skeletonKey: const Key('transfer-quote-total-fee-skeleton'),
          ),
        ],
      ),
    );
  }

  static String _formatEta(int? seconds) {
    if (seconds == null) return '-';
    if (seconds < 60) return '${seconds}s';
    final minutes = (seconds / 60).ceil();
    return '~${minutes}min';
  }

  static String _formatFee(String? amount, String? asset) {
    if (amount == null || asset == null) return '-';
    return '${TokenAmountFormatter.formatText(amount)} $asset';
  }

  static String _formatAmount(String? amount, String? asset) =>
      _formatFee(amount, asset);

  static String _formatSlippage(int? basisPoints) {
    if (basisPoints == null) return '-';
    final whole = basisPoints ~/ 100;
    final remainder = basisPoints % 100;
    if (remainder == 0) return '$whole%';
    final decimals = remainder % 10 == 0
        ? '${remainder ~/ 10}'
        : remainder.toString().padLeft(2, '0');
    return '$whole.$decimals%';
  }
}

class _FeeRow extends StatelessWidget {
  const _FeeRow(
    this.label,
    this.value, {
    this.valueKey,
    this.comparisonValue,
    this.loading = false,
    this.skeletonKey,
  });

  final String label;
  final String value;
  final Key? valueKey;
  final String? comparisonValue;
  final bool loading;
  final Key? skeletonKey;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              height: 18 / 13,
              fontWeight: FontWeight.w500,
              color: colors.secondaryText,
            ),
          ),
        ),
        const SizedBox(width: 8),
        if (loading)
          SkeletonBlock(key: skeletonKey, width: 56, height: 14, radius: 4)
        else if (valueKey == null)
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 13,
                height: 18 / 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        else
          Flexible(
            child: AnimatedNumberText(
              value,
              key: valueKey,
              comparisonValue: comparisonValue,
              textAlign: TextAlign.end,
              softWrap: true,
              style: const TextStyle(
                fontSize: 13,
                height: 18 / 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
