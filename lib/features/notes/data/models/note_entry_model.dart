import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';

class NoteEntryModel extends NoteEntry {
  const NoteEntryModel({
    required super.id,
    required super.title,
    required super.body,
    required super.dateCreated,
    required super.lastUpdated,
  });

  factory NoteEntryModel.fromJson(Map<String, dynamic> json) {
    return NoteEntryModel(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      dateCreated: DateTime.parse(json['dateCreated']),
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'body': body,
    'dateCreated': dateCreated.toIso8601String(),
    'lastUpdated': lastUpdated.toIso8601String(),
  };
}
