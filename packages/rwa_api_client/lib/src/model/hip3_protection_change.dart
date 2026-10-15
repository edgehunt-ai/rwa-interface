//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_protection_modify_change.dart';
import 'package:rwa_api_client/src/model/hip3_single_protection_spec.dart';
import 'package:rwa_api_client/src/model/hip3_protection_cancel_change.dart';
import 'package:rwa_api_client/src/model/hip3_protection_create_change.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'hip3_protection_change.g.dart';

/// Hip3ProtectionChange
///
/// Properties:
/// * [operation] 
/// * [protection] 
/// * [orderId] 
@BuiltValue()
abstract class Hip3ProtectionChange implements Built<Hip3ProtectionChange, Hip3ProtectionChangeBuilder> {
  /// One Of [Hip3ProtectionCancelChange], [Hip3ProtectionCreateChange], [Hip3ProtectionModifyChange]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'operation';

  static const Map<String, Type> discriminatorMapping = {
    r'cancel': Hip3ProtectionCancelChange,
    r'create': Hip3ProtectionCreateChange,
    r'modify': Hip3ProtectionModifyChange,
  };

  Hip3ProtectionChange._();

  factory Hip3ProtectionChange([void updates(Hip3ProtectionChangeBuilder b)]) = _$Hip3ProtectionChange;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ProtectionChangeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3ProtectionChange> get serializer => _$Hip3ProtectionChangeSerializer();
}

extension Hip3ProtectionChangeDiscriminatorExt on Hip3ProtectionChange {
    String? get discriminatorValue {
        if (this is Hip3ProtectionCancelChange) {
            return r'cancel';
        }
        if (this is Hip3ProtectionCreateChange) {
            return r'create';
        }
        if (this is Hip3ProtectionModifyChange) {
            return r'modify';
        }
        return null;
    }
}
extension Hip3ProtectionChangeBuilderDiscriminatorExt on Hip3ProtectionChangeBuilder {
    String? get discriminatorValue {
        if (this is Hip3ProtectionCancelChangeBuilder) {
            return r'cancel';
        }
        if (this is Hip3ProtectionCreateChangeBuilder) {
            return r'create';
        }
        if (this is Hip3ProtectionModifyChangeBuilder) {
            return r'modify';
        }
        return null;
    }
}

class _$Hip3ProtectionChangeSerializer implements PrimitiveSerializer<Hip3ProtectionChange> {
  @override
  final Iterable<Type> types = const [Hip3ProtectionChange, _$Hip3ProtectionChange];

  @override
  final String wireName = r'Hip3ProtectionChange';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3ProtectionChange object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3ProtectionChange object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  Hip3ProtectionChange deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3ProtectionChangeBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex = serializedList.indexOf(Hip3ProtectionChange.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex], specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [Hip3ProtectionCancelChange, Hip3ProtectionCreateChange, Hip3ProtectionModifyChange, ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'cancel':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Hip3ProtectionCancelChange),
        ) as Hip3ProtectionCancelChange;
        oneOfType = Hip3ProtectionCancelChange;
        break;
      case r'create':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Hip3ProtectionCreateChange),
        ) as Hip3ProtectionCreateChange;
        oneOfType = Hip3ProtectionCreateChange;
        break;
      case r'modify':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Hip3ProtectionModifyChange),
        ) as Hip3ProtectionModifyChange;
        oneOfType = Hip3ProtectionModifyChange;
        break;
      default:
        throw UnsupportedError("Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(typeIndex: oneOfTypes.indexOf(oneOfType), types: oneOfTypes, value: oneOfResult);
    return result.build();
  }
}

class Hip3ProtectionChangeOperationEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'cancel')
  static const Hip3ProtectionChangeOperationEnum cancel = _$hip3ProtectionChangeOperationEnum_cancel;

  static Serializer<Hip3ProtectionChangeOperationEnum> get serializer => _$hip3ProtectionChangeOperationEnumSerializer;

  const Hip3ProtectionChangeOperationEnum._(String name): super(name);

  static BuiltSet<Hip3ProtectionChangeOperationEnum> get values => _$hip3ProtectionChangeOperationEnumValues;
  static Hip3ProtectionChangeOperationEnum valueOf(String name) => _$hip3ProtectionChangeOperationEnumValueOf(name);
}

