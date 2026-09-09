import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/services/cache_storage_service.dart';

void main() {
  test('calculates and clears only the application cache directory', () async {
    final directory = await Directory.systemTemp.createTemp('rwa-cache-test-');
    addTearDown(() => directory.delete(recursive: true));
    final nested = Directory('${directory.path}/images');
    await nested.create();
    await File('${directory.path}/metadata.json').writeAsBytes([1, 2, 3]);
    await File('${nested.path}/chart.png').writeAsBytes(List.filled(10, 1));
    final service = DeviceCacheStorageService(
      resolveDirectory: () async => directory,
    );

    expect(await service.sizeBytes(), 13);

    await service.clear();

    expect(await service.sizeBytes(), 0);
    expect(await directory.exists(), isTrue);
  });
}
