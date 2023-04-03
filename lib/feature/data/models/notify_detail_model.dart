import 'package:json_annotation/json_annotation.dart';
import 'package:fii_notify/feature/data/models/receiver_model.dart';
import 'package:fii_notify/feature/domain/entities/notify_detail.dart';

part 'notify_detail_model.g.dart';
@JsonSerializable(explicitToJson: true)
class NotifyDetailModel extends NotifyDetail {
  @override
  final List<ReceiverModel>? receivers;

  const NotifyDetailModel({
    super.id,
    super.system,
    super.type,
    super.source,
    super.notifyType,
    super.from,
    super.toUser,
    super.toGroup,
    super.message,
    super.createdAt,
    super.updatedAt,
    super.read,
    super.sourceName,
    super.sourceIconURL,
    this.receivers,
  }) : super(receivers: receivers);

factory NotifyDetailModel.fromJson(Map<String, dynamic> json) => _$NotifyDetailModelFromJson(json);

Map<String, dynamic> toJson() => _$NotifyDetailModelToJson(this);
}
