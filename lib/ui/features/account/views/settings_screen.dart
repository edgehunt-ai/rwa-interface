import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/app/providers/auth_providers.dart';
import 'package:nobell/domain/auth/authentication.dart';
import 'package:nobell/domain/auth/identity_auth_gateway.dart';
import 'package:nobell/domain/models/app_update.dart';
import 'package:nobell/domain/models/account_deletion.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/app/providers/locale_provider.dart';
import 'package:nobell/app/providers/theme_mode_provider.dart';
import 'package:nobell/domain/models/user_account.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/feedback/app_toast.dart';
import 'package:nobell/ui/core/feedback/design_state_feedback.dart';
import 'package:nobell/ui/core/navigation/app_page_header.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/core/widgets/account_avatar.dart';
import 'package:nobell/ui/features/account/providers/account_providers.dart';
import 'package:nobell/ui/features/account/providers/app_update_providers.dart';
import 'package:nobell/ui/features/account/providers/cache_providers.dart';
import 'package:nobell/ui/features/account/views/private_key_export_sheet.dart';
import 'package:nobell/ui/features/session/providers/authentication_provider.dart';
import 'package:nobell/ui/features/session/views/privy_login_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nobell/ui/core/widgets/app_svg_icon.dart';

import '../../../core/feedback/error_message.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authentication = ref.watch(authenticationProvider);
    final authenticated = authentication is AuthenticationAuthenticated;
    final account = authenticated ? ref.watch(accountProvider) : null;
    final passkey = authenticated ? ref.watch(passkeyProvider) : null;
    final cacheSize = ref.watch(cacheSizeProvider);
    final clearingCache = ref.watch(cacheCommandProvider).isLoading;
    final installedAppInfo = ref.watch(installedAppInfoProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    final checkingForUpdate = ref.watch(appUpdateCommandProvider).isLoading;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const _SettingsHeader(),
            const SizedBox(height: 16),
            Expanded(
              child: account == null
                  ? _SettingsContent(
                      language:
                          (ref.watch(appLocaleProvider) ??
                                  Localizations.localeOf(context))
                              .languageCode,
                      onLanguage: () => _showLanguageSheet(
                        context,
                        (ref.read(appLocaleProvider) ??
                                Localizations.localeOf(context))
                            .languageCode,
                      ),
                      themeMode: themeMode,
                      onDisplayMode: () =>
                          _showDisplayModeSheet(context, ref, themeMode),
                      appVersion: switch (installedAppInfo) {
                        AsyncData(:final value) => 'v${value.version}',
                        _ => '...',
                      },
                      checkingForUpdate: checkingForUpdate,
                      onCheckForUpdates: () => _checkForUpdates(context, ref),
                      cacheSizeBytes: cacheSize.value,
                      clearingCache: clearingCache,
                      onClearCache: () =>
                          ref.read(cacheCommandProvider.notifier).clear(),
                    )
                  : account.when(
                      loading: () => DesignStateFeedback(
                        state: DesignState.loading,
                        title: AppLocalizations.of(context).settingsLoading,
                      ),
                      error: (error, _) => DesignStateFeedback(
                        error: error,
                        state: DesignState.failure,
                        title: AppLocalizations.of(context).settingsUnavailable,
                        message: AppLocalizations.of(context).settingsRetry,
                        onRetry: () => ref.refresh(accountProvider.future),
                      ),
                      data: (account) => _SettingsContent(
                        avatarUri: account.avatarUri,
                        name: accountDisplayName(
                          account,
                          identityDisplayName: switch (authentication) {
                            AuthenticationAuthenticated(:final principal) =>
                              principal.displayName,
                            _ => null,
                          },
                        ),
                        language:
                            ref.watch(appLocaleProvider)?.languageCode ??
                            account.settings.language,
                        passkey: _passkeyValue(passkey!),
                        passkeyLoading: passkey.isLoading,
                        onPasskey: () => _showPasskeySheet(
                          context,
                          ref,
                          _passkeyValue(passkey),
                        ),
                        onLanguage: () => _showLanguageSheet(
                          context,
                          ref.read(appLocaleProvider)?.languageCode ??
                              account.settings.language,
                        ),
                        themeMode: themeMode,
                        onDisplayMode: () =>
                            _showDisplayModeSheet(context, ref, themeMode),
                        onPrivateKey: () =>
                            _showPrivateKeyWarning(context, ref),
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
      barrierColor: context.appColors.overlayScrim.withValues(alpha: 0.44),
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

  Future<void> _showLanguageSheet(BuildContext context, String current) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        barrierColor: context.appColors.overlayScrim.withValues(alpha: 0.44),
        builder: (_) => _LanguageSheet(current: current),
      );

  Future<void> _showDisplayModeSheet(
    BuildContext context,
    WidgetRef ref,
    ThemeMode current,
  ) async {
    final selected = await showModalBottomSheet<ThemeMode>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: context.appColors.overlayScrim.withValues(alpha: 0.44),
      builder: (_) => _DisplayModeSheet(current: current),
    );
    if (selected == null || selected == current) return;
    await ref.read(appThemeModeProvider.notifier).setMode(selected);
  }

  void _showPrivateKeyWarning(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: context.appColors.overlayScrim.withValues(alpha: 0.44),
      builder: (_) => PrivateKeyExportSheet(
        configuration: ref.read(privyConfigurationProvider),
      ),
    );
  }

  void _showLogOutConfirmation(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    var loggingOut = false;
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => StatefulBuilder(
        builder: (sheetContext, setSheetState) => _NoticeSheet(
          title: l10n.settingsLogOut,
          message: l10n.settingsLogOutQuestion,
          actions: [
            OutlinedButton(
              onPressed: loggingOut
                  ? null
                  : () => Navigator.of(sheetContext).pop(),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              key: const Key('settings-logout-confirm'),
              onPressed: loggingOut
                  ? null
                  : () async {
                      if (loggingOut) return;
                      loggingOut = true;
                      setSheetState(() {});
                      try {
                        await ref
                            .read(authenticationProvider.notifier)
                            .logout();
                        if (sheetContext.mounted) {
                          Navigator.of(sheetContext).pop();
                        }
                        final router = context.mounted
                            ? GoRouter.maybeOf(context)
                            : null;
                        if (router != null) {
                          router.goNamed(AppRoutes.homeName);
                        }
                      } finally {
                        if (sheetContext.mounted) {
                          loggingOut = false;
                          setSheetState(() {});
                        }
                      }
                    },
              child: loggingOut
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(
                        key: Key('settings-logout-progress'),
                        strokeWidth: 2,
                      ),
                    )
                  : Text(l10n.settingsLogOut),
            ),
          ],
        ),
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
                      child: CircularProgressIndicator(strokeWidth: 2),
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
  Widget build(BuildContext context) => AppPageHeader(
    title: AppLocalizations.of(context).settingsTitle,
    padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
  );
}

class _SettingsContent extends StatelessWidget {
  const _SettingsContent({
    this.avatarUri,
    this.name,
    required this.language,
    this.passkey,
    this.passkeyLoading = false,
    this.onPasskey,
    required this.onLanguage,
    required this.themeMode,
    required this.onDisplayMode,
    this.onPrivateKey,
    required this.appVersion,
    required this.checkingForUpdate,
    required this.onCheckForUpdates,
    required this.cacheSizeBytes,
    required this.clearingCache,
    required this.onClearCache,
    this.onLogOut,
    this.onDeleteAccount,
  });

  final String? name;
  final Uri? avatarUri;
  final String language;
  final PasskeyCredential? passkey;
  final bool passkeyLoading;
  final VoidCallback? onPasskey;
  final VoidCallback onLanguage;
  final ThemeMode themeMode;
  final VoidCallback onDisplayMode;
  final VoidCallback? onPrivateKey;
  final String appVersion;
  final bool checkingForUpdate;
  final VoidCallback onCheckForUpdates;
  final int? cacheSizeBytes;
  final bool clearingCache;
  final VoidCallback onClearCache;
  final VoidCallback? onLogOut;
  final VoidCallback? onDeleteAccount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final guest = name == null;
    final rowHeight = guest ? 56.0 : 70.0;
    Widget card(List<Widget> rows) => _Card(
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) const Divider(height: 1, indent: 16, endIndent: 16),
            rows[i],
          ],
        ],
      ),
    );
    final groups = <Widget>[
      if (guest)
        const _GuestAccountCard()
      else ...[
        _Card(
          child: _AccountRow(name: name!, avatarUri: avatarUri),
        ),
        _Card(
          child: _PasskeyRow(
            passkey: passkey,
            loading: passkeyLoading,
            onTap: onPasskey!,
          ),
        ),
      ],
      card([
        _SettingRow(
          asset: 'assets/figma/account_activity/language.svg',
          label: l10n.settingsLanguage,
          trailing: _ValueWithChevron(label: _languageLabel(l10n, language)),
          trailingBelowAtLargeText: true,
          onTap: onLanguage,
          height: rowHeight,
        ),
        _SettingRow(
          asset: 'assets/figma/account_activity/display_mode.svg',
          label: l10n.settingsDisplayMode,
          trailing: _ValueWithChevron(
            label: _displayModeLabel(l10n, themeMode),
          ),
          trailingBelowAtLargeText: true,
          onTap: onDisplayMode,
          height: rowHeight,
        ),
        if (!guest)
          _SettingRow(
            asset: 'assets/figma/account_activity/private_key.svg',
            label: l10n.settingsExportPrivateKey,
            trailing: const _ChevronRight(),
            onTap: onPrivateKey,
          ),
      ]),
      // Legal and app preferences are available without an account.
      if (guest) card(_legalRows(context, rowHeight)),
      card([
        _SettingRow(
          asset: 'assets/figma/account_activity/update.svg',
          label: l10n.settingsCheckUpdates,
          value: checkingForUpdate ? '...' : 'Check',
          onTap: checkingForUpdate ? null : onCheckForUpdates,
          height: rowHeight,
        ),
        _SettingRow(
          asset: 'assets/figma/account_activity/version.svg',
          label: l10n.settingsAppVersion,
          value: appVersion,
          height: rowHeight,
        ),
        _SettingRow(
          asset: 'assets/figma/account_activity/cache.svg',
          label: l10n.settingsCacheSize,
          trailing: _CacheSizeValue(
            bytes: cacheSizeBytes,
            clearing: clearingCache,
            onClear: onClearCache,
          ),
          trailingBelowAtLargeText: true,
          height: rowHeight,
        ),
        if (!guest) ..._legalRows(context, rowHeight),
      ]),
      if (!guest)
        card([
          _SettingRow(
            asset: 'assets/figma/account_activity/logout.svg',
            label: l10n.settingsLogOut,
            labelColor: Theme.of(context)
                .extension<AppSemanticColors>()!
                .danger,
            onTap: onLogOut,
          ),
          _SettingRow(
            asset: 'assets/figma/account_activity/delete_account.svg',
            label: l10n.settingsDeleteAccount,
            trailing: const _ChevronRight(),
            onTap: onDeleteAccount,
          ),
        ]),
    ];
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      children: [
        for (var i = 0; i < groups.length; i++) ...[
          if (i > 0) SizedBox(height: guest ? 12 : 16),
          groups[i],
        ],
      ],
    );
  }

  List<Widget> _legalRows(BuildContext context, double height) => [
    _SettingRow(
      asset: 'assets/figma/account_activity/terms_conditions.svg',
      label: AppLocalizations.of(context).settingsTermsConditions,
      trailing: const _ChevronRight(),
      height: height,
      onTap: () => context.pushNamed(AppRoutes.termsName),
    ),
    _SettingRow(
      asset: 'assets/figma/account_activity/privacy_policy.svg',
      label: AppLocalizations.of(context).settingsPrivacyPolicy,
      trailing: const _ChevronRight(),
      height: height,
      onTap: () => context.pushNamed(AppRoutes.privacyName),
    ),
  ];
}

class _GuestAccountCard extends StatelessWidget {
  const _GuestAccountCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.appColors;
    final enlargedText = MediaQuery.textScalerOf(context).scale(14) > 18;
    final description = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.settingsYourAccount,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 16,
            height: 22 / 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.settingsLoginToManageAccount,
          style: TextStyle(
            color: colors.textSecondary,
            fontSize: 12,
            height: 16 / 12,
          ),
        ),
      ],
    );
    final login = FilledButton(
      onPressed: () => pushLoginScreen(context),
      style: FilledButton.styleFrom(
        minimumSize: const Size(76, 40),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Text(l10n.logIn),
    );
    return _Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: enlargedText
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [description, const SizedBox(height: 12), login],
              )
            : Row(
                children: [
                  Expanded(child: description),
                  const SizedBox(width: 12),
                  login,
                ],
              ),
      ),
    );
  }
}

String _languageLabel(AppLocalizations l10n, String language) =>
    switch (language) {
      'zh-CN' || 'zh' => l10n.languageSimplifiedChinese,
      _ => l10n.languageEnglish,
    };

String _displayModeLabel(AppLocalizations l10n, ThemeMode mode) =>
    switch (mode) {
      ThemeMode.light => l10n.displayModeLight,
      ThemeMode.dark => l10n.displayModeDark,
      ThemeMode.system => l10n.displayModeSystem,
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
    this.height = 70,
  });
  final String asset;
  final String label;
  final String? value;
  final Widget? trailing;
  final Color? labelColor;
  final VoidCallback? onTap;
  final bool trailingBelowAtLargeText;
  final double height;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final foreground = labelColor ?? colors.textPrimary;
    final iconWidget = AppSvgIcon(
      asset,
      width: 24,
      height: 24,
      color: foreground,
    );
    final valueStyle = TextStyle(
      color: colors.textSecondary,
      fontSize: 15,
      height: 22 / 15,
      fontWeight: FontWeight.w500,
    );
    final labelStyle = TextStyle(
      color: foreground,
      fontSize: 15,
      height: 22 / 15,
      fontWeight: FontWeight.w600,
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        final enlargedText = MediaQuery.textScalerOf(context).scale(14) > 18;
        // Values and actions get a second line when space is limited, so
        // they remain readable and tappable.
        final stackContent =
            enlargedText ||
            (trailingBelowAtLargeText && constraints.maxWidth < 320);
        if (stackContent) {
          return InkWell(
            onTap: onTap,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 70),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
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
            height: height,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: height == 56 ? 8 : 12,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Center(child: iconWidget),
                  ),
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
      },
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
              color: colors.textSecondary,
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
                  child: AppSvgIcon(
                    'assets/figma/account_activity/passkey.svg',
                    color: context.appColors.iconPrimary,
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
                        color: colors.textSecondary,
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
    } on Object catch (error) {
      if (mounted) {
        AppToast.showFailure(
          context,
          errorMessage(
            error,
            fallback: widget.passkey == null
                ? AppLocalizations.of(context).settingsPasskeySetupFailed
                : AppLocalizations.of(context).settingsPasskeyRemoveFailed,
          ),
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
      color: colors.surfaceBase,
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
                    color: colors.textSecondary.withValues(alpha: 0.45),
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
                  color: colors.textSecondary,
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
                              backgroundColor: context.semanticColors.danger,
                            )
                          : null,
                      child: _submitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
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
                        backgroundColor: colors.surfaceSubtle,
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
  const _AccountRow({required this.name, required this.avatarUri});

  final String name;
  final Uri? avatarUri;

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
                border: Border.all(color: colors.borderSubtle),
                shape: BoxShape.circle,
              ),
              child: AccountAvatar(
                key: const Key('settings-account-avatar'),
                avatarUri: avatarUri,
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
                      color: colors.textSecondary,
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
    child: AppSvgIcon(
      'assets/figma/account_activity/chevron_right.svg',
      color: context.appColors.iconSecondary,
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
      color: colors.textSecondary,
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
            foregroundColor: colors.textSecondary,
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
    required this.actions,
  });

  final String title;
  final String message;
  final List<Widget> actions;

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
                  color: Theme.of(context)
                      .extension<AppRwaColors>()!
                      .borderSubtle,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text(message),
            const SizedBox(height: 24),
            Row(
              children: [
                for (final action in actions) ...[
                  Expanded(child: SizedBox(height: 48, child: action)),
                  if (action != actions.last) const SizedBox(width: 12),
                ],
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class _DisplayModeSheet extends StatelessWidget {
  const _DisplayModeSheet({required this.current});

  final ThemeMode current;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = AppLocalizations.of(context);
    final options = <_DisplayModeOption>[
      _DisplayModeOption(
        mode: ThemeMode.light,
        asset: 'assets/figma/account_activity/display_mode_light.svg',
        title: l10n.displayModeLight,
        description: l10n.displayModeLightDescription,
      ),
      _DisplayModeOption(
        mode: ThemeMode.dark,
        asset: 'assets/figma/account_activity/display_mode_dark.svg',
        title: l10n.displayModeDark,
        description: l10n.displayModeDarkDescription,
      ),
      _DisplayModeOption(
        mode: ThemeMode.system,
        asset: 'assets/figma/account_activity/display_mode_system.svg',
        title: l10n.displayModeSystem,
        description: l10n.displayModeSystemDescription,
      ),
    ];
    return Material(
      color: colors.surfaceBase,
      clipBehavior: Clip.antiAlias,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.textSecondary.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.settingsDisplayMode,
                      style: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(letterSpacing: -0.2),
                    ),
                  ),
                  Semantics(
                    button: true,
                    label: MaterialLocalizations.of(context).closeButtonLabel,
                    child: InkWell(
                      key: const Key('display-mode-close'),
                      onTap: () => Navigator.of(context).pop(),
                      customBorder: const CircleBorder(),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: AppSvgIcon(
                          'assets/figma/account_activity/close.svg',
                          color: colors.iconPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(height: 1, color: colors.dividerSoft),
              const SizedBox(height: 16),
              for (var index = 0; index < options.length; index++) ...[
                _DisplayModeRow(
                  key: ValueKey(
                    'display-mode-option-${options[index].mode.name}',
                  ),
                  option: options[index],
                  selected: current == options[index].mode,
                  onTap: () => Navigator.of(context).pop(options[index].mode),
                ),
                if (index < options.length - 1)
                  // The design insets the separator to the option content.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(height: 1, color: colors.dividerSoft),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DisplayModeOption {
  const _DisplayModeOption({
    required this.mode,
    required this.asset,
    required this.title,
    required this.description,
  });

  final ThemeMode mode;
  final String asset;
  final String title;
  final String description;
}

/// One selectable display mode: icon tile, title/description and the check
/// indicator from the design.
class _DisplayModeRow extends StatelessWidget {
  const _DisplayModeRow({
    super.key,
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final _DisplayModeOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Semantics(
      button: true,
      selected: selected,
      label: option.title,
      hint: option.description,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: selected ? colors.surfaceSubtle : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colors.surfaceBase,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: AppSvgIcon(
                  option.asset,
                  width: 20,
                  height: 20,
                  color: colors.iconPrimary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      option.description,
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: colors.textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _DisplayModeCheck(
                selected: selected,
                backgroundColor: colors.actionPrimary,
                foregroundColor: colors.textInverse,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The 20px radio chip from the design: filled with the primary action colour
/// and a check mark when selected, invisible otherwise.
class _DisplayModeCheck extends StatelessWidget {
  const _DisplayModeCheck({
    required this.selected,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final bool selected;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) => AnimatedOpacity(
    duration: const Duration(milliseconds: 120),
    opacity: selected ? 1 : 0,
    child: Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: AppSvgIcon(
        'assets/figma/account_activity/display_mode_check.svg',
        width: 14.286,
        height: 14.286,
        color: foregroundColor,
      ),
    ),
  );
}

/// A right-aligned setting value followed by the chevron that opens its sheet.
class _ValueWithChevron extends StatelessWidget {
  const _ValueWithChevron({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: context.appColors.textSecondary,
      fontSize: 15,
      height: 22 / 15,
      fontWeight: FontWeight.w500,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 160),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style,
            textHeightBehavior: const TextHeightBehavior(
              applyHeightToFirstAscent: false,
              applyHeightToLastDescent: false,
              leadingDistribution: TextLeadingDistribution.even,
            ),
          ),
        ),
        const SizedBox(width: 4),
        const _ChevronRight(),
      ],
    );
  }
}

class _LanguageSheet extends ConsumerStatefulWidget {
  const _LanguageSheet({required this.current});

  final String current;

  @override
  ConsumerState<_LanguageSheet> createState() => _LanguageSheetState();
}

class _LanguageSheetState extends ConsumerState<_LanguageSheet> {
  late var _selected = widget.current == 'zh' ? 'zh-CN' : widget.current;

  var _submitting = false;
  Object? _error;

  Future<void> _submit() async {
    if (_submitting) return;
    if (localeFromLanguageCode(_selected) ==
        localeFromLanguageCode(widget.current)) {
      Navigator.of(context).pop();
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      if (ref.read(authenticationProvider) is! AuthenticationAuthenticated) {
        ref.read(appLocaleProvider.notifier).setGuestLanguage(_selected);
      } else {
        await ref
            .read(settingsCommandProvider.notifier)
            .updateSettings(UserPreferencesPatch(language: _selected));
        if (!mounted) return;
        final result = ref.read(settingsCommandProvider);
        if (result.hasError) throw result.error!;
        ref.read(appLocaleProvider.notifier).setLanguage(_selected);
      }
      if (mounted) Navigator.of(context).pop();
    } on Object catch (error) {
      if (mounted) setState(() => _error = error);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  static const _languages = <({String code, String label})>[
    (code: 'en', label: 'English'),
    (code: 'zh-CN', label: '中文 (Chinese)'),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return PopScope(
      canPop: !_submitting,
      child: Material(
        color: colors.surfaceBase,
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
                      color: colors.textSecondary.withValues(alpha: 0.45),
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
                    onTap: _submitting
                        ? null
                        : () => setState(
                            () => _selected = _languages[index].code,
                          ),
                  ),
                  if (index < _languages.length - 1)
                    Divider(color: colors.surfaceSubtle, height: 1),
                ],
                if (_error case final error?) ...[
                  const SizedBox(height: 12),
                  Text(
                    errorMessage(
                      error,
                      fallback: AppLocalizations.of(context)
                          .settingsLanguageSaveFailed,
                    ),
                    style: TextStyle(color: context.semanticColors.danger),
                  ),
                ],
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton(
                    key: const Key('settings-language-confirm'),
                    onPressed: _submitting ? null : _submit,
                    child: _submitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(AppLocalizations.of(context).confirm),
                  ),
                ),
              ],
            ),
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
  final VoidCallback? onTap;

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
                  color: selected ? colors.actionPrimary : colors.surfaceSubtle,
                  shape: BoxShape.circle,
                  border: selected
                      ? null
                      : Border.all(
                          color: colors.borderSubtle.withValues(alpha: 0.7),
                        ),
                ),
                child: selected
                    ? Icon(Icons.check, size: 14, color: colors.textInverse)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
