import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rwa_interface/app/config/privy_configuration.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/feedback/app_toast.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivateKeyExportSheet extends StatefulWidget {
  const PrivateKeyExportSheet({required this.configuration, super.key});

  final PrivyConfiguration configuration;

  @override
  State<PrivateKeyExportSheet> createState() => _PrivateKeyExportSheetState();
}

class _PrivateKeyExportSheetState extends State<PrivateKeyExportSheet> {
  WebViewController? _controller;
  var _showingWebView = false;
  var _loading = true;

  bool get _supportsWebView =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  Future<void> _continue() async {
    final l10n = AppLocalizations.of(context);
    if (!_supportsWebView) {
      Navigator.of(context).pop();
      AppToast.showFailure(context, l10n.privyPlatformUnsupported);
      return;
    }

    final appId = widget.configuration.appId.trim();
    final clientId = widget.configuration.clientId.trim();
    final baseUri = Uri.tryParse(PrivyConfiguration.privateKeyExportUrl);
    if (appId.isEmpty ||
        clientId.isEmpty ||
        baseUri == null ||
        baseUri.scheme != 'https') {
      Navigator.of(context).pop();
      AppToast.showFailure(context, l10n.privyNotConfigured);
      return;
    }

    final exportUri = baseUri.replace(
      queryParameters: {
        ...baseUri.queryParameters,
        'appId': appId,
        'clientId': clientId,
      },
    );
    final allowedOrigin = '${exportUri.scheme}://${exportUri.authority}';
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Theme.of(context).colorScheme.surface)
      ..addJavaScriptChannel(
        'RwaPrivateKeyExport',
        onMessageReceived: _handleMessage,
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) setState(() => _loading = false);
          },
          onWebResourceError: (error) {
            if (error.isForMainFrame != true || !mounted) return;
            setState(() => _loading = false);
            AppToast.showFailure(context, l10n.privyUnavailable);
          },
          onNavigationRequest: (request) {
            final uri = Uri.tryParse(request.url);
            if (uri == null) return NavigationDecision.prevent;
            final origin = '${uri.scheme}://${uri.authority}';
            return origin == allowedOrigin ||
                    uri.host.endsWith('.privy.io') ||
                    uri.host.endsWith('.privy.systems')
                ? NavigationDecision.navigate
                : NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(exportUri);

    setState(() {
      _controller = controller;
      _showingWebView = true;
      _loading = true;
    });
  }

  void _handleMessage(JavaScriptMessage message) {
    if (!mounted) return;
    final payload = tryDecode(message.message);
    if (payload is! Map<String, dynamic>) return;
    switch (payload['type']) {
      case 'close':
      case 'complete':
        Navigator.of(context).pop();
      case 'error':
        setState(() => _loading = false);
        AppToast.showFailure(
          context,
          AppLocalizations.of(context).privyUnavailable,
        );
    }
  }

  dynamic tryDecode(String value) {
    try {
      return jsonDecode(value);
    } on FormatException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final height = MediaQuery.sizeOf(context).height * 0.86;
    return Material(
      color: colors.surface,
      clipBehavior: Clip.antiAlias,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        top: false,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          height: _showingWebView ? height : null,
          child: _showingWebView ? _buildWebView() : _buildWarning(),
        ),
      ),
    );
  }

  Widget _buildWarning() {
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: _handle()),
          const SizedBox(height: 16),
          Text(
            l10n.settingsExportPrivateKey,
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
          Text(l10n.settingsPrivateKeyWarning),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: FilledButton(
              onPressed: _continue,
              child: Text(l10n.confirm),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWebView() => Column(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Row(
          children: [
            IconButton(
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onPressed: () => setState(() => _showingWebView = false),
              icon: const Icon(Icons.arrow_back),
            ),
            Expanded(
              child: Text(
                AppLocalizations.of(context).settingsExportPrivateKey,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            IconButton(
              tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
      const Divider(height: 1),
      Expanded(
        child: Stack(
          children: [
            if (_controller case final controller?)
              WebViewWidget(controller: controller),
            if (_loading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    ],
  );

  Widget _handle() => Container(
    width: 32,
    height: 4,
    decoration: BoxDecoration(
      color: Theme.of(context).extension<AppRwaColors>()!.border,
      borderRadius: BorderRadius.circular(2),
    ),
  );
}
