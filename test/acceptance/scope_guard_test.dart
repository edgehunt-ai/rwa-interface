import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'application ports and providers exclude deferred command entrypoints',
    () {
      final files = Directory('lib')
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart'));
      final applicationFiles = files.where(
        (file) =>
            file.path.contains('/domain/repositories/') ||
            file.path.contains('/ui/') ||
            file.path.contains('/app/providers/'),
      );
      final source = applicationFiles
          .map((file) => file.readAsStringSync())
          .join('\n')
          .toLowerCase();
      for (final forbidden in [
        'completeorderwalletaction',
        'createfundingplan',
        'createtransfer',
        'createclaim',
      ]) {
        expect(source, isNot(contains(forbidden)), reason: forbidden);
      }
      expect(source, isNot(contains('package:rwa_api_client')));
    },
  );
}
