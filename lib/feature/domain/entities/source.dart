
class Source {
  final int id;
  final  String source;
  final  String? sourceName;
  final  String? sourceIconURL;
  final  int unreadNumber;

  const Source({
    required this.id,
    required this.source,
     this.sourceName,
     this.sourceIconURL,
    this.unreadNumber = 0,  });

  Source copyWith({
    int? id,
    String? source,
    String? sourceName,
    String? sourceIconURL,
    int? unreadNumber,
  }) {
    return Source(
      id: id ?? this.id,
      source: source ?? this.source,
      sourceName: sourceName ?? this.sourceName,
      sourceIconURL: sourceIconURL ?? this.sourceIconURL,
      unreadNumber: unreadNumber ?? this.unreadNumber,
    );
  }
}