import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/file_download.dart';

part 'file_download_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FileDownloadModel extends FileDownload implements Equatable {
  const FileDownloadModel({
    required super.id,
    required super.name,
    required super.path,
    required super.url,
    super.size = 0,
    super.downloaded = 0,
    super.status = DownloadStatus.starting,
  });

  factory FileDownloadModel.fromJson(Map<String, dynamic> json) =>
      _$FileDownloadModelFromJson(json);

  FileDownloadModel copyWith({
    int? id,
    String? name,
    String? path,
    String? url,
    int? size,
    int? downloaded,
    DownloadStatus? status,
  }) {
    return FileDownloadModel(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      url: url ?? this.url,
      size: size ?? this.size,
      downloaded: downloaded ?? this.downloaded,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() => _$FileDownloadModelToJson(this);

  @override
  List<Object?> get props => [id, name, path, url, size, downloaded, status];

  @override
  bool? get stringify => null;
}
