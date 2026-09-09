import 'package:flutter_test/flutter_test.dart';

final class RequirementScenario {
  const RequirementScenario({
    required this.id,
    required this.story,
    required this.requirements,
  });

  final String id;
  final String story;
  final Set<String> requirements;
}

void expectRepresentativeScenarioCount(
  Iterable<RequirementScenario> scenarios, {
  int minimum = 50,
}) {
  expect(scenarios.map((scenario) => scenario.id).toSet(), hasLength(minimum));
  expect(scenarios, hasLength(greaterThanOrEqualTo(minimum)));
}
