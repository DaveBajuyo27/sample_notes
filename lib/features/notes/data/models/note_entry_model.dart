import 'package:hive/hive.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';

@HiveType(typeId: 0)
class NoteEntryModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String body;
  @HiveField(3)
  final DateTime dateCreated;
  @HiveField(4)
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
