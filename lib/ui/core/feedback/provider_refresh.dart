/// Waits for providers whose loading/error states are already rendered by the
/// screen. Their errors must not also escape a RefreshIndicator or void retry
/// callback. This also handles disposal while a provider is awaiting a retry.
Future<void> waitForProviderRefresh<T>(Future<T> refresh) async {
  try {
    await refresh;
  } on Object {
    // The provider retains the failure and the screen owns its presentation.
  }
}
