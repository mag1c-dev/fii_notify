// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receiver_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiverModel _$ReceiverModelFromJson(Map<String, dynamic> json) =>
    ReceiverModel(
      id: json['id'] as int?,
      messageId: json['messageId'] as int?,
      receiverId: json['receiverId'] as int?,
      receiveType: json['receiveType'] as String?,
      read: json['read'] as bool?,
      receiverEmpNo: json['receiverEmpNo'] as String?,
      receiverEmpNameVn: json['receiverEmpNameVn'] as String?,
      receiverEmpNameCn: json['receiverEmpNameCn'] as String?,
      receiverEmpMail: json['receiverEmpMail'] as String?,
      receiverEmpTitle: json['receiverEmpTitle'] as String?,
    );

Map<String, dynamic> _$ReceiverModelToJson(ReceiverModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'messageId': instance.messageId,
      'receiverId': instance.receiverId,
      'receiveType': instance.receiveType,
      'read': instance.read,
      'receiverEmpNo': instance.receiverEmpNo,
      'receiverEmpNameVn': instance.receiverEmpNameVn,
      'receiverEmpNameCn': instance.receiverEmpNameCn,
      'receiverEmpMail': instance.receiverEmpMail,
      'receiverEmpTitle': instance.receiverEmpTitle,
    };
