import 'dart:io';

import 'package:path_provider/path_provider.dart';

typedef CacheDirectoryResolver = Future<Directory> Function();

abstract interface class CacheStorageService {
  Future<int> sizeBytes();

  Future<void> clear();
}

final class DeviceCacheStorageService implements CacheStorageService {
  DeviceCacheStorageService({CacheDirectoryResolver? resolveDirectory})
    : _resolveDirectory = resolveDirectory ?? getApplicationCacheDirectory;

  final CacheDirectoryResolver _resolveDirectory;

  @override
  Future<int> sizeBytes() async {
    final directory = await _resolveDirectory();
    if (!await directory.exists()) return 0;

    var total = 0;
    await for (final entity in directory.list(recursive: true)) {
      if (entity is File) total += await entity.length();
    }
    return total;
  }

  @override
  Future<void> clear() async {
    final directory = await _resolveDirectory();
    if (!await directory.exists()) return;

    await for (final entity in directory.list(followLinks: false)) {
      await entity.delete(recursive: entity is Directory);
    }
  }
}
