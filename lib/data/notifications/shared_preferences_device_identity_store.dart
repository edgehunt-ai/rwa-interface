import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

abstract interface class DeviceIdentityStore {
  Future<String> getOrCreate();
}

final class SharedPreferencesDeviceIdentityStore
    implements DeviceIdentityStore {
  static const _key = 'push_device_id';

  @override
  Future<String> getOrCreate() async {
    final preferences = await SharedPreferences.getInstance();
    final existing = preferences.getString(_key);
    if (existing != null && existing.isNotEmpty) return existing;

    final random = Random.secure();
    final id = List<String>.generate(
      32,
      (_) => random.nextInt(16).toRadixString(16),
    ).join();
    await preferences.setString(_key, id);
    return id;
  }
}
