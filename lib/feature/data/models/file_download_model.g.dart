// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_download_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileDownloadModel _$FileDownloadModelFromJson(Map<String, dynamic> json) =>
    FileDownloadModel(
      id: json['id'] as int,
      name: json['name'] as String,
      path: json['path'] as String,
      url: json['url'] as String,
      size: json['size'] as int? ?? 0,
      downloaded: json['downloaded'] as int? ?? 0,
      status: $enumDecodeNullable(_$DownloadStatusEnumMap, json['status']) ??
          DownloadStatus.starting,
    );

Map<String, dynamic> _$FileDownloadModelToJson(FileDownloadModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'path': instance.path,
      'url': instance.url,
      'size': instance.size,
      'downloaded': instance.downloaded,
      'status': _$DownloadStatusEnumMap[instance.status]!,
    };

const _$DownloadStatusEnumMap = {
  DownloadStatus.starting: 'starting',
  DownloadStatus.downloading: 'downloading',
  DownloadStatus.success: 'success',
  DownloadStatus.error: 'error',
};
