import 'package:flutter/material.dart';

import '../../../../domain/models/api_failure.dart';
import '../../../../ui/core/theme/app_theme.dart';

class Hip3UnifiedAccountSheet extends StatefulWidget {
  const Hip3UnifiedAccountSheet({super.key, required this.onConfirm});

  final Future<void> Function() onConfirm;

  @override
  State<Hip3UnifiedAccountSheet> createState() =>
      _Hip3UnifiedAccountSheetState();
}

class _Hip3UnifiedAccountSheetState extends State<Hip3UnifiedAccountSheet> {
  var _loading = false;
  String? _error;

  bool get _isZh => Localizations.localeOf(context).languageCode == 'zh';

  Future<void> _confirm() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await widget.onConfirm();
      if (mounted) Navigator.of(context).pop(true);
    } on ApiFailure catch (failure) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = apiFailureMessage(
            failure,
            fallback: _isZh ? '统一交易账户设置失败' : 'Unified Trading setup failed',
          );
        });
      }
    } on Object catch (error, stackTrace) {
      debugPrint('HIP-3 unified account conversion failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      if (mounted) {
        setState(() {
          _loading = false;
          _error = _isZh
              ? '${error.runtimeType}: $error'
              : '${error.runtimeType}: $error';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final title = _isZh ? '账户设置' : 'Account Settings';
    final heading = _isZh ? '设置统一交易' : 'Set Up Unified Trading';
    final body = _isZh
        ? '当前余额按产品分开管理。设置统一交易后，您可以使用一个余额交易现货、永续合约和 HIP-3。您的资金仍在账户中。'
        : 'Your current balance is separated by product. Set up Unified Trading to use one balance across Spot, Perps, and HIP-3. Your funds stay in your account.';
    final action = _isZh ? '立即设置' : 'Set Up Now';

    return Material(
      color: colors.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 4,
                child: Center(
                  child: SizedBox(
                    width: 32,
                    height: 4,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(0x73676776),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 26,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        height: 26 / 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                      ),
                    ),
                    IconButton(
                      tooltip: _isZh ? '关闭' : 'Close',
                      onPressed: _loading
                          ? null
                          : () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints.tightFor(
                        width: 24,
                        height: 24,
                      ),
                      icon: const Icon(Icons.close, size: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Divider(height: 1, thickness: 1, color: Color(0xFFF1F1F5)),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      width: 320,
                      height: 160,
                      child: Image.asset(
                        'assets/figma/trade/unified_trading_illustration.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      heading,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        height: 22 / 17,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      body,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        height: 16 / 12,
                        color: colors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  key: const Key('hip3-unified-account-confirm'),
                  onPressed: _loading ? null : _confirm,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF171719),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: _loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          action,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 22 / 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              if (_error case final error?) ...[
                const SizedBox(height: 8),
                Text(error, style: TextStyle(color: semantic.loss)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
