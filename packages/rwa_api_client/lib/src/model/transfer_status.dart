//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transfer_status.g.dart';

class TransferStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'awaiting_authorization')
  static const TransferStatus awaitingAuthorization = _$awaitingAuthorization;
  @BuiltValueEnumConst(wireName: r'awaiting_wallet')
  static const TransferStatus awaitingWallet = _$awaitingWallet;
  @BuiltValueEnumConst(wireName: r'origin_submitted')
  static const TransferStatus originSubmitted = _$originSubmitted;
  @BuiltValueEnumConst(wireName: r'origin_confirmed')
  static const TransferStatus originConfirmed = _$originConfirmed;
  @BuiltValueEnumConst(wireName: r'filling')
  static const TransferStatus filling = _$filling;
  @BuiltValueEnumConst(wireName: r'completed')
  static const TransferStatus completed = _$completed;
  @BuiltValueEnumConst(wireName: r'refund_pending')
  static const TransferStatus refundPending = _$refundPending;
  @BuiltValueEnumConst(wireName: r'refunded')
  static const TransferStatus refunded = _$refunded;
  @BuiltValueEnumConst(wireName: r'failed')
  static const TransferStatus failed = _$failed;
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const TransferStatus ambiguous = _$ambiguous;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const TransferStatus manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TransferStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<TransferStatus> get serializer => _$transferStatusSerializer;

  const TransferStatus._(String name): super(name);

  static BuiltSet<TransferStatus> get values => _$values;
  static TransferStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TransferStatusMixin = Object with _$TransferStatusMixin;

