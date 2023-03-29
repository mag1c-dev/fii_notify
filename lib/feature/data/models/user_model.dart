import 'package:fii_notify/feature/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel extends User {

  UserModel({
    super.id,
    super.username,
    super.name,
    super.chineseName,
    super.nickName,
    super.email,
    super.callNumber,
    super.bu,
    super.cft,
    super.factory,
    super.department,
    super.title,
    super.level,
    super.ouCode,
    super.ouName,
    super.allManagers,
  });



  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);




  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
