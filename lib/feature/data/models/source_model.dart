import 'package:json_annotation/json_annotation.dart';
import 'package:fii_notify/feature/domain/entities/source.dart';

part 'source_model.g.dart';
@JsonSerializable(explicitToJson: true)
class SourceModel extends Source {
  const SourceModel({
    required super.id,
    required super.source,
    super.sourceName,
    super.sourceIconURL,
    super.selected,
  });

factory SourceModel.fromJson(Map<String, dynamic> json) => _$SourceModelFromJson(json);

Map<String, dynamic> toJson() => _$SourceModelToJson(this);
}