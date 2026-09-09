//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transfer_provider_status.g.dart';

class TransferProviderStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'pending')
  static const TransferProviderStatus pending = _$pending;
  @BuiltValueEnumConst(wireName: r'processing')
  static const TransferProviderStatus processing = _$processing;
  @BuiltValueEnumConst(wireName: r'succeeded')
  static const TransferProviderStatus succeeded = _$succeeded;
  @BuiltValueEnumConst(wireName: r'failed')
  static const TransferProviderStatus failed = _$failed;
  @BuiltValueEnumConst(wireName: r'refund_pending')
  static const TransferProviderStatus refundPending = _$refundPending;
  @BuiltValueEnumConst(wireName: r'refunded')
  static const TransferProviderStatus refunded = _$refunded;
  @BuiltValueEnumConst(wireName: r'unknown')
  static const TransferProviderStatus unknown = _$unknown;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const TransferProviderStatus manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TransferProviderStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<TransferProviderStatus> get serializer => _$transferProviderStatusSerializer;

  const TransferProviderStatus._(String name): super(name);

  static BuiltSet<TransferProviderStatus> get values => _$values;
  static TransferProviderStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TransferProviderStatusMixin = Object with _$TransferProviderStatusMixin;

