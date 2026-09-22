import 'package:flutter_test/flutter_test.dart';
import 'package:one_of/one_of.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/api/order_preview_payload.dart';
import 'package:rwa_interface/data/repositories/orders_repository_impl.dart';
import 'package:rwa_interface/data/services/orders_service.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/hip3_opening_protection.dart';

void main() {
  test(
    'conditional mapping preserves native activation and parent warning',
    () {
      final conditional = api.Hip3ConditionalOrder(
        (b) => b
          ..role = api.Hip3ConditionalOrderRoleEnum.takeProfit
          ..triggerPrice = '130'
          ..triggerReference = api.Hip3ConditionalOrderTriggerReferenceEnum.mark
          ..executionType = api.Hip3ConditionalOrderExecutionTypeEnum.market
          ..triggerStatus =
              api.Hip3ConditionalOrderTriggerStatusEnum.untriggered
          ..protectionGroupId = 'group'
          ..parentOrderId = 'parent'
          ..sizeMode = api.Hip3ConditionalOrderSizeModeEnum.quantity
          ..quantity = '1'
          ..reduceOnly = true
          ..activationStatus =
              api.Hip3ConditionalOrderActivationStatusEnum.waitingForParent
          ..warningCode = api
              .Hip3ConditionalOrderWarningCodeEnum
              .parentCancelledCheckRemainingPositionProtection,
      );
      final order = api.Order(
        (b) => b
          ..orderId = 'child'
          ..symbol = 'TSLA'
          ..kind = api.ProductKind.perp
          ..side = api.OrderSide.short
          ..type = api.OrderType.market
          ..status = api.OrderStatus.open
          ..createdAt = DateTime.utc(2026)
          ..conditional.replace(conditional),
      );
      final mapped = mapOrder(order).conditional!;
      expect(mapped.activationStatus, 'waitingForParent');
      expect(mapped.parentOrderId, 'parent');
      expect(
        mapped.warningCode,
        'parentCancelledCheckRemainingPositionProtection',
      );
      expect(
        mapOrder(order.rebuild((b) => b.conditional.activationStatus = null))
            .conditional!
            .activationStatus,
        'unknown',
      );
    },
  );
  OrderIntent protectedIntent() => OrderIntent(
    symbol: 'TSLA',
    kind: MarketProductKind.perp,
    side: TradingSide.long,
    type: TradingOrderType.market,
    marginMode: TradingMarginMode.cross,
    amount: DecimalValue('15'),
    openingProtection: Hip3OpeningProtection(
      takeProfit: Hip3OpeningProtectionLeg(triggerPrice: DecimalValue('110')),
      stopLoss: Hip3OpeningProtectionLeg(
        triggerPrice: DecimalValue('90'),
        limitPrice: DecimalValue('89'),
      ),
    ),
  );

  test('native opening protection serializes identically for preview and create without sizing fields', () async {
    final service = _PreviewOrders(protectionQuantity: '0.148');
    final repository = OrdersRepositoryImpl(service);
    final intent = protectedIntent();
    final preview = await repository.preview(
      intent,
      idempotencyKey: 'protected-preview',
    );
    expect(preview.openingProtectionMatchesIntent, isTrue);
    expect(
      preview.hip3Execution!.openingProtection!.legs.first.executionPrice.value,
      '99',
    );
    await repository.create(
      intent,
      previewId: preview.previewId,
      idempotencyKey: 'protected-create',
    );
    final expected = {
      'take_profit': {
        'trigger_price': '110',
        'trigger_reference': 'mark',
        'execution_type': 'market',
      },
      'stop_loss': {
        'trigger_price': '90',
        'trigger_reference': 'mark',
        'execution_type': 'limit',
        'limit_price': '89',
      },
    };
    expect(service.previewWire!['protection'], expected);
    expect(service.createWire!['protection'], expected);
    expect(service.previewWire!.containsKey('tp_sl'), isFalse);
    expect(service.createWire!.containsKey('tp_sl'), isFalse);
    expect(service.createWire!['preview_id'], 'preview');
  });

  test(
    'protected preview fails closed when confirmation is missing or resized',
    () async {
      for (final quantity in [null, '0.1']) {
        await expectLater(
          OrdersRepositoryImpl(
            _PreviewOrders(protectionQuantity: quantity),
          ).preview(protectedIntent(), idempotencyKey: 'invalid-confirmation'),
          throwsFormatException,
        );
      }
    },
  );
  test(
    'HIP3 preview retains frozen execution economics and risk reasons',
    () async {
      final preview = await OrdersRepositoryImpl(_PreviewOrders()).preview(
        OrderIntent(
          symbol: 'TSLA',
          kind: MarketProductKind.perp,
          side: TradingSide.long,
          type: TradingOrderType.market,
          marginMode: TradingMarginMode.cross,
          amount: DecimalValue('15'),
        ),
        idempotencyKey: 'preview-key',
      );
      final execution = preview.hip3Execution!;
      expect(execution.contextId, 'context');
      expect(execution.productId, 'xyz:TSLA');
      expect(execution.environment, 'testnet');
      expect(execution.type, TradingOrderType.market);
      expect(execution.timeInForce, 'ioc');
      expect(execution.quantity.value, '0.148');
      expect(execution.limitPrice.value, '101');
      expect(execution.maximumQuantity.value, '0.148');
      expect(execution.availableMargin.value, '20');
      expect(execution.marginRequired.value, '7.474');
      expect(execution.estimatedFee.asset, 'USDC');
      expect(execution.liquidationPrice, isNull);
      expect(
        execution.liquidationPriceUnavailableReason,
        'cross_margin_requires_full_account_simulation',
      );
      expect(preview.feeRate?.value, '0.0005');
      expect(preview.feeNote, 'Estimate only');
      expect(preview.details.single.label, 'Risk');
      expect(preview.details.single.tone, 'negative');
    },
  );
  test('pending signature is a non-retryable wait capability', () async {
    final result = await OrdersRepositoryImpl(_Orders()).create(
      OrderIntent(
        symbol: 'NVDA',
        kind: MarketProductKind.bstock,
        side: TradingSide.buy,
        type: TradingOrderType.market,
        quantity: DecimalValue('0.000000000000000001', unit: 'quantity'),
      ),
      idempotencyKey: 'key-1',
    );
    expect(result.resource.quantity?.value, '0.000000000000000001');
    expect(result.capability?.code, 'order_signature_not_supported');
    expect(result.capability?.userAction, 'wait_for_feature');
    expect(result.capability?.retryable, isFalse);
  });
}

final class _PreviewOrders implements OrdersService {
  _PreviewOrders({this.protectionQuantity});
  final String? protectionQuantity;
  Map<String, Object?>? previewWire;
  Map<String, Object?>? createWire;
  @override
  Future<PreviewOrderResponse> previewOrder(
    api.OrderPreviewRequest request, {
    required String idempotencyKey,
  }) async {
    previewWire = Map<String, Object?>.from(
      api.standardSerializers.serializeWith(
        api.OrderPreviewRequest.serializer,
        request,
      ) as Map,
    );
    final execution = api.Hip3PreviewExecution(
      (b) => b
        ..contextId = 'context'
        ..productId = 'xyz:TSLA'
        ..environment = api.Hip3Environment.testnet
        ..quantity = '0.148'
        ..type = api.Hip3PreviewExecutionTypeEnum.market
        ..timeInForce = api.Hip3TimeInForce.ioc
        ..limitPrice = '101'
        ..leverage = '2'
        ..marginMode = api.MarginMode.cross
        ..reduceOnly = false
        ..notionalUsdc = '14.948'
        ..marginRequiredUsdc = '7.474'
        ..availableMarginUsdc = '20'
        ..maximumQuantity = '0.148'
        ..estimatedFeeUsdc = '0.007474'
        ..slippagePercent = '1'
        ..openingProtection = protectionQuantity == null
            ? null
            : api.standardSerializers.deserializeWith(
                api.Hip3OpeningProtectionConfirmation.serializer,
                {
                  'quantity': protectionQuantity,
                  'legs': [
                    {
                      'role': 'take_profit',
                      'trigger_price': '110',
                      'execution_type': 'market',
                      'execution_price': '99',
                    },
                    {
                      'role': 'stop_loss',
                      'trigger_price': '90',
                      'execution_type': 'limit',
                      'execution_price': '89',
                    },
                  ],
                },
              )!.toBuilder()
        ..liquidationPriceUnavailableReason =
            'cross_margin_requires_full_account_simulation',
    );
    final value = api.PerpOrderPreview(
      (b) => b
        ..previewId = 'preview'
        ..symbol = 'TSLA'
        ..side = api.OrderSide.long
        ..type = api.OrderType.market
        ..orderValue = '14.948'
        ..hip3Execution.replace(execution)
        ..feeRate = '0.0005'
        ..feeNote = 'Estimate only'
        ..details.add(
          api.KeyValue(
            (b) => b
              ..label = 'Risk'
              ..value = 'Testnet only'
              ..tone = api.KeyValueToneEnum.negative,
          ),
        )
        ..kind = api.PerpOrderPreviewKindEnum.perp
        ..network = api.PerpOrderPreviewNetworkEnum.hyperliquid
        ..settlementAsset = api.PerpOrderPreviewSettlementAssetEnum.USDC
        ..settlementChainId =
            api.PerpOrderPreviewSettlementChainIdEnum.number1337
        ..settlementAssetId = api
            .PerpOrderPreviewSettlementAssetIdEnum
            .hyperliquidColon1337SlashPerpsColonUSDCPERPS
        ..settlementTokenContract = api
            .PerpOrderPreviewSettlementTokenContractEnum
            .n0x2100000000000000000000000000000000000000
        ..settlementTokenDecimals =
            api.PerpOrderPreviewSettlementTokenDecimalsEnum.number8,
    );
    return PreviewOrderResponse(
      api.OrderPreview(
        (b) => b.oneOf = OneOfDynamic(
          typeIndex: 0,
          types: const [OrderPreviewPayload],
          value: OrderPreviewPayload(
            common: value,
            fields: const {
              'kind': 'perp',
              'network': 'Hyperliquid',
              'settlement_asset': 'USDC',
            },
          ),
        ),
      ),
    );
  }

  @override
  Future<api.Order> createOrder(
    api.CreateOrderRequest request, {
    required String idempotencyKey,
  }) async {
    createWire = Map<String, Object?>.from(
      api.standardSerializers.serializeWith(
        api.CreateOrderRequest.serializer,
        request,
      ) as Map,
    );
    return api.Order(
      (b) => b
        ..orderId = 'order-1'
        ..symbol = 'TSLA'
        ..kind = api.ProductKind.perp
        ..side = api.OrderSide.long
        ..type = api.OrderType.market
        ..status = api.OrderStatus.pendingSignature
        ..createdAt = DateTime.utc(2026),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _Orders implements OrdersService {
  @override
  Future<api.Order> createOrder(
    api.CreateOrderRequest request, {
    required String idempotencyKey,
  }) async => api.Order(
    (order) => order
      ..orderId = 'order-1'
      ..symbol = 'NVDA'
      ..kind = api.ProductKind.bstock
      ..side = api.OrderSide.buy
      ..type = api.OrderType.market
      ..status = api.OrderStatus.pendingSignature
      ..quantity = '0.000000000000000001'
      ..createdAt = DateTime.utc(2026),
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
