// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notify_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotifyModel _$NotifyModelFromJson(Map<String, dynamic> json) => NotifyModel(
      id: json['id'] as int?,
      system: json['system'] as String?,
      type: json['type'] as String?,
      notifyType: $enumDecodeNullable(_$NotifyTypeEnumMap, json['notifyType']),
      source: json['source'] as String?,
      from: json['from'] as String?,
      toUser: json['toUser'] as String?,
      toGroup: json['toGroup'] as String?,
      messageString: json['message'] as String?,
      createdAt: json['createdAt'] as String?,
      read: json['read'] as bool?,
      sourceIconURL: json['sourceIconURL'] as String?,
      sourceName: json['sourceName'] as String?,
    );

Map<String, dynamic> _$NotifyModelToJson(NotifyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'system': instance.system,
      'type': instance.type,
      'notifyType': _$NotifyTypeEnumMap[instance.notifyType],
      'source': instance.source,
      'from': instance.from,
      'toUser': instance.toUser,
      'toGroup': instance.toGroup,
      'createdAt': instance.createdAt,
      'sourceName': instance.sourceName,
      'sourceIconURL': instance.sourceIconURL,
      'read': instance.read,
      'message': instance.messageString,
    };

const _$NotifyTypeEnumMap = {
  NotifyType.notice: 'NOTICE',
  NotifyType.approval: 'APPROVAL',
  NotifyType.highlight: 'HIGHLIGHT',
};
