import 'package:json_annotation/json_annotation.dart';
import 'package:fii_notify/feature/domain/entities/message.dart';

part 'message_model.g.dart';
@JsonSerializable(explicitToJson: true)
class MessageModel extends Message {
  MessageModel({super.title, super.body});



factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
