import 'unsupported_capability.dart';

final class ResourceResult<T> {
  const ResourceResult({required this.resource, this.capability});

  final T resource;
  final UnsupportedCapability? capability;
}
