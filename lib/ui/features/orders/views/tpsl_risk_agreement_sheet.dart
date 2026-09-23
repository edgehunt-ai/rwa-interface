import 'package:flutter/material.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';

class TpSlInlineError extends StatelessWidget {
  const TpSlInlineError({super.key, required this.messages});

  final List<String> messages;

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) return const SizedBox.shrink();
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    return Container(
      key: const Key('tpsl-inline-error'),
      constraints: const BoxConstraints(minHeight: 40),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEEF0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        messages.join('\n'),
        style: TextStyle(fontSize: 12, height: 16 / 12, color: semantic.loss),
      ),
    );
  }
}

class TpSlConsentRow extends StatelessWidget {
  const TpSlConsentRow({
    super.key,
    required this.accepted,
    required this.onChanged,
    required this.onOpenDetails,
  });

  final bool accepted;
  final ValueChanged<bool> onChanged;
  final VoidCallback onOpenDetails;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          key: const Key('tpsl-risk-checkbox'),
          value: accepted,
          onChanged: (value) => onChanged(value ?? false),
          visualDensity: VisualDensity.compact,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: l10n.tpSlRiskAgreementPrefix),
                  WidgetSpan(
                    child: GestureDetector(
                      key: const Key('tpsl-risk-details'),
                      onTap: onOpenDetails,
                      child: Text(
                        l10n.tpSlRiskAgreementLink,
                        style: TextStyle(
                          color: colors.primaryText,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  if (Localizations.localeOf(context).languageCode == 'en')
                    const TextSpan(text: '.'),
                ],
              ),
              style: TextStyle(
                fontSize: 13,
                height: 18 / 13,
                color: colors.primaryText,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TpSlRiskAgreementSheet extends StatefulWidget {
  const TpSlRiskAgreementSheet({super.key, required this.onAccepted});

  final VoidCallback onAccepted;

  @override
  State<TpSlRiskAgreementSheet> createState() => _TpSlRiskAgreementSheetState();
}

class _TpSlRiskAgreementSheetState extends State<TpSlRiskAgreementSheet> {
  var _accepted = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
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
              Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.secondaryText.withValues(alpha: .45),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.tpSlRiskAgreementTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      height: 26 / 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.2,
                    ),
                  ),
                  IconButton(
                    key: const Key('tpsl-risk-close'),
                    tooltip: l10n.cancel,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.subtleSurface,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  l10n.tpSlRiskAgreementDetails,
                  style: TextStyle(
                    fontSize: 12,
                    height: 16 / 12,
                    color: colors.secondaryText,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _TpSlAgreementConsentRow(
                accepted: _accepted,
                onChanged: (value) => setState(() => _accepted = value),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  key: const Key('tpsl-risk-confirm'),
                  onPressed: _accepted ? widget.onAccepted : null,
                  child: Text(l10n.confirm),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TpSlAgreementConsentRow extends StatelessWidget {
  const _TpSlAgreementConsentRow({
    required this.accepted,
    required this.onChanged,
  });

  final bool accepted;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return Semantics(
      container: true,
      checked: accepted,
      label: l10n.tpSlRiskAgreementConsent,
      child: InkWell(
        key: const Key('tpsl-risk-agreement-row'),
        onTap: () => onChanged(!accepted),
        borderRadius: BorderRadius.circular(4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              key: const Key('tpsl-risk-agreement-checkbox'),
              value: accepted,
              onChanged: (value) => onChanged(value ?? false),
              visualDensity: VisualDensity.compact,
            ),
            Expanded(
              child: Text(
                l10n.tpSlRiskAgreementConsent,
                style: TextStyle(
                  fontSize: 13,
                  height: 18 / 13,
                  fontWeight: FontWeight.w500,
                  color: colors.primaryText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
