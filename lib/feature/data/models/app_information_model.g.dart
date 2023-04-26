// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppInformationModel _$AppInformationModelFromJson(Map<String, dynamic> json) =>
    AppInformationModel(
      id: json['id'] as int?,
      groupName: json['groupName'] as String?,
      appName: json['appName'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      version: json['version'] as String?,
      minVersion: json['minVersion'] as String?,
      maxVersion: json['maxVersion'] as String?,
      androidSchemaMapping: json['androidSchemaMapping'] as String?,
      iosSchemaMapping: json['iosSchemaMapping'] as String?,
      iconURL: json['iconURL'] as String?,
      bannerURL: json['bannerURL'] as String?,
      imageURLList: (json['imageURLList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      usingMode: json['usingMode'] as int?,
      supportMobile: json['supportMobile'] as bool?,
      supportAgent: json['supportAgent'] as bool?,
      supportDesktop: json['supportDesktop'] as bool?,
      defaultAdded: json['defaultAdded'] as bool?,
      status: json['status'] as int?,
      androidDownloadURL: json['androidDownloadURL'] as String?,
      iosDownloadURL: json['iosDownloadURL'] as String?,
      webViewURL: json['webViewURL'] as String?,
      changeLogs: json['changeLogs'] as String?,
    );

Map<String, dynamic> _$AppInformationModelToJson(
        AppInformationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupName': instance.groupName,
      'appName': instance.appName,
      'name': instance.name,
      'description': instance.description,
      'version': instance.version,
      'minVersion': instance.minVersion,
      'maxVersion': instance.maxVersion,
      'androidSchemaMapping': instance.androidSchemaMapping,
      'iosSchemaMapping': instance.iosSchemaMapping,
      'iconURL': instance.iconURL,
      'bannerURL': instance.bannerURL,
      'imageURLList': instance.imageURLList,
      'usingMode': instance.usingMode,
      'supportMobile': instance.supportMobile,
      'supportAgent': instance.supportAgent,
      'supportDesktop': instance.supportDesktop,
      'defaultAdded': instance.defaultAdded,
      'status': instance.status,
      'androidDownloadURL': instance.androidDownloadURL,
      'iosDownloadURL': instance.iosDownloadURL,
      'webViewURL': instance.webViewURL,
      'changeLogs': instance.changeLogs,
    };
