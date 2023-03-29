import 'dart:convert';

import 'package:fii_notify/feature/data/models/message_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:fii_notify/feature/domain/entities/notify.dart';


part 'notify_model.g.dart';


@JsonSerializable(explicitToJson: true)
class NotifyModel extends Notify {
  @JsonKey(name: 'message')
  final String? messageString;

  NotifyModel({
    super.id,
    super.system,
    super.type,
    super.notifyType,
    super.source,
    super.from,
    super.toUser,
    super.toGroup,
    this.messageString,
    super.createdAt,
    super.read,
    super.sourceIconURL,
    super.sourceName,
  });

  factory NotifyModel.fromJson(Map<String, dynamic> json) =>
      _$NotifyModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotifyModelToJson(this);

  Notify toEntity() => Notify(
        source: source,
        type: type,
    notifyType: notifyType,
        createdAt: createdAt,
        from: from,
        id: id,
        message: _messageFromString(),
        read: read,
        system: system,
        toGroup: toGroup,
        toUser: toUser,
        sourceIconURL: sourceIconURL,
        sourceName: sourceName,
      );

  MessageModel? _messageFromString() {
    try {
      return MessageModel.fromJson(jsonDecode(messageString!));
    } catch (_) {
      return null;
    }
  }
}
