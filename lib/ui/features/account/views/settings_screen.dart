import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/auth/authentication.dart';
import 'package:rwa_interface/domain/auth/identity_auth_gateway.dart';
import 'package:rwa_interface/domain/models/app_update.dart';
import 'package:rwa_interface/domain/models/account_deletion.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/app/providers/locale_provider.dart';
import 'package:rwa_interface/domain/models/user_account.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/feedback/app_toast.dart';
import 'package:rwa_interface/ui/core/feedback/design_state_feedback.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/account/providers/account_providers.dart';
import 'package:rwa_interface/ui/features/account/providers/app_update_providers.dart';
import 'package:rwa_interface/ui/features/account/providers/cache_providers.dart';
import 'package:rwa_interface/ui/features/session/providers/authentication_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(accountProvider);
    final authentication = ref.watch(authenticationProvider);
    final passkey = ref.watch(passkeyProvider);
    final cacheSize = ref.watch(cacheSizeProvider);
    final clearingCache = ref.watch(cacheCommandProvider).isLoading;
    final installedAppInfo = ref.watch(installedAppInfoProvider);
    final checkingForUpdate = ref.watch(appUpdateCommandProvider).isLoading;
    ref.listen<AsyncValue<UserAccount>>(accountProvider, (_, next) {
      next.whenData(
        (account) => ref
            .read<AppLocaleNotifier>(appLocaleProvider.notifier)
            .setLanguage(account.settings.language),
      );
    });
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const _SettingsHeader(),
            const SizedBox(height: 16),
            Expanded(
              child: account.when(
                loading: () => DesignStateFeedback(
                  state: DesignState.loading,
                  title: AppLocalizations.of(context).settingsLoading,
                ),
                error: (_, _) => DesignStateFeedback(
                  state: DesignState.failure,
                  title: AppLocalizations.of(context).settingsUnavailable,
                  message: AppLocalizations.of(context).settingsRetry,
                  onRetry: () => ref.refresh(accountProvider.future),
                ),
                data: (account) => _SettingsContent(
                  name: accountDisplayName(
                    account,
                    identityDisplayName: switch (authentication) {
                      AuthenticationAuthenticated(:final principal) =>
                        principal.displayName,
                      _ => null,
                    },
                  ),
                  language: account.settings.language,
                  passkey: _passkeyValue(passkey),
                  passkeyLoading: passkey.isLoading,
                  onPasskey: () =>
                      _showPasskeySheet(context, ref, _passkeyValue(passkey)),
                  onLanguage: () => _showLanguageSheet(
                    context,
                    ref,
                    account.settings.language,
                  ),
                  onPrivateKey: () => _showPrivateKeyWarning(context),
                  appVersion: switch (installedAppInfo) {
                    AsyncData(:final value) => 'v${value.version}',
                    _ => '...',
                  },
                  checkingForUpdate: checkingForUpdate,
                  onCheckForUpdates: () => _checkForUpdates(context, ref),
                  cacheSizeBytes: switch (cacheSize) {
                    AsyncData(:final value) => value,
                    _ => null,
                  },
                  clearingCache: clearingCache,
                  onClearCache: () =>
                      ref.read(cacheCommandProvider.notifier).clear(),
                  onLogOut: () => _showLogOutConfirmation(context, ref),
                  onDeleteAccount: () =>
                      _showDeleteAccountConfirmation(context, ref),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkForUpdates(BuildContext context, WidgetRef ref) async {
    final update = await ref
        .read(appUpdateCommandProvider.notifier)
        .checkForUpdate();
    if (!context.mounted) return;
    final l10n = AppLocalizations.of(context);
    if (update == null) {
      AppToast.showFailure(context, l10n.settingsUpdateCheckFailed);
      return;
    }
    switch (update.availability) {
      case AppUpdateAvailability.upToDate:
        AppToast.showSuccess(context, l10n.settingsUpToDate);
      case AppUpdateAvailability.unavailable:
        AppToast.showFailure(context, l10n.settingsUpdateUnavailable);
      case AppUpdateAvailability.available || AppUpdateAvailability.required:
        final storeUri = update.storeUri;
        if (storeUri == null) {
          AppToast.showFailure(context, l10n.settingsUpdateUnavailable);
          return;
        }
        showModalBottomSheet<void>(
          context: context,
          builder: (sheetContext) => _NoticeSheet(
            title: l10n.settingsUpdateAvailable,
            message: update.releaseNotes?.trim().isNotEmpty == true
                ? update.releaseNotes!
                : l10n.settingsUpdateAvailableMessage(update.latestVersion!),
            actions: [
              if (update.availability == AppUpdateAvailability.available)
                OutlinedButton(
                  onPressed: () => Navigator.of(sheetContext).pop(),
                  child: Text(l10n.cancel),
                ),
              FilledButton(
                onPressed: () async {
                  await launchUrl(
                    storeUri,
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Text(l10n.settingsUpdateNow),
              ),
            ],
          ),
        );
    }
  }

  Future<void> _showPasskeySheet(
    BuildContext context,
    WidgetRef ref,
    PasskeyCredential? passkey,
  ) async {
    final action = await showModalBottomSheet<_PasskeyAction>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: const Color(0x70111215),
      builder: (_) => _PasskeySheet(passkey: passkey),
    );
    if (!context.mounted || action == null) return;
    final l10n = AppLocalizations.of(context);
    switch (action) {
      case _PasskeyAction.linked:
        AppToast.showSuccess(context, l10n.settingsPasskeySetupSucceeded);
      case _PasskeyAction.unlinked:
        AppToast.showSuccess(context, l10n.settingsPasskeyRemoveSucceeded);
    }
  }

  Future<void> _showLanguageSheet(
    BuildContext context,
    WidgetRef ref,
    String current,
  ) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: const Color(0x70111215),
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

  void _showDeleteAccountConfirmation(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => Consumer(
        builder: (modalContext, sheetRef, _) => _NoticeSheet(
          title: l10n.settingsDeleteAccount,
          message: l10n.settingsDeleteAccountMessage,
          actions: [
            OutlinedButton(
              onPressed:
                  sheetRef.watch(accountDeletionCommandProvider).isLoading
                  ? null
                  : () => Navigator.of(sheetContext).pop(),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed:
                  sheetRef.watch(accountDeletionCommandProvider).isLoading
                  ? null
                  : () => _requestAccountDeletion(context, sheetContext, ref),
              child: sheetRef.watch(accountDeletionCommandProvider).isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(l10n.settingsDeleteAccountConfirm),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _requestAccountDeletion(
    BuildContext context,
    BuildContext sheetContext,
    WidgetRef ref,
  ) async {
    final l10n = AppLocalizations.of(context);
    final deletion = await ref
        .read(accountDeletionCommandProvider.notifier)
        .request();
    if (deletion == null) {
      final error = ref.read(accountDeletionCommandProvider).error;
      if (sheetContext.mounted) Navigator.of(sheetContext).pop();
      if (context.mounted) {
        AppToast.showFailure(context, _deletionFailureMessage(l10n, error));
      }
      return;
    }
    final accepted = switch (deletion.state) {
      AccountDeletionState.requested ||
      AccountDeletionState.processing ||
      AccountDeletionState.anonymized => true,
      _ => false,
    };
    if (!accepted) {
      if (sheetContext.mounted) Navigator.of(sheetContext).pop();
      if (context.mounted) {
        AppToast.showFailure(context, l10n.settingsDeleteAccountBlocked);
      }
      return;
    }

    if (sheetContext.mounted) {
      Navigator.of(sheetContext).pop();
    }
    await ref.read(authenticationProvider.notifier).logout();
    if (!context.mounted) return;
    AppToast.showSuccess(context, l10n.settingsDeleteAccountAccepted);
    GoRouter.maybeOf(context)?.goNamed(AppRoutes.loginName);
  }

  String _deletionFailureMessage(AppLocalizations l10n, Object? error) {
    if (error case ServerFailure(code: 'recent_auth_required')) {
      return l10n.settingsDeleteAccountRecentAuth;
    }
    if (error case ServerFailure(statusCode: 409)) {
      return l10n.settingsDeleteAccountBlocked;
    }
    return l10n.settingsDeleteAccountFailed;
  }
}

PasskeyCredential? _passkeyValue(AsyncValue<PasskeyCredential?> value) =>
    switch (value) {
      AsyncData(:final value) => value,
      _ => null,
    };

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
    child: Row(
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
  );
}

class _SettingsContent extends StatelessWidget {
  const _SettingsContent({
    required this.name,
    required this.language,
    required this.passkey,
    required this.passkeyLoading,
    required this.onPasskey,
    required this.onLanguage,
    required this.onPrivateKey,
    required this.appVersion,
    required this.checkingForUpdate,
    required this.onCheckForUpdates,
    required this.cacheSizeBytes,
    required this.clearingCache,
    required this.onClearCache,
    required this.onLogOut,
    required this.onDeleteAccount,
  });

  final String name;
  final String language;
  final PasskeyCredential? passkey;
  final bool passkeyLoading;
  final VoidCallback onPasskey;
  final VoidCallback onLanguage;
  final VoidCallback onPrivateKey;
  final String appVersion;
  final bool checkingForUpdate;
  final VoidCallback onCheckForUpdates;
  final int? cacheSizeBytes;
  final bool clearingCache;
  final VoidCallback onClearCache;
  final VoidCallback onLogOut;
  final VoidCallback onDeleteAccount;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      children: [
        _Card(child: _AccountRow(name: name)),
        const SizedBox(height: 16),
        _Card(
          child: _PasskeyRow(
            passkey: passkey,
            loading: passkeyLoading,
            onTap: onPasskey,
          ),
        ),
        const SizedBox(height: 16),
        _Card(
          child: Column(
            children: [
              _SettingRow(
                asset: 'assets/figma/account_activity/language.svg',
                label: AppLocalizations.of(context).settingsLanguage,
                value: _languageLabel(AppLocalizations.of(context), language),
                onTap: onLanguage,
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              _SettingRow(
                asset: 'assets/figma/account_activity/private_key.svg',
                label: AppLocalizations.of(context).settingsExportPrivateKey,
                trailing: const _ChevronRight(),
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
                asset: 'assets/figma/account_activity/update.svg',
                label: AppLocalizations.of(context).settingsCheckUpdates,
                value: checkingForUpdate ? '...' : 'Check',
                onTap: checkingForUpdate ? null : onCheckForUpdates,
              ),
              Divider(height: 1, indent: 16, endIndent: 16),
              _SettingRow(
                asset: 'assets/figma/account_activity/version.svg',
                label: AppLocalizations.of(context).settingsAppVersion,
                value: appVersion,
              ),
              Divider(height: 1, indent: 16, endIndent: 16),
              _SettingRow(
                asset: 'assets/figma/account_activity/cache.svg',
                label: AppLocalizations.of(context).settingsCacheSize,
                trailing: _CacheSizeValue(
                  bytes: cacheSizeBytes,
                  clearing: clearingCache,
                  onClear: onClearCache,
                ),
                trailingBelowAtLargeText: true,
              ),
              Divider(height: 1, indent: 16, endIndent: 16),
              _SettingRow(
                asset: 'assets/figma/account_activity/terms_conditions.svg',
                label: AppLocalizations.of(context).settingsTermsConditions,
                trailing: const _ChevronRight(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _Card(
          child: Column(
            children: [
              _SettingRow(
                asset: 'assets/figma/account_activity/logout.svg',
                label: AppLocalizations.of(context).settingsLogOut,
                labelColor: Theme.of(context)
                    .extension<AppSemanticColors>()!
                    .loss,
                onTap: onLogOut,
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              _SettingRow(
                asset: 'assets/figma/account_activity/delete_account.svg',
                label: AppLocalizations.of(context).settingsDeleteAccount,
                trailing: const _ChevronRight(),
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
    required this.asset,
    required this.label,
    this.value,
    this.trailing,
    this.labelColor,
    this.onTap,
    this.trailingBelowAtLargeText = false,
  });
  final String asset;
  final String label;
  final String? value;
  final Widget? trailing;
  final Color? labelColor;
  final VoidCallback? onTap;
  final bool trailingBelowAtLargeText;
  @override
  Widget build(BuildContext context) {
    final iconWidget = SvgPicture.asset(asset, width: 24, height: 24);
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
                SizedBox(
                  width: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Center(child: iconWidget),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label, style: labelStyle),
                      if (value != null && value!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(value!, style: valueStyle, maxLines: 2),
                      ],
                      if (trailingBelowAtLargeText && trailing != null) ...[
                        const SizedBox(height: 4),
                        trailing!,
                      ],
                    ],
                  ),
                ),
                if (!trailingBelowAtLargeText && trailing != null) ...[
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
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              SizedBox(width: 40, height: 40, child: Center(child: iconWidget)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: labelStyle,
                ),
              ),
              if (trailing ?? _value(value, valueStyle)
                  case final trailing?) ...[
                const SizedBox(width: 12),
                trailing,
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget? _value(String? value, TextStyle style) => value == null
      ? null
      : Text(value, maxLines: 1, overflow: TextOverflow.ellipsis, style: style);
}

class _PasskeyRow extends StatelessWidget {
  const _PasskeyRow({
    required this.passkey,
    required this.loading,
    required this.onTap,
  });

  final PasskeyCredential? passkey;
  final bool loading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final enlargedText = MediaQuery.textScalerOf(context).scale(14) > 18;
    final status = loading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Text(
            passkey == null
                ? l10n.settingsPasskeyNotSetUp
                : l10n.settingsPasskeyEnabled,
            style: TextStyle(
              color: colors.secondaryText,
              fontSize: 15,
              height: 22 / 15,
              fontWeight: FontWeight.w500,
            ),
          );
    return InkWell(
      onTap: loading ? null : onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 110),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/figma/account_activity/passkey.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.settingsPasskey,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 22 / 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.settingsPasskeyDescription,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colors.secondaryText,
                        fontSize: 12,
                        height: 16 / 12,
                      ),
                    ),
                    if (enlargedText) ...[const SizedBox(height: 4), status],
                  ],
                ),
              ),
              if (!enlargedText) ...[const SizedBox(width: 12), status],
            ],
          ),
        ),
      ),
    );
  }
}

enum _PasskeyAction { linked, unlinked }

class _PasskeySheet extends ConsumerStatefulWidget {
  const _PasskeySheet({required this.passkey});

  final PasskeyCredential? passkey;

  @override
  ConsumerState<_PasskeySheet> createState() => _PasskeySheetState();
}

class _PasskeySheetState extends ConsumerState<_PasskeySheet> {
  var _submitting = false;

  Future<void> _submit() async {
    setState(() => _submitting = true);
    try {
      if (widget.passkey case final passkey?) {
        await ref.read(passkeyProvider.notifier).unlink(passkey.id);
        if (mounted) Navigator.of(context).pop(_PasskeyAction.unlinked);
      } else {
        await ref.read(passkeyProvider.notifier).link();
        if (mounted) Navigator.of(context).pop(_PasskeyAction.linked);
      }
    } on Object {
      if (mounted) {
        AppToast.showFailure(
          context,
          widget.passkey == null
              ? AppLocalizations.of(context).settingsPasskeySetupFailed
              : AppLocalizations.of(context).settingsPasskeyRemoveFailed,
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final removing = widget.passkey != null;
    return Material(
      color: colors.surface,
      clipBehavior: Clip.antiAlias,
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
                    color: colors.secondaryText.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.settingsPasskeySetupTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                removing
                    ? l10n.settingsPasskeyRemoveDescription
                    : l10n.settingsPasskeySetupDescription,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.settingsPasskeyExistingMethods,
                style: TextStyle(
                  color: colors.secondaryText,
                  fontSize: 13,
                  height: 18 / 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: _submitting ? null : _submit,
                      style: removing
                          ? FilledButton.styleFrom(
                              backgroundColor: const Color(0xFFDE596E),
                            )
                          : null,
                      child: _submitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              removing
                                  ? l10n.settingsPasskeyRemoveAction
                                  : l10n.settingsPasskeySetUpAction,
                            ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _submitting
                          ? null
                          : () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: colors.subtleSurface,
                      ),
                      child: Text(l10n.settingsNotNow),
                    ),
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

class _AccountRow extends StatelessWidget {
  const _AccountRow({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 66),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(color: colors.border),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/figma/account_activity/account_avatar.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
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
                  const SizedBox(height: 4),
                  Text(
                    AppLocalizations.of(context).settingsActiveAccount,
                    style: TextStyle(
                      color: colors.secondaryText,
                      fontSize: 12,
                      height: 16 / 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChevronRight extends StatelessWidget {
  const _ChevronRight();

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 20,
    height: 20,
    child: SvgPicture.asset(
      'assets/figma/account_activity/chevron_right.svg',
      fit: BoxFit.none,
    ),
  );
}

class _CacheSizeValue extends StatelessWidget {
  const _CacheSizeValue({
    required this.bytes,
    required this.clearing,
    required this.onClear,
  });

  final int? bytes;
  final bool clearing;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final textStyle = TextStyle(
      color: colors.secondaryText,
      fontSize: 15,
      height: 22 / 15,
      fontWeight: FontWeight.w500,
    );
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(_formatCacheSize(bytes), style: textStyle),
        Text(' · ', style: textStyle),
        TextButton(
          onPressed: clearing ? null : onClear,
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            foregroundColor: colors.secondaryText,
            textStyle: textStyle,
          ),
          child: clearing
              ? const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(strokeWidth: 1.5),
                )
              : Text(l10n.settingsClearCache),
        ),
      ],
    );
  }
}

String _formatCacheSize(int? bytes) {
  if (bytes == null) return '...';
  if (bytes < 1024) return '$bytes B';
  final kilobytes = bytes / 1024;
  if (kilobytes < 1024) return '${kilobytes.toStringAsFixed(1)} KB';
  final megabytes = kilobytes / 1024;
  return '${megabytes.toStringAsFixed(1)} MB';
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

  static const _languages = <({String code, String label})>[
    (code: 'en', label: 'English'),
    (code: 'zh-CN', label: '中文 (Chinese)'),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Material(
      color: colors.surface,
      clipBehavior: Clip.antiAlias,
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
                    color: colors.secondaryText.withValues(alpha: 0.45),
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
              for (var index = 0; index < _languages.length; index++) ...[
                _LanguageOption(
                  key: ValueKey('language-option-${_languages[index].code}'),
                  label: _languages[index].label,
                  selected: _selected == _languages[index].code,
                  onTap: () =>
                      setState(() => _selected = _languages[index].code),
                ),
                if (index < _languages.length - 1)
                  Divider(color: colors.subtleSurface, height: 1),
              ],
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
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
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Semantics(
      selected: selected,
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 48,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 18 / 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: selected ? colors.primaryAction : colors.subtleSurface,
                  shape: BoxShape.circle,
                  border: selected
                      ? null
                      : Border.all(color: colors.border.withValues(alpha: 0.7)),
                ),
                child: selected
                    ? Icon(Icons.check, size: 14, color: colors.onPrimaryAction)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
