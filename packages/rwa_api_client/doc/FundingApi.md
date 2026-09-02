# rwa_api_client.api.FundingApi

## Load the API package
```dart
import 'package:rwa_api_client/api.dart';
```

All URIs are relative to *https://rwa-api-staging.dxd.ink*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createDeposit**](FundingApi.md#createdeposit) | **POST** /v1/deposits | 创建入金意图
[**createFundingPlan**](FundingApi.md#createfundingplan) | **POST** /v1/funding/plans | 创建资金准备计划
[**createTransfer**](FundingApi.md#createtransfer) | **POST** /v1/transfers | 按资金计划创建划转
[**createTransferClaim**](FundingApi.md#createtransferclaim) | **POST** /v1/transfers/{transfer_id}/claims | 为需要恢复的划转创建 Claim
[**createWithdrawal**](FundingApi.md#createwithdrawal) | **POST** /v1/withdrawals | 创建提现
[**createWithdrawalQuote**](FundingApi.md#createwithdrawalquote) | **POST** /v1/withdrawal-quotes | 创建提现报价
[**getDeposit**](FundingApi.md#getdeposit) | **GET** /v1/deposits/{deposit_id} | 入金详情与权威状态
[**getFundingCatalog**](FundingApi.md#getfundingcatalog) | **GET** /v1/funding/catalog | 资金网络与结算资产目录
[**getFundingPlan**](FundingApi.md#getfundingplan) | **GET** /v1/funding/plans/{plan_id} | 资金准备计划详情与权威状态
[**getTransfer**](FundingApi.md#gettransfer) | **GET** /v1/transfers/{transfer_id} | 划转详情与权威状态
[**getWithdrawal**](FundingApi.md#getwithdrawal) | **GET** /v1/withdrawals/{withdrawal_id} | 提现详情与权威状态
[**listDeposits**](FundingApi.md#listdeposits) | **GET** /v1/deposits | 入金记录列表
[**listWithdrawals**](FundingApi.md#listwithdrawals) | **GET** /v1/withdrawals | 提现列表


# **createDeposit**
> Deposit createDeposit(idempotencyKey, createDepositIntentRequest)

创建入金意图

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getFundingApi();
final String idempotencyKey = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
final CreateDepositIntentRequest createDepositIntentRequest = ; // CreateDepositIntentRequest | 

try {
    final response = api.createDeposit(idempotencyKey, createDepositIntentRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FundingApi->createDeposit: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **idempotencyKey** | **String**| Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409. | 
 **createDepositIntentRequest** | [**CreateDepositIntentRequest**](CreateDepositIntentRequest.md)|  | 

### Return type

[**Deposit**](Deposit.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createFundingPlan**
> FundingPlan createFundingPlan(idempotencyKey, fundingPlanRequest)

创建资金准备计划

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getFundingApi();
final String idempotencyKey = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
final FundingPlanRequest fundingPlanRequest = ; // FundingPlanRequest | 

try {
    final response = api.createFundingPlan(idempotencyKey, fundingPlanRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FundingApi->createFundingPlan: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **idempotencyKey** | **String**| Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409. | 
 **fundingPlanRequest** | [**FundingPlanRequest**](FundingPlanRequest.md)|  | 

### Return type

[**FundingPlan**](FundingPlan.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createTransfer**
> Transfer createTransfer(idempotencyKey, transferRequest)

按资金计划创建划转

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getFundingApi();
final String idempotencyKey = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
final TransferRequest transferRequest = ; // TransferRequest | 

try {
    final response = api.createTransfer(idempotencyKey, transferRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FundingApi->createTransfer: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **idempotencyKey** | **String**| Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409. | 
 **transferRequest** | [**TransferRequest**](TransferRequest.md)|  | 

### Return type

[**Transfer**](Transfer.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createTransferClaim**
> Claim createTransferClaim(transferId, idempotencyKey, transferClaimRequest)

为需要恢复的划转创建 Claim

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getFundingApi();
final String transferId = transferId_example; // String | 
final String idempotencyKey = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
final TransferClaimRequest transferClaimRequest = ; // TransferClaimRequest | 

try {
    final response = api.createTransferClaim(transferId, idempotencyKey, transferClaimRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FundingApi->createTransferClaim: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **transferId** | **String**|  | 
 **idempotencyKey** | **String**| Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409. | 
 **transferClaimRequest** | [**TransferClaimRequest**](TransferClaimRequest.md)|  | 

### Return type

[**Claim**](Claim.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createWithdrawal**
> Withdrawal createWithdrawal(idempotencyKey, createWithdrawalRequest)

创建提现

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getFundingApi();
final String idempotencyKey = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
final CreateWithdrawalRequest createWithdrawalRequest = ; // CreateWithdrawalRequest | 

try {
    final response = api.createWithdrawal(idempotencyKey, createWithdrawalRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FundingApi->createWithdrawal: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **idempotencyKey** | **String**| Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409. | 
 **createWithdrawalRequest** | [**CreateWithdrawalRequest**](CreateWithdrawalRequest.md)|  | 

### Return type

[**Withdrawal**](Withdrawal.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createWithdrawalQuote**
> WithdrawalQuote createWithdrawalQuote(idempotencyKey, withdrawalQuoteRequest)

创建提现报价

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getFundingApi();
final String idempotencyKey = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
final WithdrawalQuoteRequest withdrawalQuoteRequest = ; // WithdrawalQuoteRequest | 

try {
    final response = api.createWithdrawalQuote(idempotencyKey, withdrawalQuoteRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FundingApi->createWithdrawalQuote: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **idempotencyKey** | **String**| Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409. | 
 **withdrawalQuoteRequest** | [**WithdrawalQuoteRequest**](WithdrawalQuoteRequest.md)|  | 

### Return type

[**WithdrawalQuote**](WithdrawalQuote.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDeposit**
> Deposit getDeposit(depositId)

入金详情与权威状态

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getFundingApi();
final String depositId = depositId_example; // String | 

try {
    final response = api.getDeposit(depositId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FundingApi->getDeposit: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **depositId** | **String**|  | 

### Return type

[**Deposit**](Deposit.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFundingCatalog**
> FundingCatalog getFundingCatalog()

资金网络与结算资产目录

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getFundingApi();

try {
    final response = api.getFundingCatalog();
    print(response);
} on DioException catch (e) {
    print('Exception when calling FundingApi->getFundingCatalog: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**FundingCatalog**](FundingCatalog.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFundingPlan**
> FundingPlan getFundingPlan(planId)

资金准备计划详情与权威状态

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getFundingApi();
final String planId = planId_example; // String | 

try {
    final response = api.getFundingPlan(planId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FundingApi->getFundingPlan: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **planId** | **String**|  | 

### Return type

[**FundingPlan**](FundingPlan.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTransfer**
> Transfer getTransfer(transferId)

划转详情与权威状态

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getFundingApi();
final String transferId = transferId_example; // String | 

try {
    final response = api.getTransfer(transferId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FundingApi->getTransfer: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **transferId** | **String**|  | 

### Return type

[**Transfer**](Transfer.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getWithdrawal**
> Withdrawal getWithdrawal(withdrawalId)

提现详情与权威状态

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getFundingApi();
final String withdrawalId = withdrawalId_example; // String | 

try {
    final response = api.getWithdrawal(withdrawalId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FundingApi->getWithdrawal: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **withdrawalId** | **String**|  | 

### Return type

[**Withdrawal**](Withdrawal.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listDeposits**
> ListDeposits200Response listDeposits(cursor, limit)

入金记录列表

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getFundingApi();
final String cursor = cursor_example; // String | 上一页返回的 `next_cursor`
final int limit = 56; // int | 

try {
    final response = api.listDeposits(cursor, limit);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FundingApi->listDeposits: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**| 上一页返回的 `next_cursor` | [optional] 
 **limit** | **int**|  | [optional] [default to 20]

### Return type

[**ListDeposits200Response**](ListDeposits200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listWithdrawals**
> ListWithdrawals200Response listWithdrawals(cursor, limit)

提现列表

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getFundingApi();
final String cursor = cursor_example; // String | 上一页返回的 `next_cursor`
final int limit = 56; // int | 

try {
    final response = api.listWithdrawals(cursor, limit);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FundingApi->listWithdrawals: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**| 上一页返回的 `next_cursor` | [optional] 
 **limit** | **int**|  | [optional] [default to 20]

### Return type

[**ListWithdrawals200Response**](ListWithdrawals200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

