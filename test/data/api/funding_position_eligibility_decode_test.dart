import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

void main() {
  group('FundingPositionEligibility decoding', () {
    test('decodes an eligible position with no blockers', () {
      final eligibility = api.standardSerializers.deserializeWith(
        api.FundingPositionEligibility.serializer,
        {'status': 'eligible', 'blockers': <Object?>[]},
      );

      expect(eligibility, isNotNull);
      expect(
        eligibility!.status,
        api.FundingPositionEligibilityStatusEnum.eligible,
      );
      expect(eligibility.blockers, isEmpty);
    });

    test('decodes an ineligible position with blockers', () {
      final eligibility = api.standardSerializers.deserializeWith(
        api.FundingPositionEligibility.serializer,
        {
          'status': 'ineligible',
          'blockers': ['fully_reserved'],
        },
      );

      expect(eligibility, isNotNull);
      expect(
        eligibility!.status,
        api.FundingPositionEligibilityStatusEnum.ineligible,
      );
      expect(eligibility.blockers.single.name, 'fullyReserved');
    });
  });
}
