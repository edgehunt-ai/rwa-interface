final class UserPreferences {
  const UserPreferences({
    required this.language,
    required this.pushEnabled,
    required this.notifyOrderFilled,
    required this.notifyOrderFailed,
    required this.notifyLiquidationWarning,
  });

  final String language;
  final bool pushEnabled;
  final bool notifyOrderFilled;
  final bool notifyOrderFailed;
  final bool notifyLiquidationWarning;
}

final class UserPreferencesPatch {
  const UserPreferencesPatch({
    this.language,
    this.pushEnabled,
    this.notifyOrderFilled,
    this.notifyOrderFailed,
    this.notifyLiquidationWarning,
  });

  final String? language;
  final bool? pushEnabled;
  final bool? notifyOrderFilled;
  final bool? notifyOrderFailed;
  final bool? notifyLiquidationWarning;
}

final class UserAccount {
  const UserAccount({
    required this.userId,
    required this.settings,
    this.privyDid,
    this.displayName,
    this.avatarUri,
    this.createdAt,
  });

  final String userId;
  final String? privyDid;
  final String? displayName;
  final Uri? avatarUri;
  final DateTime? createdAt;
  final UserPreferences settings;
}
