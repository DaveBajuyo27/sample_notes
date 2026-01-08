import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';

class NoteEntryModel {
  final String id;
  final String title;
  final String body;
  final DateTime dateCreated;
  final DateTime lastUpdated;

  NoteEntryModel({
    required this.id,
    required this.title,
    required this.body,
    required this.dateCreated,
    required this.lastUpdated,
  });

  NoteEntry toEntity() => NoteEntry(
    id: id,
    title: title,
    body: body,
    dateCreated: dateCreated,
    lastUpdated: lastUpdated,
  );

  factory NoteEntryModel.fromEntity(NoteEntry note) => NoteEntryModel(
    id: note.id,
    title: note.title,
    body: note.body,
    dateCreated: note.dateCreated,
    lastUpdated: note.lastUpdated,
  );
}
