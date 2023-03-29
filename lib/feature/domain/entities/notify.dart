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
  highlight}
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
}
