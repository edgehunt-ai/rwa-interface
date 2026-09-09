import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/app_update_repository_impl.dart';
import 'package:rwa_interface/data/services/package_info_service.dart';
import 'package:rwa_interface/data/services/system_service.dart';
import 'package:rwa_interface/domain/models/app_update.dart';

void main() {
  test('reports an optional update when latest version is newer', () async {
    final repository = AppUpdateRepositoryImpl(
      _SystemService(_version(latest: '1.2.0', minimum: '1.0.0')),
      _PackageInfoService('1.1.0'),
    );

    final update = await repository.checkForUpdate();

    expect(update.availability, AppUpdateAvailability.available);
    expect(update.latestVersion, '1.2.0');
    expect(update.storeUri, Uri.parse('https://example.com/update'));
  });

  test('reports a required update below the supported version', () async {
    final repository = AppUpdateRepositoryImpl(
      _SystemService(_version(latest: '2.0.0', minimum: '1.5.0')),
      _PackageInfoService('1.4.9'),
    );

    expect(
      (await repository.checkForUpdate()).availability,
      AppUpdateAvailability.required,
    );
  });
}

api.AppVersionInfo _version({
  required String latest,
  required String minimum,
}) => api.AppVersionInfo(
  (builder) => builder
    ..platform = 'android'
    ..latestVersion = latest
    ..minSupportedVersion = minimum
    ..storeUrl = 'https://example.com/update',
);

final class _SystemService implements SystemService {
  _SystemService(this.version);
  final api.AppVersionInfo version;
  @override
  Future<List<api.AppVersionInfo>> listAppVersions({String? platform}) async =>
      [version];
}

final class _PackageInfoService implements PackageInfoService {
  _PackageInfoService(this.version);
  final String version;
  @override
  Future<InstalledAppInfo> getInstalledAppInfo() async =>
      InstalledAppInfo(version: version, platform: 'android');
}
