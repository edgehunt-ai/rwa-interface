/// The action may have produced venue effects. Resume this ID, never replace it.
final class Hip3ActionPending implements Exception {
  const Hip3ActionPending(this.actionId, {this.requiresReview = false});
  final String actionId;
  final bool requiresReview;
}
