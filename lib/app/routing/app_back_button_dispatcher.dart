import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// go_router 18.x reads matches.last during system back even when the initial
/// redirect is pending or an unmatched URL produces an empty error match list.
/// Keep this compatibility guard until the upstream delegate handles emptiness.
final class AppBackButtonDispatcher extends RootBackButtonDispatcher {
  AppBackButtonDispatcher(this._router);

  // Read the current router so replacing AppRoot.router cannot leave the
  // dispatcher attached to an old delegate.
  final GoRouter Function() _router;

  @override
  Future<bool> invokeCallback(Future<bool> defaultValue) {
    final delegate = _router().routerDelegate;
    if (delegate.currentConfiguration.isEmpty) {
      // Error pages can still have pageless dialogs above them. Let Navigator
      // dismiss those before returning false to the platform at the root.
      return delegate.navigatorKey.currentState?.maybePop() ?? defaultValue;
    }
    return super.invokeCallback(defaultValue);
  }
}
