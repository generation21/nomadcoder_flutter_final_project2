// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BoardModel _$BoardModelFromJson(Map<String, dynamic> json) => _BoardModel(
  id: json['id'] as String? ?? '',
  mood: json['mood'] as String? ?? '',
  text: json['text'] as String? ?? '',
  relative_time: json['relative_time'] as String? ?? '',
);

Map<String, dynamic> _$BoardModelToJson(_BoardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mood': instance.mood,
      'text': instance.text,
      'relative_time': instance.relative_time,
    };
