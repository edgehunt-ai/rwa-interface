import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/activity_record.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/repositories/activity_repository.dart';
import 'package:rwa_interface/ui/features/activity/providers/activity_provider.dart';

void main() {
  test('activity provider keeps filter isolated', () async {
    final repository = _ActivityRepository();
    final container = ProviderContainer(
      overrides: [activityRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    const filter = (
      category: ActivityCategory.orders,
      status: ActivityState.success,
      type: null,
      productOrAsset: null,
      cursor: 'next',
    );
    await container.read(activityProvider(filter).future);
    expect(repository.filter, filter);
  });
}

final class _ActivityRepository implements ActivityRepository {
  ActivityFilter? filter;
  @override
  Future<DomainPage<ActivityRecord>> list({
    ActivityCategory? category,
    ActivityState? status,
    String? type,
    String? productOrAsset,
    String? cursor,
  }) async {
    filter = (
      category: category,
      status: status,
      type: type,
      productOrAsset: productOrAsset,
      cursor: cursor,
    );
    return const DomainPage(items: []);
  }
}
