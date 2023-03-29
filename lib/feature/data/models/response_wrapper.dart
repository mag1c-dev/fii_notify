import 'package:json_annotation/json_annotation.dart';

part 'response_wrapper.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResponseWrapper<T> {
  ResponseWrapper({
    this.status,
    this.code,
    this.message,
    this.result,
    this.data,
  });

  factory ResponseWrapper.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ResponseWrapperFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ResponseWrapperToJson(this, toJsonT);

  String? status;
  String? code;
  String? message;
  T? result;
  T? data;
}
