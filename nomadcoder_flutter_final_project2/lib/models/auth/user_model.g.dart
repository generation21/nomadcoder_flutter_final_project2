// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUserModel _$AppUserModelFromJson(Map<String, dynamic> json) =>
    _AppUserModel(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );

Map<String, dynamic> _$AppUserModelToJson(_AppUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
