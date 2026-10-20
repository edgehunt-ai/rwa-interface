//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'financial_economic_status.g.dart';

class FinancialEconomicStatus extends EnumClass {

  /// Financial facts independent of technical success or support review. reserved is not spent; source_debited/in_transit require debit evidence; refund_pending is not refunded. Partial states retain the remaining obligation. credited is actual destination receipt; refunded is actual net return; compensated requires an approved real payout command and final receipt. released is proven unspent release, not refund. settled covers reconciled mixed outcomes. unknown remains unresolved. No label waives unknown fees or nonzero/unknown outstanding funds. 
  @BuiltValueEnumConst(wireName: r'reserved')
  static const FinancialEconomicStatus reserved = _$reserved;
  /// Financial facts independent of technical success or support review. reserved is not spent; source_debited/in_transit require debit evidence; refund_pending is not refunded. Partial states retain the remaining obligation. credited is actual destination receipt; refunded is actual net return; compensated requires an approved real payout command and final receipt. released is proven unspent release, not refund. settled covers reconciled mixed outcomes. unknown remains unresolved. No label waives unknown fees or nonzero/unknown outstanding funds. 
  @BuiltValueEnumConst(wireName: r'source_debited')
  static const FinancialEconomicStatus sourceDebited = _$sourceDebited;
  /// Financial facts independent of technical success or support review. reserved is not spent; source_debited/in_transit require debit evidence; refund_pending is not refunded. Partial states retain the remaining obligation. credited is actual destination receipt; refunded is actual net return; compensated requires an approved real payout command and final receipt. released is proven unspent release, not refund. settled covers reconciled mixed outcomes. unknown remains unresolved. No label waives unknown fees or nonzero/unknown outstanding funds. 
  @BuiltValueEnumConst(wireName: r'in_transit')
  static const FinancialEconomicStatus inTransit = _$inTransit;
  /// Financial facts independent of technical success or support review. reserved is not spent; source_debited/in_transit require debit evidence; refund_pending is not refunded. Partial states retain the remaining obligation. credited is actual destination receipt; refunded is actual net return; compensated requires an approved real payout command and final receipt. released is proven unspent release, not refund. settled covers reconciled mixed outcomes. unknown remains unresolved. No label waives unknown fees or nonzero/unknown outstanding funds. 
  @BuiltValueEnumConst(wireName: r'refund_pending')
  static const FinancialEconomicStatus refundPending = _$refundPending;
  /// Financial facts independent of technical success or support review. reserved is not spent; source_debited/in_transit require debit evidence; refund_pending is not refunded. Partial states retain the remaining obligation. credited is actual destination receipt; refunded is actual net return; compensated requires an approved real payout command and final receipt. released is proven unspent release, not refund. settled covers reconciled mixed outcomes. unknown remains unresolved. No label waives unknown fees or nonzero/unknown outstanding funds. 
  @BuiltValueEnumConst(wireName: r'partially_settled')
  static const FinancialEconomicStatus partiallySettled = _$partiallySettled;
  /// Financial facts independent of technical success or support review. reserved is not spent; source_debited/in_transit require debit evidence; refund_pending is not refunded. Partial states retain the remaining obligation. credited is actual destination receipt; refunded is actual net return; compensated requires an approved real payout command and final receipt. released is proven unspent release, not refund. settled covers reconciled mixed outcomes. unknown remains unresolved. No label waives unknown fees or nonzero/unknown outstanding funds. 
  @BuiltValueEnumConst(wireName: r'partially_refunded')
  static const FinancialEconomicStatus partiallyRefunded = _$partiallyRefunded;
  /// Financial facts independent of technical success or support review. reserved is not spent; source_debited/in_transit require debit evidence; refund_pending is not refunded. Partial states retain the remaining obligation. credited is actual destination receipt; refunded is actual net return; compensated requires an approved real payout command and final receipt. released is proven unspent release, not refund. settled covers reconciled mixed outcomes. unknown remains unresolved. No label waives unknown fees or nonzero/unknown outstanding funds. 
  @BuiltValueEnumConst(wireName: r'credited')
  static const FinancialEconomicStatus credited = _$credited;
  /// Financial facts independent of technical success or support review. reserved is not spent; source_debited/in_transit require debit evidence; refund_pending is not refunded. Partial states retain the remaining obligation. credited is actual destination receipt; refunded is actual net return; compensated requires an approved real payout command and final receipt. released is proven unspent release, not refund. settled covers reconciled mixed outcomes. unknown remains unresolved. No label waives unknown fees or nonzero/unknown outstanding funds. 
  @BuiltValueEnumConst(wireName: r'refunded')
  static const FinancialEconomicStatus refunded = _$refunded;
  /// Financial facts independent of technical success or support review. reserved is not spent; source_debited/in_transit require debit evidence; refund_pending is not refunded. Partial states retain the remaining obligation. credited is actual destination receipt; refunded is actual net return; compensated requires an approved real payout command and final receipt. released is proven unspent release, not refund. settled covers reconciled mixed outcomes. unknown remains unresolved. No label waives unknown fees or nonzero/unknown outstanding funds. 
  @BuiltValueEnumConst(wireName: r'compensated')
  static const FinancialEconomicStatus compensated = _$compensated;
  /// Financial facts independent of technical success or support review. reserved is not spent; source_debited/in_transit require debit evidence; refund_pending is not refunded. Partial states retain the remaining obligation. credited is actual destination receipt; refunded is actual net return; compensated requires an approved real payout command and final receipt. released is proven unspent release, not refund. settled covers reconciled mixed outcomes. unknown remains unresolved. No label waives unknown fees or nonzero/unknown outstanding funds. 
  @BuiltValueEnumConst(wireName: r'released')
  static const FinancialEconomicStatus released = _$released;
  /// Financial facts independent of technical success or support review. reserved is not spent; source_debited/in_transit require debit evidence; refund_pending is not refunded. Partial states retain the remaining obligation. credited is actual destination receipt; refunded is actual net return; compensated requires an approved real payout command and final receipt. released is proven unspent release, not refund. settled covers reconciled mixed outcomes. unknown remains unresolved. No label waives unknown fees or nonzero/unknown outstanding funds. 
  @BuiltValueEnumConst(wireName: r'settled')
  static const FinancialEconomicStatus settled = _$settled;
  /// Financial facts independent of technical success or support review. reserved is not spent; source_debited/in_transit require debit evidence; refund_pending is not refunded. Partial states retain the remaining obligation. credited is actual destination receipt; refunded is actual net return; compensated requires an approved real payout command and final receipt. released is proven unspent release, not refund. settled covers reconciled mixed outcomes. unknown remains unresolved. No label waives unknown fees or nonzero/unknown outstanding funds. 
  @BuiltValueEnumConst(wireName: r'unknown')
  static const FinancialEconomicStatus unknown = _$unknown;

  static Serializer<FinancialEconomicStatus> get serializer => _$financialEconomicStatusSerializer;

  const FinancialEconomicStatus._(String name): super(name);

  static BuiltSet<FinancialEconomicStatus> get values => _$values;
  static FinancialEconomicStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class FinancialEconomicStatusMixin = Object with _$FinancialEconomicStatusMixin;

