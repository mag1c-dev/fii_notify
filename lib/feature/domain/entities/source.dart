import 'package:json_annotation/json_annotation.dart';

class Source {
  final int id;
  final  String source;
  final  String? sourceName;
  final  String? sourceIconURL;
  @JsonKey(includeFromJson: false)
  final  bool selected;

  const Source( {
    required this.id,
    required this.source,
     this.sourceName,
     this.sourceIconURL,
    this.selected=false,
  });
}