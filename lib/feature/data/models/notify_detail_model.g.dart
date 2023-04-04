// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notify_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotifyDetailModel _$NotifyDetailModelFromJson(Map<String, dynamic> json) =>
    NotifyDetailModel(
      id: json['id'] as int?,
      system: json['system'] as String?,
      type: json['type'] as String?,
      source: json['source'] as String?,
      notifyType: json['notifyType'] as String?,
      from: json['from'] as String?,
      toUser: json['toUser'] as String?,
      toGroup: json['toGroup'] as String?,
      message: json['message'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      read: json['read'] as bool?,
      sourceName: json['sourceName'] as String?,
      sourceIconURL: json['sourceIconURL'] as String?,
      receivers: (json['receivers'] as List<dynamic>?)
          ?.map((e) => ReceiverModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotifyDetailModelToJson(NotifyDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'system': instance.system,
      'type': instance.type,
      'source': instance.source,
      'notifyType': instance.notifyType,
      'from': instance.from,
      'toUser': instance.toUser,
      'toGroup': instance.toGroup,
      'message': instance.message,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'read': instance.read,
      'sourceName': instance.sourceName,
      'sourceIconURL': instance.sourceIconURL,
      'receivers': instance.receivers?.map((e) => e.toJson()).toList(),
    };
