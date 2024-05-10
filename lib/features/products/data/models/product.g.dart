// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductModelImpl _$$ProductModelImplFromJson(Map<String, dynamic> json) =>
    _$ProductModelImpl(
      id: (json['id'] as num).toInt(),
      createdAt: json['created_at'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'image': instance.image,
    };
