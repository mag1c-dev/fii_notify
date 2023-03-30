import 'package:json_annotation/json_annotation.dart';

class Source {
  final int id;
  final  String source;
  final  String? sourceName;
  final  String? sourceIconURL;

  const Source( {
    required this.id,
    required this.source,
     this.sourceName,
     this.sourceIconURL,
  });

  Source copyWith({
    int? id,
    String? source,
    String? sourceName,
    String? sourceIconURL,
  }) {
    return Source(
      id: id ?? this.id,
      source: source ?? this.source,
      sourceName: sourceName ?? this.sourceName,
      sourceIconURL: sourceIconURL ?? this.sourceIconURL,
    );
  }
}