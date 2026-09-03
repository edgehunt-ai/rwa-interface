import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer createProviderContainer() {
  final container = ProviderContainer();
  addTearDown(container.dispose);
  return container;
}
