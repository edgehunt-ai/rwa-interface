//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'service_environment.g.dart';

class ServiceEnvironment extends EnumClass {

  /// 服务端部署环境。`testnet` 与 `mainnet` 隔离结算资产、链 ID、 产品目录和执行资格；`development` 表示未显式声明环境的本地或 预发运行时，所有真实资产能力在该状态下保持关闭。 
  @BuiltValueEnumConst(wireName: r'development')
  static const ServiceEnvironment development = _$development;
  /// 服务端部署环境。`testnet` 与 `mainnet` 隔离结算资产、链 ID、 产品目录和执行资格；`development` 表示未显式声明环境的本地或 预发运行时，所有真实资产能力在该状态下保持关闭。 
  @BuiltValueEnumConst(wireName: r'testnet')
  static const ServiceEnvironment testnet = _$testnet;
  /// 服务端部署环境。`testnet` 与 `mainnet` 隔离结算资产、链 ID、 产品目录和执行资格；`development` 表示未显式声明环境的本地或 预发运行时，所有真实资产能力在该状态下保持关闭。 
  @BuiltValueEnumConst(wireName: r'mainnet')
  static const ServiceEnvironment mainnet = _$mainnet;
  /// 服务端部署环境。`testnet` 与 `mainnet` 隔离结算资产、链 ID、 产品目录和执行资格；`development` 表示未显式声明环境的本地或 预发运行时，所有真实资产能力在该状态下保持关闭。 
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ServiceEnvironment unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<ServiceEnvironment> get serializer => _$serviceEnvironmentSerializer;

  const ServiceEnvironment._(String name): super(name);

  static BuiltSet<ServiceEnvironment> get values => _$values;
  static ServiceEnvironment valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ServiceEnvironmentMixin = Object with _$ServiceEnvironmentMixin;

