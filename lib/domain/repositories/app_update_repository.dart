import '../models/app_update.dart';

abstract interface class AppUpdateRepository {
  Future<InstalledAppInfo> getInstalledAppInfo();

  Future<AppUpdate> checkForUpdate();
}
