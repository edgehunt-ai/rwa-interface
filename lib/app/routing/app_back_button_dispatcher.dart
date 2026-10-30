import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

/// go_router 18.x reads matches.last during system back even when the initial
/// redirect is pending or an unmatched URL produces an empty error match list.
/// Keep this compatibility guard until the upstream delegate handles emptiness.
final class AppBackButtonDispatcher extends RootBackButtonDispatcher {
  AppBackButtonDispatcher(this._router);

  // Read the current router so replacing AppRoot.router cannot leave the
  // dispatcher attached to an old delegate.
  final GoRouter Function() _router;

  /// Root secondary pages still have an in-app destination for system back.
  /// Android's predictive back must dispatch to Flutter for these pages too.
  bool get hasAppDestination {
    final router = _router();
    return router.routerDelegate.currentConfiguration.isEmpty ||
        router.routeInformationProvider.value.uri.path != AppRoutes.homePath;
  }

  @override
  Future<bool> invokeCallback(Future<bool> defaultValue) async {
    final router = _router();
    final delegate = router.routerDelegate;
    final configuration = delegate.currentConfiguration;
    if (configuration.isEmpty) {
      // Error pages can still have pageless dialogs above them. Let Navigator
      // dismiss those before navigating home. During initial routing there is
      // no Navigator yet, so consume back until the first route is ready.
      final navigator = delegate.navigatorKey.currentState;
      if (navigator == null || await navigator.maybePop()) return true;
    } else if (await super.invokeCallback(defaultValue)) {
      // Includes pages, dialogs, PopScope blocks and GoRoute.onExit guards.
      return true;
    }

    // An asynchronous exit guard may have navigated or replaced the router.
    if (_router() != router || delegate.currentConfiguration != configuration) {
      return true;
    }

    final path = router.routeInformationProvider.value.uri.path;
    if (path == AppRoutes.homePath) return false;
    final destination = switch (path) {
      AppRoutes.tradePath ||
      AppRoutes.marketSearchPath => AppRoutes.marketsPath,
      _ when path.startsWith('${AppRoutes.activityPath}/') =>
        AppRoutes.activityPath,
      _ => AppRoutes.homePath,
    };
    router.go(destination);
    return true;
  }
}
