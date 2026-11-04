import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/data/api/api_environment.dart';
import 'package:nobell/data/api/rwa_api_data_source.dart';
import 'package:nobell/domain/models/api_failure.dart';

import '../../helpers/controlled_api_adapter.dart';
import '../../helpers/trading_provider_harness.dart';

void main() {
  late RwaApiDataSource source;
  late ControlledApiAdapter adapter;
  late ProviderContainer container;

  setUp(() {
    source = RwaApiDataSource.create(
      tokenProvider: FakePrivyAccessTokenProvider(),
      environment: const ApiEnvironment(baseUrl: 'https://controlled.invalid'),
    );
    adapter = ControlledApiAdapter();
    source.dio.httpClientAdapter = adapter;
    container = ProviderContainer(
      overrides: [apiDataSourceProvider.overrideWithValue(source)],
    );
  });
  tearDown(() {
    container.dispose();
    source.dio.close();
  });

  void respond(Object? body, {int status = 200}) => adapter.enqueue(
    ControlledResponse.json(
      method: 'GET',
      path: '/v1/system/access-region',
      statusCode: status,
      body: body,
    ),
  );

  test(
    'public request maps decision and current server list into the domain',
    () async {
      respond({
        'country_code': 'DE',
        'source': 'edge',
        'restricted': true,
        'restricted_countries': ['DE', 'SG'],
        'restricted_regions': [
          {'country_code': 'SG', 'name': 'Singapore (server label)'},
          {'country_code': 'DE', 'name': 'Germany'},
        ],
      });
      final region = await container.read(accessRegionProvider.future);
      expect(region.countryCode, 'DE');
      expect(region.source, 'edge');
      expect(region.restricted, isTrue);
      expect(region.restrictedCountries, ['DE', 'SG']);
      expect(region.restrictedRegions.map((region) => region.countryCode), [
        'SG',
        'DE',
      ]);
      expect(region.restrictedRegions.map((region) => region.name), [
        'Singapore (server label)',
        'Germany',
      ]);
      expect(
        adapter.requests.single.headers.keys.map((key) => key.toLowerCase()),
        isNot(contains('authorization')),
      );
      expect(
        adapter.requests.single.headers['cache-control'],
        'no-cache, no-store',
      );
    },
  );

  test(
    'unrestricted and unknown country are taken directly from the server',
    () async {
      respond({
        'country_code': null,
        'source': 'unknown',
        'restricted': false,
        'restricted_countries': <String>[],
        'restricted_regions': <Map<String, String>>[],
      });
      final region = await container.read(accessRegionProvider.future);
      expect(region.countryCode, isNull);
      expect(region.restricted, isFalse);
      expect(region.restrictedCountries, isEmpty);
      expect(region.restrictedRegions, isEmpty);
    },
  );

  test(
    'disabled restriction still retains the published display list',
    () async {
      respond({
        'country_code': 'US',
        'source': 'edge',
        'restricted': false,
        'restricted_countries': ['US'],
        'restricted_regions': [
          {'country_code': 'US', 'name': 'United States'},
        ],
      });
      final region = await container.read(accessRegionProvider.future);
      expect(region.restricted, isFalse);
      expect(region.restrictedRegions.single.name, 'United States');
    },
  );

  test(
    'region without its required display name is a stable decoding failure',
    () async {
      respond({
        'country_code': 'US',
        'source': 'edge',
        'restricted': false,
        'restricted_countries': ['US'],
        'restricted_regions': [
          {'country_code': 'US'},
        ],
      });
      await expectLater(
        container.read(accessRegionProvider.future),
        throwsA(isA<DecodingFailure>()),
      );
    },
  );

  test('missing body becomes a stable decoding failure', () async {
    respond(null);
    await expectLater(
      container.read(accessRegionProvider.future),
      throwsA(isA<DecodingFailure>()),
    );
  });

  test('API failure keeps the actionable message', () async {
    respond({
      'code': 'region_lookup_unavailable',
      'message': 'Location service is under maintenance',
    }, status: 503);
    await expectLater(
      container.read(accessRegionProvider.future),
      throwsA(
        isA<ServerFailure>().having(
          (failure) => failure.message,
          'message',
          'Location service is under maintenance',
        ),
      ),
    );
  });
}
