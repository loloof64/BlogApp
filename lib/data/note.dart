class Note {
  int id;
  DateTime modificationDate;
  final DateTime creationDate;
  String title;
  String content;

  Note({
    required this.id,
    required this.creationDate,
    required this.modificationDate,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'creationDate': creationDate.toIso8601String(),
      'modificationDate': modificationDate.toIso8601String(),
      'title': title,
      'content': content,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      creationDate: DateTime.parse(map['creationDate']),
      modificationDate: DateTime.parse(map['modificationDate']),
      title: map['title'],
      content: map['content'],
    );
  }
}
