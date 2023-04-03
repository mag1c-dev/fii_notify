import 'package:fii_notify/feature/domain/entities/receiver.dart';

class NotifyDetail {
  final int? id;
  final String? system;
  final String? type;
  final String? source;
  final String? notifyType;
  final String? from;
  final String? toUser;
  final String? toGroup;
  final String? message;
  final String? createdAt;
  final String? updatedAt;
  final bool? read;
  final String? sourceName;
  final String? sourceIconURL;
  final List<Receiver>? receivers;

  const NotifyDetail({
    this.id,
    this.system,
    this.type,
    this.source,
    this.notifyType,
    this.from,
    this.toUser,
    this.toGroup,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.read,
    this.sourceName,
    this.sourceIconURL,
    this.receivers,
  });



}
