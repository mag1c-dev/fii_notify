class AppInformation {
  final int? id;
  final String? groupName;
  final String? appName;
  final String? name;
  final String? description;
  final String? version;
  final String? minVersion;
  final String? maxVersion;
  final String? androidSchemaMapping;
  final String? iosSchemaMapping;
  final String? iconURL;
  final String? bannerURL;
  final List<String>? imageURLList;
  final int? usingMode;
  final bool? supportMobile;
  final bool? supportAgent;
  final bool? supportDesktop;
  final bool? defaultAdded;
  final int? status;
  final String? androidDownloadURL;
  final String? iosDownloadURL;
  final String? webViewURL;
  final String? changeLogs;

  const AppInformation({
    this.id,
    this.groupName,
    this.appName,
    this.name,
    this.description,
    this.version,
    this.minVersion,
    this.maxVersion,
    this.androidSchemaMapping,
    this.iosSchemaMapping,
    this.iconURL,
    this.bannerURL,
    this.imageURLList,
    this.usingMode,
    this.supportMobile,
    this.supportAgent,
    this.supportDesktop,
    this.defaultAdded,
    this.status,
    this.androidDownloadURL,
    this.iosDownloadURL,
    this.webViewURL,
    this.changeLogs,
  });
}
