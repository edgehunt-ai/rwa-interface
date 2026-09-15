import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

import '../../../../app/routing/routes.dart';
import '../../../../app/providers/auth_providers.dart';
import '../../../../domain/auth/authentication.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/feedback/app_toast.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/authentication_provider.dart';

/// Pushes the login screen on top of the current page. On success it pops
/// itself (see the `ref.listen` in [PrivyLoginScreen]), returning the caller
/// to whatever page requested the login.
Future<void> pushLoginScreen(BuildContext context) => Navigator.of(context)
    .push(
      MaterialPageRoute<void>(
        builder: (_) => Consumer(
          builder: (context, ref, _) => PrivyLoginScreen(
            authentication: ref.watch(authenticationProvider),
          ),
        ),
      ),
    );

/// Guards an authenticated-only action: pushes the login screen when the
/// user isn't signed in yet and reports whether they ended up authenticated,
/// so the caller can go ahead with the action right after a successful login.
Future<bool> requireAuthentication(BuildContext context, WidgetRef ref) async {
  if (ref.read(authenticationProvider) is AuthenticationAuthenticated) {
    return true;
  }
  await pushLoginScreen(context);
  if (!context.mounted) return false;
  return ref.read(authenticationProvider) is AuthenticationAuthenticated;
}

/// Startup gate for the native Privy email authentication flow.
///
/// The application does not create data providers until Privy has returned an
/// access token and the backend product session has been established.
class PrivyLoginScreen extends ConsumerStatefulWidget {
  const PrivyLoginScreen({
    required this.authentication,
    this.returnToHomeOnSuccess = false,
    super.key,
  });

  final AuthenticationState authentication;
  final bool returnToHomeOnSuccess;

  @override
  ConsumerState<PrivyLoginScreen> createState() => _PrivyLoginScreenState();
}

class _PrivyLoginScreenState extends ConsumerState<PrivyLoginScreen> {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  bool _emailFlow = false;
  bool _showEmailFormatError = false;
  String? _recentMethod;
  String? _scheduledEmailSync;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      if (mounted) {
        setState(() => _recentMethod = prefs.getString('recent_login_method'));
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _sendCode() {
    if (!_hasValidEmail) {
      setState(() => _showEmailFormatError = true);
      return Future.value();
    }
    if (_showEmailFormatError) {
      setState(() => _showEmailFormatError = false);
    }
    return ref
        .read(authenticationProvider.notifier)
        .requestEmailCode(_emailController.text);
  }

  Future<void> _resendCode() async {
    _codeController.clear();
    await _sendCode();
    if (!mounted) return;
    if (ref.read(authenticationProvider) case AuthenticationAwaitingCode(
      failure: null,
    )) {
      AppToast.showSuccess(context, AppLocalizations.of(context).codeResent);
    }
  }

  bool get _hasValidEmail => _emailPattern.hasMatch(_emailController.text);

  void _onEmailChanged(String _) {
    if (_showEmailFormatError && _hasValidEmail) {
      setState(() => _showEmailFormatError = false);
      return;
    }
    setState(() {});
  }

  void _beginEmailLogin() {
    if (_emailFlow) return;
    setState(() => _emailFlow = true);
  }

  Future<void> _verifyCode() async {
    await ref
        .read(authenticationProvider.notifier)
        .verifyEmailCode(_codeController.text);
    if (ref.read(authenticationProvider) is AuthenticationAuthenticated) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('recent_login_method', 'Email');
    }
  }

  Future<void> _loginWith(String method) async {
    final notifier = ref.read(authenticationProvider.notifier);
    if (method == 'Passkey') {
      await notifier.loginWithPasskey();
    } else {
      await notifier.loginWithOAuth(method.toLowerCase());
    }
    if (!mounted ||
        ref.read(authenticationProvider) is! AuthenticationAuthenticated) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('recent_login_method', method);
    if (mounted) setState(() => _recentMethod = method);
  }

  Future<void> _loginOnWeb() async {
    await ref.read(authenticationProvider.notifier).login();
    if (!mounted ||
        ref.read(authenticationProvider) is! AuthenticationAuthenticated) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('recent_login_method', 'Privy');
    if (mounted) setState(() => _recentMethod = 'Privy');
  }

  Future<void> _loginWithWallet(BuildContext context) async {
    await ref
        .read(authenticationProvider.notifier)
        .loginWithWallet(
          () => ref.read(reownWalletConnectorProvider).connect(context),
        );
    if (!mounted ||
        ref.read(authenticationProvider) is! AuthenticationAuthenticated) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('recent_login_method', 'Wallet');
    if (mounted) setState(() => _recentMethod = 'Wallet');
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthenticationState>(authenticationProvider, (previous, next) {
      if (next is AuthenticationAuthenticated && mounted) {
        if (widget.returnToHomeOnSuccess) {
          context.goNamed(AppRoutes.homeName);
        } else {
          Navigator.of(context).maybePop();
        }
      }
    });
    final state = widget.authentication;
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final waitingForCode = state is AuthenticationAwaitingCode;
    final busy =
        state is AuthenticationInitializing ||
        state is AuthenticationAuthenticating;
    final failure = switch (state) {
      AuthenticationUnauthenticated(:final failure) => failure,
      AuthenticationAwaitingCode(:final failure) => failure,
      AuthenticationFailed(:final failure) => failure,
      AuthenticationUnsupported(:final failure) => failure,
      _ => null,
    };

    // Updating a TextEditingController from build makes EditableText mark
    // itself dirty while the widget tree is being built. In the OTP transition
    // that can cause a rebuild assertion or a render loop. Synchronize it once
    // after this frame instead.
    if (waitingForCode &&
        _emailController.text != state.email &&
        _scheduledEmailSync != state.email) {
      _scheduledEmailSync = state.email;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || _scheduledEmailSync != state.email) return;
        _emailController.value = TextEditingValue(
          text: state.email,
          selection: TextSelection.collapsed(offset: state.email.length),
        );
        _scheduledEmailSync = null;
      });
    }

    final showEmailInput = _emailFlow && !waitingForCode;
    final showApple = switch (defaultTargetPlatform) {
      TargetPlatform.iOS || TargetPlatform.macOS => true,
      _ => false,
    };
    return PopScope<void>(
      canPop: !waitingForCode,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop || !waitingForCode) return;
        _codeController.clear();
        ref.read(authenticationProvider.notifier).cancelEmailCode();
      },
      child: Scaffold(
        body: Stack(
          children: [
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFF7F7FA),
                      Color(0xFFF7F7FA),
                      Color(0xFFFFB5F2),
                    ],
                    stops: [0, .53, 1],
                  ),
                ),
              ),
            ),
            // The reference uses a saturated pink glow behind the legal copy.
            // Keeping it in the background preserves the white text contrast
            // while allowing the form itself to scroll on smaller devices.
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 300,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0, .9),
                    radius: 1.05,
                    colors: [Color(0xFFE96BD5), Color(0x00FFE0FA)],
                    stops: [0, .9],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(28, 48, 28, 132),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 393),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF6FDB),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          waitingForCode
                              ? l10n.enterConfirmationCode
                              : l10n.signUpOrLogIn,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: Colors.black,
                                fontSize: 20,
                                height: 27 / 20,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        if (waitingForCode) ...[
                          const SizedBox(height: 8),
                          Text(
                            l10n.emailCodeSent(state.email),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: colors.secondaryText),
                          ),
                        ],
                        const SizedBox(height: 48),
                        if (busy) ...[
                          const SizedBox(height: 120),
                          const Center(
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(strokeWidth: 3),
                            ),
                          ),
                          const SizedBox(height: 120),
                        ] else if (waitingForCode) ...[
                          _VerificationCodeInput(
                            controller: _codeController,
                            onChanged: (value) {
                              if (value.length == 6) _verifyCode();
                            },
                            onSubmitted: (_) => _verifyCode(),
                          ),
                          const SizedBox(height: 28),
                          Text(
                            l10n.didntGetEmail,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: const Color(0xFF676776)),
                          ),
                          TextButton(
                            onPressed: _resendCode,
                            child: Text(l10n.resendCode),
                          ),
                        ] else if (kIsWeb) ...[
                          _LoginOption(
                            asset: 'assets/figma/session/email.svg',
                            label: l10n.continueWithPrivy,
                            badge: _recentMethod == 'Privy'
                                ? l10n.recent
                                : null,
                            onTap: _loginOnWeb,
                          ),
                        ] else ...[
                          _EmailLoginOption(
                            controller: _emailController,
                            editing: showEmailInput,
                            recent: _recentMethod == 'Email',
                            onTap: _beginEmailLogin,
                            onChanged: _onEmailChanged,
                            onSubmitted: (_) => _sendCode(),
                            emailFormatError:
                                _showEmailFormatError && !_hasValidEmail,
                            onSend: _emailController.text.trim().isEmpty
                                ? null
                                : _sendCode,
                          ),
                          if (_showEmailFormatError && !_hasValidEmail)
                            Padding(
                              padding: EdgeInsets.only(left: 16, bottom: 12),
                              child: Text(
                                l10n.enterValidEmail,
                                style: TextStyle(
                                  color: Color(0xFFB42318),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          _LoginOption(
                            asset: 'assets/figma/session/google.svg',
                            label: 'Google',
                            badge: _recentMethod == 'Google'
                                ? l10n.recent
                                : null,
                            onTap: busy ? null : () => _loginWith('Google'),
                          ),
                          if (showApple)
                            _LoginOption(
                              asset: 'assets/figma/session/apple.svg',
                              label: 'Apple',
                              badge: _recentMethod == 'Apple'
                                  ? l10n.recent
                                  : null,
                              onTap: busy ? null : () => _loginWith('Apple'),
                            ),
                          _LoginOption(
                            asset: 'assets/figma/session/other_socials.svg',
                            label: l10n.otherSocials,
                            onTap: () => _showOtherSocials(context),
                          ),
                          _LoginOption(
                            asset: 'assets/figma/session/wallet.svg',
                            label: l10n.wallet,
                            badge: _recentMethod == 'Wallet'
                                ? l10n.recent
                                : null,
                            onTap: busy
                                ? null
                                : () => _loginWithWallet(context),
                          ),
                        ],
                        if (failure != null) ...[
                          const SizedBox(height: 16),
                          _LoginFailure(failure: failure),
                        ],
                        if (state is AuthenticationFailed ||
                            state is AuthenticationUnsupported) ...[
                          const SizedBox(height: 12),
                          OutlinedButton(
                            onPressed: busy
                                ? null
                                : () => ref
                                      .read(authenticationProvider.notifier)
                                      .bootstrap(),
                            child: Text(l10n.retry),
                          ),
                        ],
                        if (!waitingForCode && !kIsWeb && !busy) ...[
                          const SizedBox(height: 0),
                          SizedBox(
                            height: 30,
                            child: Center(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: busy
                                    ? null
                                    : () => _loginWith('Passkey'),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 6,
                                  ),
                                  child: Text(
                                    'Sign in with Passkey',
                                    style: TextStyle(
                                      color: Color(0xFF1D1D24),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      height: 18 / 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(28, 0, 28, 48),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/figma/session/protected_by_privy.svg',
                          width: 150,
                          height: 13,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.termsAgreement,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Colors.white,
                                shadows: const [
                                  Shadow(
                                    color: Color(0x33000000),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                        ),
                      ],
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

  Future<void> _showOtherSocials(BuildContext context) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        barrierColor: const Color(0x70111215),
        backgroundColor: Colors.transparent,
        builder: (sheetContext) => _OtherSocialsSheet(
          onTelegram: () {
            Navigator.of(sheetContext).pop();
            _loginWith('Telegram');
          },
          onTwitter: () {
            Navigator.of(sheetContext).pop();
            _loginWith('Twitter');
          },
        ),
      );
}

final _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

class _EmailLoginOption extends StatelessWidget {
  const _EmailLoginOption({
    required this.controller,
    required this.editing,
    required this.recent,
    required this.onTap,
    required this.onChanged,
    required this.onSubmitted,
    required this.emailFormatError,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool editing;
  final bool recent;
  final VoidCallback onTap;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final bool emailFormatError;
  final VoidCallback? onSend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        height: 48,
        child: Material(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(99),
            side: BorderSide(
              color: emailFormatError
                  ? const Color(0xFFB42318)
                  : editing
                  ? const Color(0xFF1D1D24)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 20,
                child: SvgPicture.asset(
                  'assets/figma/session/email.svg',
                  width: 20,
                  height: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 52, right: 52),
                child: TextField(
                  controller: controller,
                  autofocus: editing,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  textInputAction: TextInputAction.send,
                  onTap: onTap,
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF1D1D24),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'your@email.com',
                    hintStyle: TextStyle(
                      color: Color(0xFF9494A3),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
              if (editing && onSend != null)
                Positioned(
                  right: 12,
                  child: IconButton(
                    onPressed: onSend,
                    icon: const Icon(Icons.arrow_upward_rounded),
                    iconSize: 16,
                    color: Colors.white,
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFF1D1D24),
                      minimumSize: const Size(24, 24),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                )
              else if (!editing && recent)
                Positioned(right: 20, child: _RecentBadge()),
            ],
          ),
        ),
      ),
    );
  }
}

class _VerificationCodeInput extends StatefulWidget {
  const _VerificationCodeInput({
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;

  @override
  State<_VerificationCodeInput> createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<_VerificationCodeInput> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_refreshCells);
    _focusNode.addListener(_refreshCells);
  }

  @override
  void didUpdateWidget(covariant _VerificationCodeInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller == widget.controller) return;
    oldWidget.controller.removeListener(_refreshCells);
    widget.controller.addListener(_refreshCells);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_refreshCells);
    _focusNode.dispose();
    super.dispose();
  }

  void _refreshCells() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final digits = widget.controller.text
        .padRight(6)
        .split('')
        .take(6)
        .toList();
    final selectionOffset = widget.controller.selection.baseOffset;
    final activeIndex = selectionOffset < 0 ? 0 : selectionOffset.clamp(0, 5);
    return SizedBox(
      height: 56,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _requestFocus,
        child: Stack(
          children: [
            IgnorePointer(
              child: Row(
                children: List.generate(6, (index) {
                  final isActive = _focusNode.hasFocus && index == activeIndex;
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: index == 5 ? 0 : 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isActive
                              ? const Color(0xFF1D1D24)
                              : const Color(0xFFD9DBEC),
                          width: isActive ? 1.5 : 1,
                        ),
                      ),
                      child: Text(
                        digits[index].trim(),
                        style: const TextStyle(
                          color: Color(0xFF1D1D24),
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              autofocus: true,
              keyboardType: TextInputType.number,
              autofillHints: const [AutofillHints.oneTimeCode],
              textInputAction: TextInputAction.done,
              maxLength: 6,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              onTap: _requestFocus,
              // This is deliberately the only editable control. The cells above
              // render its value, so suppress the Material input decoration and
              // caret that would otherwise appear as a second large input box.
              style: const TextStyle(color: Colors.transparent, fontSize: 1),
              cursorColor: Colors.transparent,
              showCursor: false,
              decoration: const InputDecoration(
                counterText: '',
                isDense: true,
                filled: false,
                fillColor: Colors.transparent,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _requestFocus() => _focusNode.requestFocus();
}

class _RecentBadge extends StatelessWidget {
  const _RecentBadge();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: const Color(0xFFF1F1F5),
      borderRadius: BorderRadius.circular(10),
    ),
    child: const Text(
      'Recent',
      style: TextStyle(color: Color(0xFF676776), fontSize: 12),
    ),
  );
}

class _LoginOption extends StatelessWidget {
  const _LoginOption({
    required this.asset,
    required this.label,
    required this.onTap,
    this.badge,
  });
  final String asset;
  final String label;
  final String? badge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        height: 48,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(99),
          child: InkWell(
            borderRadius: BorderRadius.circular(99),
            onTap: onTap,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1D1D24),
                  ),
                ),
                Positioned(
                  left: 20,
                  child: SvgPicture.asset(asset, width: 20, height: 20),
                ),
                if (badge != null)
                  Positioned(
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F1F5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        badge!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF676776),
                        ),
                      ),
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

class _OtherSocialsSheet extends StatelessWidget {
  const _OtherSocialsSheet({required this.onTelegram, required this.onTwitter});

  final VoidCallback onTelegram;
  final VoidCallback onTwitter;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        decoration: BoxDecoration(
          color: colors.canvas,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.secondaryText.withValues(alpha: .45),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.loginOrSignUp,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: colors.primaryText,
                fontSize: 20,
                height: 26 / 20,
                fontWeight: FontWeight.w600,
                letterSpacing: -.2,
              ),
            ),
            const SizedBox(height: 16),
            _OtherSocialOption(
              label: 'Telegram',
              asset: 'assets/figma/session/telegram.svg',
              onTap: onTelegram,
            ),
            const SizedBox(height: 8),
            _OtherSocialOption(
              label: 'Twitter',
              asset: 'assets/figma/session/twitter.svg',
              onTap: onTwitter,
            ),
          ],
        ),
      ),
    );
  }
}

class _OtherSocialOption extends StatelessWidget {
  const _OtherSocialOption({
    required this.label,
    required this.asset,
    required this.onTap,
  });

  final String label;
  final String asset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 48,
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(99),
      child: InkWell(
        borderRadius: BorderRadius.circular(99),
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF1D1D24),
                fontSize: 15,
                height: 22 / 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Positioned(
              left: 20,
              child: SvgPicture.asset(asset, width: 20, height: 20),
            ),
          ],
        ),
      ),
    ),
  );
}

class _LoginFailure extends StatelessWidget {
  const _LoginFailure({required this.failure});

  final IdentityFailure failure;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final message = switch (failure.code) {
      AuthenticationFailureCode.invalidInput => l10n.enterValidEmail,
      AuthenticationFailureCode.invalidCode => l10n.invalidConfirmationCode,
      AuthenticationFailureCode.network => l10n.networkUnavailableRetry,
      AuthenticationFailureCode.browserUnavailable =>
        l10n.browserSignInUnavailable,
      AuthenticationFailureCode.configuration => l10n.privyNotConfigured,
      AuthenticationFailureCode.expired => l10n.sessionExpiredLogin,
      AuthenticationFailureCode.backendSession => l10n.backendSessionFailed,
      AuthenticationFailureCode.walletSync => l10n.walletSyncFailed,
      AuthenticationFailureCode.methodUnavailable => l10n.emailLoginUnavailable,
      AuthenticationFailureCode.unsupportedPlatform =>
        l10n.privyPlatformUnsupported,
      AuthenticationFailureCode.provider => l10n.privyUnavailable,
    };
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.selectedSoft,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: colors.primaryText),
          ),
          if (failure.requestId case final requestId?) ...[
            const SizedBox(height: 6),
            Text(
              l10n.supportId(requestId),
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: colors.secondaryText),
            ),
          ],
        ],
      ),
    );
  }
}
