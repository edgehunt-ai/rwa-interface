import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/app/providers/locale_provider.dart';
import 'package:rwa_interface/domain/models/user_account.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/feedback/design_state_feedback.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/account/providers/account_providers.dart';
import 'package:rwa_interface/ui/features/session/providers/authentication_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(accountProvider);
    ref.listen<AsyncValue<UserAccount>>(accountProvider, (_, next) {
      next.whenData(
        (account) => ref
            .read<AppLocaleNotifier>(appLocaleProvider.notifier)
            .setLanguage(account.settings.language),
      );
    });
    return Scaffold(
      body: SafeArea(
        child: account.when(
          loading: () => DesignStateFeedback(
            state: DesignState.loading,
            title: AppLocalizations.of(context).settingsLoading,
          ),
          error: (_, _) => DesignStateFeedback(
            state: DesignState.failure,
            title: AppLocalizations.of(context).settingsUnavailable,
            message: AppLocalizations.of(context).settingsRetry,
            onRetry: () => ref.refresh(accountProvider),
          ),
          data: (account) => _SettingsContent(
            name: account.displayName ?? account.userId,
            language: account.settings.language,
            onLanguage: () =>
                _showLanguageSheet(context, ref, account.settings.language),
            onPrivateKey: () => _showPrivateKeyWarning(context),
            onLogOut: () => _showLogOutConfirmation(context, ref),
            onDeleteAccount: () => _showDeletionUnavailable(context),
          ),
        ),
      ),
    );
  }

  Future<void> _showLanguageSheet(
    BuildContext context,
    WidgetRef ref,
    String current,
  ) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _LanguageSheet(current: current),
    );
    if (selected != null && selected != current) {
      await ref
          .read(settingsCommandProvider.notifier)
          .updateSettings(UserPreferencesPatch(language: selected));
      if (!ref.read(settingsCommandProvider).hasError) {
        ref
            .read<AppLocaleNotifier>(appLocaleProvider.notifier)
            .setLanguage(selected);
      }
    }
  }

  void _showPrivateKeyWarning(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => _NoticeSheet(
        title: l10n.settingsExportPrivateKey,
        message: l10n.settingsPrivateKeyWarning,
        actionLabel: l10n.confirm,
        illustration: const Image(
          image: AssetImage(
            'assets/figma/account_activity/private_key_warning.png',
          ),
          width: 160,
          height: 160,
          fit: BoxFit.contain,
        ),
        onAction: () => Navigator.of(sheetContext).pop(),
      ),
    );
  }

  void _showLogOutConfirmation(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => _NoticeSheet(
        title: l10n.settingsLogOut,
        message: l10n.settingsLogOutQuestion,
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.of(sheetContext).pop(),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () async {
              await ref.read(authenticationProvider.notifier).logout();
              if (sheetContext.mounted) {
                Navigator.of(sheetContext).pop();
              }
              final router = context.mounted ? GoRouter.maybeOf(context) : null;
              if (router != null) {
                router.goNamed(AppRoutes.loginName);
              }
            },
            child: Text(l10n.settingsLogOut),
          ),
        ],
      ),
    );
  }

  void _showDeletionUnavailable(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => _NoticeSheet(
        title: l10n.settingsDeleteAccount,
        message: l10n.settingsDeleteAccountMessage,
        actionLabel: l10n.confirm,
        onAction: () => Navigator.of(sheetContext).pop(),
      ),
    );
  }
}

class _SettingsContent extends StatelessWidget {
  const _SettingsContent({
    required this.name,
    required this.language,
    required this.onLanguage,
    required this.onPrivateKey,
    required this.onLogOut,
    required this.onDeleteAccount,
  });

  final String name;
  final String language;
  final VoidCallback onLanguage;
  final VoidCallback onPrivateKey;
  final VoidCallback onLogOut;
  final VoidCallback onDeleteAccount;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
      children: [
        Row(
          children: [
            SizedBox(
              width: 20,
              height: 34,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints.tightFor(width: 20),
                tooltip: AppLocalizations.of(context).back,
                onPressed: () => context.canPop() ? context.pop() : null,
                icon: const Icon(Icons.chevron_left, size: 20),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                AppLocalizations.of(context).settingsTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _Card(
          child: SizedBox(
            height: 66,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              minLeadingWidth: 40,
              leading: CircleAvatar(
                backgroundImage: const AssetImage(
                  'assets/figma/account_activity/account_avatar.png',
                ),
              ),
              title: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  height: 1,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                ),
              ),
              subtitle: Text(
                AppLocalizations.of(context).settingsActiveAccount,
                style: TextStyle(
                  fontSize: 12,
                  height: 16 / 12,
                  color: Theme.of(context)
                      .extension<AppRwaColors>()!
                      .secondaryText,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _Card(
          child: Column(
            children: [
              _SettingRow(
                icon: Icons.language,
                asset: 'assets/figma/account_activity/language.svg',
                label: AppLocalizations.of(context).settingsLanguage,
                value: _languageLabel(AppLocalizations.of(context), language),
                onTap: onLanguage,
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              _SettingRow(
                icon: Icons.key_outlined,
                asset: 'assets/figma/account_activity/private_key.svg',
                label: AppLocalizations.of(context).settingsExportPrivateKey,
                trailing: Icon(Icons.chevron_right),
                onTap: onPrivateKey,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _Card(
          child: Column(
            children: [
              _SettingRow(
                icon: Icons.system_update_outlined,
                asset: 'assets/figma/account_activity/update.svg',
                label: AppLocalizations.of(context).settingsCheckUpdates,
                value: AppLocalizations.of(context).settingsCheckUpdates,
              ),
              Divider(height: 1, indent: 16, endIndent: 16),
              _SettingRow(
                icon: Icons.info_outline,
                asset: 'assets/figma/account_activity/version.svg',
                label: AppLocalizations.of(context).settingsAppVersion,
                value: AppLocalizations.of(context).settingsAppVersionValue,
              ),
              Divider(height: 1, indent: 16, endIndent: 16),
              _SettingRow(
                icon: Icons.storage_outlined,
                asset: 'assets/figma/account_activity/cache.svg',
                label: AppLocalizations.of(context).settingsCacheSize,
                value: AppLocalizations.of(context).settingsCacheSizeValue,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _Card(
          child: Column(
            children: [
              _SettingRow(
                icon: Icons.power_settings_new,
                asset: 'assets/figma/account_activity/logout.svg',
                label: AppLocalizations.of(context).settingsLogOut,
                labelColor: Theme.of(context)
                    .extension<AppSemanticColors>()!
                    .loss,
                onTap: onLogOut,
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              _SettingRow(
                icon: Icons.no_accounts_outlined,
                asset: 'assets/figma/account_activity/delete_account.svg',
                label: AppLocalizations.of(context).settingsDeleteAccount,
                trailing: Icon(Icons.chevron_right),
                onTap: onDeleteAccount,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

String _languageLabel(AppLocalizations l10n, String language) =>
    switch (language) {
      'zh-CN' || 'zh' => l10n.languageSimplifiedChinese,
      _ => l10n.languageEnglish,
    };

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    clipBehavior: Clip.antiAlias,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    child: child,
  );
}

class _SettingRow extends StatelessWidget {
  const _SettingRow({
    required this.icon,
    this.asset,
    required this.label,
    this.value,
    this.trailing,
    this.labelColor,
    this.onTap,
  });
  final IconData icon;
  final String? asset;
  final String label;
  final String? value;
  final Widget? trailing;
  final Color? labelColor;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final iconWidget = asset == null
        ? Icon(icon)
        : SvgPicture.asset(asset!, width: 24, height: 24);
    final valueStyle = TextStyle(
      color: Theme.of(context).extension<AppRwaColors>()!.secondaryText,
      fontSize: 15,
      height: 22 / 15,
      fontWeight: FontWeight.w500,
    );
    final labelStyle = TextStyle(
      color: labelColor,
      fontSize: 15,
      height: 22 / 15,
      fontWeight: FontWeight.w600,
    );
    final enlargedText = MediaQuery.textScalerOf(context).scale(14) > 18;
    if (enlargedText) {
      return InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 70),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: iconWidget,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label, style: labelStyle),
                      if (value != null && value!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(value!, style: valueStyle, maxLines: 2),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: 12),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: trailing!,
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    }
    return SizedBox(
      height: 70,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        minLeadingWidth: 40,
        leading: iconWidget,
        title: Text(label, style: labelStyle),
        trailing: trailing ?? Text(value ?? '', style: valueStyle),
      ),
    );
  }
}

class _NoticeSheet extends StatelessWidget {
  const _NoticeSheet({
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.actions,
    this.illustration,
  });

  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final List<Widget>? actions;
  final Widget? illustration;

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).extension<AppRwaColors>()!.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            if (illustration case final illustration?) ...[
              const SizedBox(height: 16),
              Center(child: illustration),
            ],
            const SizedBox(height: 12),
            Text(message),
            const SizedBox(height: 24),
            if (actions case final actions?)
              Row(
                children: [
                  for (final action in actions) ...[
                    Expanded(child: SizedBox(height: 48, child: action)),
                    if (action != actions.last) const SizedBox(width: 12),
                  ],
                ],
              )
            else
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onAction,
                  child: Text(actionLabel!),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

class _LanguageSheet extends StatefulWidget {
  const _LanguageSheet({required this.current});

  final String current;

  @override
  State<_LanguageSheet> createState() => _LanguageSheetState();
}

class _LanguageSheetState extends State<_LanguageSheet> {
  late var _selected = widget.current;

  static const _languages = <String>['en', 'zh-CN'];

  @override
  Widget build(BuildContext context) => Material(
    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
    child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).extension<AppRwaColors>()!.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).settingsLanguage,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            for (final language in _languages)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  _languageLabel(AppLocalizations.of(context), language),
                ),
                trailing: _selected == language
                    ? const Icon(Icons.check)
                    : null,
                onTap: () => setState(() => _selected = language),
              ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(_selected),
                child: Text(AppLocalizations.of(context).confirm),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
