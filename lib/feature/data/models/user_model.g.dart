// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int?,
      username: json['username'] as String?,
      name: json['name'] as String?,
      chineseName: json['chineseName'] as String?,
      nickName: json['nickName'] as String?,
      email: json['email'] as String?,
      callNumber: json['callNumber'] as String?,
      bu: json['bu'] as String?,
      cft: json['cft'] as String?,
      factory: json['factory'] as String?,
      department: json['department'] as String?,
      title: json['title'] as String?,
      level: json['level'] as String?,
      ouCode: json['ouCode'] as String?,
      ouName: json['ouName'] as String?,
      allManagers: json['allManagers'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'chineseName': instance.chineseName,
      'nickName': instance.nickName,
      'email': instance.email,
      'callNumber': instance.callNumber,
      'bu': instance.bu,
      'cft': instance.cft,
      'factory': instance.factory,
      'department': instance.department,
      'title': instance.title,
      'level': instance.level,
      'ouCode': instance.ouCode,
      'ouName': instance.ouName,
      'allManagers': instance.allManagers,
    };
