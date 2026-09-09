import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/api_environment.dart';
import 'package:rwa_interface/data/api/rwa_api_data_source.dart';
import 'package:rwa_interface/data/services/generated_account_service.dart';
import 'package:rwa_interface/data/services/generated_session_service.dart';
import 'package:rwa_interface/data/services/generated_wallets_service.dart';

import '../../helpers/controlled_api_adapter.dart';
import '../../helpers/trading_provider_harness.dart';

void main() {
  test(
    'generated services cover auth, account, devices, and wallets',
    () async {
      final adapter = ControlledApiAdapter([
        ControlledResponse.json(
          method: 'GET',
          path: '/v1/auth/config',
          statusCode: 200,
          body: const {
            'privy_app_id': 'app-1',
            'login_methods': ['email'],
          },
        ),
        ControlledResponse.json(
          method: 'GET',
          path: '/v1/me',
          statusCode: 200,
          body: _userJson,
        ),
        ControlledResponse.json(
          method: 'GET',
          path: '/v1/me/devices',
          statusCode: 200,
          body: const {'items': <Object?>[], 'has_more': false},
        ),
        ControlledResponse.json(
          method: 'GET',
          path: '/v1/me/wallets',
          statusCode: 200,
          body: const {'items': <Object?>[], 'has_more': false},
        ),
        const ControlledResponse(
          method: 'DELETE',
          path: '/v1/auth/session',
          statusCode: 204,
          body: [],
        ),
      ]);
      final source = _source(adapter);
      final session = GeneratedSessionService(source.client.getAuthApi());
      final account = GeneratedAccountService(source.client.getAccountApi());
      final wallets = GeneratedWalletsService(source.client.getWalletsApi());

      expect((await session.getAuthConfig()).privyAppId, 'app-1');
      expect((await account.getMe()).userId, 'user-1');
      expect((await account.listDevices()).items, isEmpty);
      expect((await wallets.listWallets()).items, isEmpty);
      await session.deleteSession();
      expect(adapter.requests.map((request) => request.path), hasLength(5));
    },
  );
}

RwaApiDataSource _source(HttpClientAdapter adapter) {
  final source = RwaApiDataSource.create(
    tokenProvider: FakePrivyAccessTokenProvider(),
    environment: const ApiEnvironment(baseUrl: 'https://controlled.invalid'),
  );
  source.dio.httpClientAdapter = adapter;
  return source;
}

const _userJson = {
  'user_id': 'user-1',
  'settings': {
    'language': 'en',
    'push_enabled': true,
    'notify_order_filled': true,
    'notify_order_failed': true,
    'notify_liquidation_warning': true,
  },
};
