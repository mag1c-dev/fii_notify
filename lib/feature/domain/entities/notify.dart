import 'package:fii_notify/feature/domain/entities/message.dart';
import 'package:json_annotation/json_annotation.dart';

enum NotifyType {
  @JsonValue(null)
  all,
  @JsonValue('NOTICE')
  notice,
  @JsonValue('APPROVAL')
  approval,
  @JsonValue('HIGHLIGHT')
  highlight
}
extension NotifyTypeExt on NotifyType {
  String? get json => _$NotifyTypeEnumMap[this];

  static const _$NotifyTypeEnumMap = {
    NotifyType.notice: 'NOTICE',
    NotifyType.approval: 'APPROVAL',
    NotifyType.highlight: 'HIGHLIGHT',
  };
  String get vnName {
    switch (this) {
      case NotifyType.all:
        return 'Tất cả thông báo';
      case NotifyType.notice:
        return 'Thông báo';
      case NotifyType.approval:
        return 'Ký duyệt';
      case NotifyType.highlight:
        return 'Cảnh báo';
    }
  }

}

class Notify {
  int? id;
  String? system;
  String? type;
  NotifyType? notifyType;
  String? source;
  String? from;
  String? toUser;
  String? toGroup;
  @JsonKey(includeFromJson: false)
  Message? message;
  String? createdAt;
  String? sourceName;
  String? sourceIconURL;
  bool? read;

  Notify({
    this.id,
    this.system,
    this.type,
    this.notifyType,
    this.source,
    this.from,
    this.toUser,
    this.toGroup,
    this.message,
    this.createdAt,
    this.read,
    this.sourceName,
    this.sourceIconURL,
  });

  Notify copyWith({
    int? id,
    String? system,
    String? type,
    NotifyType? notifyType,
    String? source,
    String? from,
    String? toUser,
    String? toGroup,
    Message? message,
    String? createdAt,
    String? sourceName,
    String? sourceIconURL,
    bool? read,
  }) {
    return Notify(
      id: id ?? this.id,
      system: system ?? this.system,
      type: type ?? this.type,
      notifyType: notifyType ?? this.notifyType,
      source: source ?? this.source,
      from: from ?? this.from,
      toUser: toUser ?? this.toUser,
      toGroup: toGroup ?? this.toGroup,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      sourceName: sourceName ?? this.sourceName,
      sourceIconURL: sourceIconURL ?? this.sourceIconURL,
      read: read ?? this.read,
    );
  }
}
