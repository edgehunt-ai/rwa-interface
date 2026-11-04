import '../../domain/models/access_region.dart';
import '../../domain/repositories/access_region_repository.dart';
import '../services/system_service.dart';

final class AccessRegionRepositoryImpl implements AccessRegionRepository {
  AccessRegionRepositoryImpl(this._service);

  final SystemService _service;

  @override
  Future<AccessRegion> getAccessRegion() async {
    final value = await _service.getAccessRegion();
    return AccessRegion(
      countryCode: value.countryCode,
      source: value.source_.name,
      restricted: value.restricted,
      restrictedCountries: value.restrictedCountries,
      restrictedRegions: value.restrictedRegions.map(
        (region) => RestrictedRegion(
          countryCode: region.countryCode,
          name: region.name,
        ),
      ),
    );
  }
}
