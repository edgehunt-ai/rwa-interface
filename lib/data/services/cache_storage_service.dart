import 'dart:io';

import 'package:flutter/painting.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

typedef CacheDirectoryResolver = Future<Directory> Function();

abstract interface class CacheStorageService {
  Future<int> sizeBytes();

  Future<void> clear();
}

final class DeviceCacheStorageService implements CacheStorageService {
  DeviceCacheStorageService({
    CacheDirectoryResolver? resolveDirectory,
    Future<void> Function()? clearImageCache,
  }) : _resolveDirectory = resolveDirectory ?? getApplicationCacheDirectory,
       _clearImageCache = clearImageCache ?? DefaultCacheManager().emptyCache;

  final CacheDirectoryResolver _resolveDirectory;
  final Future<void> Function() _clearImageCache;

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
    // Clear through the manager first so its database cannot retain stale
    // records for image files removed from the system cache directory.
    await _clearImageCache();
    final directory = await _resolveDirectory();
    if (!await directory.exists()) return;

    await for (final entity in directory.list(followLinks: false)) {
      await entity.delete(recursive: entity is Directory);
    }
    // Disk eviction must also remove decoded images held by Flutter.
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }
}
