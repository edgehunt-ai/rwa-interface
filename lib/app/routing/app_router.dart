import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/ui/features/home/views/details_screen.dart';
import 'package:rwa_interface/ui/features/home/views/home_screen.dart';
import 'package:rwa_interface/ui/features/not_found/views/not_found_screen.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

abstract final class AppRouter {
  static GoRouter create({String initialLocation = AppRoutes.homePath}) {
    return GoRouter(
      initialLocation: initialLocation,
      observers: [SentryNavigatorObserver()],
      routes: [
        GoRoute(
          name: AppRoutes.homeName,
          path: AppRoutes.homePath,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          name: AppRoutes.detailsName,
          path: AppRoutes.detailsPath,
          builder: (context, state) => const DetailsScreen(),
        ),
      ],
      errorBuilder: (context, state) =>
          NotFoundScreen(location: state.uri.toString()),
    );
  }
}
