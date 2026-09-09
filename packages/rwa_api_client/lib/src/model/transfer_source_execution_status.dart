//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transfer_source_execution_status.g.dart';

class TransferSourceExecutionStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'awaiting_wallet')
  static const TransferSourceExecutionStatus awaitingWallet = _$awaitingWallet;
  @BuiltValueEnumConst(wireName: r'submitted')
  static const TransferSourceExecutionStatus submitted = _$submitted;
  @BuiltValueEnumConst(wireName: r'confirmed')
  static const TransferSourceExecutionStatus confirmed = _$confirmed;
  @BuiltValueEnumConst(wireName: r'failed')
  static const TransferSourceExecutionStatus failed = _$failed;
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const TransferSourceExecutionStatus ambiguous = _$ambiguous;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const TransferSourceExecutionStatus manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TransferSourceExecutionStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<TransferSourceExecutionStatus> get serializer => _$transferSourceExecutionStatusSerializer;

  const TransferSourceExecutionStatus._(String name): super(name);

  static BuiltSet<TransferSourceExecutionStatus> get values => _$values;
  static TransferSourceExecutionStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TransferSourceExecutionStatusMixin = Object with _$TransferSourceExecutionStatusMixin;

