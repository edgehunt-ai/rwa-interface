import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/services/cache_storage_service.dart';

final cacheStorageServiceProvider = Provider<CacheStorageService>(
  (_) => DeviceCacheStorageService(),
);

final cacheSizeProvider = FutureProvider.autoDispose<int>(
  (ref) => ref.watch(cacheStorageServiceProvider).sizeBytes(),
);

final class CacheCommand extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> clear() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(cacheStorageServiceProvider).clear(),
    );
    if (!state.hasError) ref.invalidate(cacheSizeProvider);
  }
}

final cacheCommandProvider = AsyncNotifierProvider<CacheCommand, void>(
  CacheCommand.new,
);
