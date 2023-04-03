// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceModel _$SourceModelFromJson(Map<String, dynamic> json) => SourceModel(
      id: json['id'] as int,
      source: json['source'] as String,
      sourceName: json['sourceName'] as String?,
      sourceIconURL: json['sourceIconURL'] as String?,
      unreadNumber: (json['unreadNumber'] as int?)??0,
    );

Map<String, dynamic> _$SourceModelToJson(SourceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'source': instance.source,
      'sourceName': instance.sourceName,
      'sourceIconURL': instance.sourceIconURL,
      'unreadNumber': instance.unreadNumber,
    };
