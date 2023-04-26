import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/app_information.dart';

part 'app_information_model.g.dart';
@JsonSerializable(explicitToJson: true)
class AppInformationModel extends AppInformation {

  const AppInformationModel({
  super.id,
  super.groupName,
  super.appName,
  super.name,
  super.description,
  super.version,
  super.minVersion,
  super.maxVersion,
  super.androidSchemaMapping,
  super.iosSchemaMapping,
  super.iconURL,
  super.bannerURL,
  super.imageURLList,
  super.usingMode,
  super.supportMobile,
  super.supportAgent,
  super.supportDesktop,
  super.defaultAdded,
  super.status,
  super.androidDownloadURL,
  super.iosDownloadURL,
  super.webViewURL,
  super.changeLogs,

  });

  factory AppInformationModel.fromJson(Map<String, dynamic> json) => _$AppInformationModelFromJson(json);

Map<String, dynamic> toJson() => _$AppInformationModelToJson(this);


}