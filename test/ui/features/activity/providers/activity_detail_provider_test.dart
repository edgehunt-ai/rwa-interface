import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app/providers/session_scope.dart';
import 'package:nobell/domain/models/activity_record.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/repositories/activity_repository.dart';
import 'package:nobell/ui/features/activity/providers/activity_provider.dart';

void main() {
  final record = ActivityRecord(
    id: 'target',
    category: ActivityCategory.cash,
    type: 'deposit',
    status: ActivityState.success,
    title: 'Deposit',
    createdAt: DateTime.utc(2026),
  );
  test('finds older records using unfiltered pages', () async {
    final repository = _Repository({
      null: const DomainPage(items: [], hasMore: true, nextCursor: 'next'),
      'next': DomainPage(items: [record]),
    });
    final container = ProviderContainer(
      overrides: [activityRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    expect(
      await container.read(activityDetailProvider('target').future),
      record,
    );
    expect(repository.cursors, [null, 'next']);
  });
  test('missing IDs and repeated cursors terminate safely', () async {
    final repository = _Repository({
      null: const DomainPage(items: [], hasMore: true, nextCursor: 'next'),
      'next': const DomainPage(items: [], hasMore: true, nextCursor: 'next'),
    });
    final container = ProviderContainer(
      overrides: [activityRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    expect(
      await container.read(activityDetailProvider('missing').future),
      isNull,
    );
    expect(repository.cursors, [null, 'next']);
  });
  test('session changes discard previously loaded details', () async {
    final repository = _Repository({
      null: DomainPage(items: [record]),
    });
    final container = ProviderContainer(
      overrides: [activityRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      activityDetailProvider('target'),
      (_, _) {},
    );
    addTearDown(subscription.close);
    expect(
      await container.read(activityDetailProvider('target').future),
      record,
    );
    repository.pages[null] = const DomainPage(items: []);
    container.read(sessionGenerationProvider.notifier).clearUserScope();
    expect(
      await container.read(activityDetailProvider('target').future),
      isNull,
    );
  });
}

class _Repository implements ActivityRepository {
  _Repository(this.pages);
  final Map<String?, DomainPage<ActivityRecord>> pages;
  final cursors = <String?>[];
  @override
  Future<DomainPage<ActivityRecord>> list({
    ActivityCategory? category,
    ActivityState? status,
    String? type,
    String? productOrAsset,
    String? cursor,
  }) async {
    expect([category, status, type, productOrAsset], everyElement(isNull));
    cursors.add(cursor);
    return pages[cursor]!;
  }
}
