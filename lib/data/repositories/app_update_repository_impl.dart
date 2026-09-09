import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/app_update.dart';
import '../../domain/repositories/app_update_repository.dart';
import '../services/package_info_service.dart';
import '../services/system_service.dart';

final class AppUpdateRepositoryImpl implements AppUpdateRepository {
  AppUpdateRepositoryImpl(this._systemService, this._packageInfoService);

  final SystemService _systemService;
  final PackageInfoService _packageInfoService;

  @override
  Future<InstalledAppInfo> getInstalledAppInfo() =>
      _packageInfoService.getInstalledAppInfo();

  @override
  Future<AppUpdate> checkForUpdate() async {
    final installed = await getInstalledAppInfo();
    final versions = await _systemService.listAppVersions(
      platform: installed.platform,
    );
    api.AppVersionInfo? remote;
    for (final candidate in versions) {
      if (candidate.platform == installed.platform) {
        remote = candidate;
        break;
      }
    }
    if (remote == null) {
      return AppUpdate(
        installedVersion: installed.version,
        availability: AppUpdateAvailability.unavailable,
      );
    }
    final availability =
        _compareVersions(installed.version, remote.minSupportedVersion) < 0
        ? AppUpdateAvailability.required
        : _compareVersions(installed.version, remote.latestVersion) < 0
        ? AppUpdateAvailability.available
        : AppUpdateAvailability.upToDate;
    return AppUpdate(
      installedVersion: installed.version,
      availability: availability,
      latestVersion: remote.latestVersion,
      releaseNotes: remote.releaseNotes,
      storeUri: remote.storeUrl == null ? null : Uri.tryParse(remote.storeUrl!),
    );
  }
}

int _compareVersions(String left, String right) {
  List<int> parts(String value) =>
      RegExp(r'\d+')
          .allMatches(value)
          .map((match) => int.parse(match.group(0)!))
          .toList(growable: false);
  final leftParts = parts(left);
  final rightParts = parts(right);
  final length = leftParts.length > rightParts.length
      ? leftParts.length
      : rightParts.length;
  for (var index = 0; index < length; index++) {
    final difference =
        (index < leftParts.length ? leftParts[index] : 0) -
        (index < rightParts.length ? rightParts[index] : 0);
    if (difference != 0) return difference.sign.toInt();
  }
  return 0;
}
