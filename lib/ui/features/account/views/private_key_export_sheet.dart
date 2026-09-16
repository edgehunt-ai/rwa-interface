import 'package:flutter/material.dart';
import 'package:rwa_interface/app/config/privy_configuration.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/feedback/app_toast.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivateKeyExportSheet extends StatelessWidget {
  const PrivateKeyExportSheet({required this.configuration, super.key});

  final PrivyConfiguration configuration;

  Future<void> _continue(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final exportUrl = Uri.tryParse(PrivyConfiguration.privateKeyExportUrl);
    if (configuration.appId.trim().isEmpty ||
        configuration.clientId.trim().isEmpty ||
        exportUrl == null ||
        (exportUrl.scheme != 'https' && exportUrl.scheme != 'http')) {
      if (context.mounted) {
        Navigator.of(context).pop();
        AppToast.showFailure(context, l10n.privyNotConfigured);
      }
      return;
    }

    final uri = exportUrl.replace(
      queryParameters: {
        ...exportUrl.queryParameters,
        'appId': configuration.appId.trim(),
      },
    );
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      AppToast.showFailure(context, l10n.privyUnavailable);
      return;
    }
    if (context.mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Material(
      color: Theme.of(context).extension<AppRwaColors>()!.surface,
      clipBehavior: Clip.antiAlias,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: _handle(context)),
              const SizedBox(height: 16),
              Text(
                l10n.settingsExportPrivateKey,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Center(
                child: Image(
                  image: AssetImage(
                    'assets/figma/account_activity/private_key_warning.png',
                  ),
                  width: 160,
                  height: 160,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 12),
              Text(l10n.settingsPrivateKeyWarning, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: () => _continue(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          l10n.settingsPrivateKeyContinue,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_outward, size: 18),
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

  Widget _handle(BuildContext context) => Container(
    width: 32,
    height: 4,
    decoration: BoxDecoration(
      color: Theme.of(context).extension<AppRwaColors>()!.border,
      borderRadius: BorderRadius.circular(2),
    ),
  );
}
