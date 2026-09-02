import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';


/// tests for PositionsApi
void main() {
  final instance = RwaApiClient().getPositionsApi();

  group(PositionsApi, () {
    // 清除止盈止损
    //
    //Future<Position> clearPositionTpSl(String positionId, String idempotencyKey) async
    test('test clearPositionTpSl', () async {
      // TODO
    });

    // 平仓（支持部分平仓）
    //
    // HIP-3 仓位的市价 / 限价平仓，可指定数量或百分比。 bStocks 现货的「卖出」走 `POST /v1/orders`，本接口仅用于合约。 
    //
    //Future<Order> closePosition(String positionId, String idempotencyKey, ClosePositionRequest closePositionRequest) async
    test('test closePosition', () async {
      // TODO
    });

    // 仓位详情
    //
    //Future<Position> getPosition(String positionId) async
    test('test getPosition', () async {
      // TODO
    });

    // 持仓列表
    //
    // 同时返回 bStocks 现货持仓与 HIP-3 合约仓位。资产页按股票分组展示， 详情页按 `symbol` + `kind` 过滤后展示单个仓位。 
    //
    //Future<ListPositions200Response> listPositions({ String symbol, ProductKind kind, String cursor, int limit }) async
    test('test listPositions', () async {
      // TODO
    });

    // 调整杠杆 / 保证金模式
    //
    //Future<Position> updatePositionLeverage(String positionId, String idempotencyKey, UpdatePositionLeverageRequest updatePositionLeverageRequest) async
    test('test updatePositionLeverage', () async {
      // TODO
    });

    // 设置 / 修改止盈止损
    //
    // 对应「编辑止盈止损」弹窗。校验规则： Long 时 TP 需高于入场价、SL 需低于入场价；Short 反之。 传 `null` 表示清除该条件单。 
    //
    //Future<Position> updatePositionTpSl(String positionId, String idempotencyKey, TpSlUpdateRequest tpSlUpdateRequest) async
    test('test updatePositionTpSl', () async {
      // TODO
    });

  });
}
