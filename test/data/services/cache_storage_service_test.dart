import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/data/services/cache_storage_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('calculates and clears only the application cache directory', () async {
    final directory = await Directory.systemTemp.createTemp('rwa-cache-test-');
    addTearDown(() => directory.delete(recursive: true));
    final nested = Directory('${directory.path}/images');
    await nested.create();
    await File('${directory.path}/metadata.json').writeAsBytes([1, 2, 3]);
    await File('${nested.path}/chart.png').writeAsBytes(List.filled(10, 1));
    var imageCacheCleared = false;
    final service = DeviceCacheStorageService(
      resolveDirectory: () async => directory,
      clearImageCache: () async => imageCacheCleared = true,
    );

    expect(await service.sizeBytes(), 13);

    await service.clear();

    expect(await service.sizeBytes(), 0);
    expect(await directory.exists(), isTrue);
    expect(imageCacheCleared, isTrue);
  });
}
