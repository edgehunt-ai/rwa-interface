enum AppUpdateAvailability { unavailable, upToDate, available, required }

final class InstalledAppInfo {
  const InstalledAppInfo({required this.version, required this.platform});

  final String version;
  final String platform;
}

final class AppUpdate {
  const AppUpdate({
    required this.installedVersion,
    required this.availability,
    this.latestVersion,
    this.releaseNotes,
    this.storeUri,
  });

  final String installedVersion;
  final AppUpdateAvailability availability;
  final String? latestVersion;
  final String? releaseNotes;
  final Uri? storeUri;
}
