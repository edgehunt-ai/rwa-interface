import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../domain/models/app_update.dart';

abstract interface class PackageInfoService {
  Future<InstalledAppInfo> getInstalledAppInfo();
}

final class PackageInfoPlusService implements PackageInfoService {
  @override
  Future<InstalledAppInfo> getInstalledAppInfo() async {
    final info = await PackageInfo.fromPlatform();
    return InstalledAppInfo(version: info.version, platform: _platformName());
  }

  String _platformName() {
    if (kIsWeb) return 'web';
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => 'android',
      TargetPlatform.iOS => 'ios',
      TargetPlatform.fuchsia => 'fuchsia',
      TargetPlatform.linux => 'linux',
      TargetPlatform.macOS => 'macos',
      TargetPlatform.windows => 'windows',
    };
  }
}
