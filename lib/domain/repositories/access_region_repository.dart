import '../models/access_region.dart';

abstract interface class AccessRegionRepository {
  Future<AccessRegion> getAccessRegion();
}
