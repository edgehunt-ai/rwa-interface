//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_agent_status.g.dart';

class Hip3AgentStatus extends EnumClass {
  @BuiltValueEnumConst(wireName: r'awaiting_owner_approval')
  static const Hip3AgentStatus awaitingOwnerApproval = _$awaitingOwnerApproval;
  @BuiltValueEnumConst(wireName: r'registering')
  static const Hip3AgentStatus registering = _$registering;
  @BuiltValueEnumConst(wireName: r'active')
  static const Hip3AgentStatus active = _$active;
  @BuiltValueEnumConst(wireName: r'expiring')
  static const Hip3AgentStatus expiring = _$expiring;
  @BuiltValueEnumConst(wireName: r'expired')
  static const Hip3AgentStatus expired = _$expired;
  @BuiltValueEnumConst(wireName: r'rotating')
  static const Hip3AgentStatus rotating = _$rotating;
  @BuiltValueEnumConst(wireName: r'revoked')
  static const Hip3AgentStatus revoked = _$revoked;
  @BuiltValueEnumConst(wireName: r'failed')
  static const Hip3AgentStatus failed = _$failed;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const Hip3AgentStatus manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3AgentStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<Hip3AgentStatus> get serializer =>
      _$hip3AgentStatusSerializer;

  const Hip3AgentStatus._(String name) : super(name);

  static BuiltSet<Hip3AgentStatus> get values => _$values;
  static Hip3AgentStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class Hip3AgentStatusMixin = Object with _$Hip3AgentStatusMixin;
