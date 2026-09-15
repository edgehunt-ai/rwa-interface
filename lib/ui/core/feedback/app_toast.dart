import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AppToastType { success, failure }

/// A transient, application-level status message displayed at the top of the
/// current route.
abstract final class AppToast {
  static OverlayEntry? _currentEntry;

  static void showSuccess(BuildContext context, String message) =>
      _show(context, message, AppToastType.success);

  static void showFailure(BuildContext context, String message) =>
      _show(context, message, AppToastType.failure);

  static void dismiss() {
    _currentEntry?.remove();
    _currentEntry = null;
  }

  static void _show(BuildContext context, String message, AppToastType type) {
    final overlay = Overlay.of(context, rootOverlay: true);
    dismiss();

    final entry = OverlayEntry(
      builder: (context) => _AppToastMessage(message: message, type: type),
    );
    _currentEntry = entry;
    overlay.insert(entry);
  }
}

class _AppToastMessage extends StatefulWidget {
  const _AppToastMessage({required this.message, required this.type});

  final String message;
  final AppToastType type;

  @override
  State<_AppToastMessage> createState() => _AppToastMessageState();
}

class _AppToastMessageState extends State<_AppToastMessage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _dismissController;

  @override
  void initState() {
    super.initState();
    _dismissController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) AppToast.dismiss();
          });
    _dismissController.forward();
  }

  @override
  void dispose() {
    _dismissController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSuccess = widget.type == AppToastType.success;
    return Positioned(
      top: MediaQuery.paddingOf(context).top + 20,
      left: 16,
      right: 16,
      child: Center(
        child: Semantics(
          liveRegion: true,
          label: widget.message,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 313,
              constraints: const BoxConstraints(minHeight: 44),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xCC1D1D24),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    isSuccess
                        ? 'assets/figma/trade/order_success_toast.svg'
                        : 'assets/figma/trade/order_failed.svg',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
