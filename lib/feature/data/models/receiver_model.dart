import 'package:json_annotation/json_annotation.dart';
import 'package:fii_notify/feature/domain/entities/receiver.dart';

part 'receiver_model.g.dart';
@JsonSerializable(explicitToJson: true)
class ReceiverModel extends Receiver {


  ReceiverModel({
    super.id,
    super.messageId,
    super.receiverId,
    super.receiveType,
    super.read,
    super.receiverEmpNo,
    super.receiverEmpNameVn,
    super.receiverEmpNameCn,
    super.receiverEmpMail,
    super.receiverEmpTitle,
  });

factory ReceiverModel.fromJson(Map<String, dynamic> json) => _$ReceiverModelFromJson(json);

Map<String, dynamic> toJson() => _$ReceiverModelToJson(this);

}