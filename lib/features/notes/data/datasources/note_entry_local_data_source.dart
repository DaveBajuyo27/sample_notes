import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:sample_notes/core/error/exceptions.dart';
import 'package:sample_notes/features/notes/data/models/note_entry_model.dart';

abstract class NoteEntryLocalDataSource {
  // TODO: add documentation
  Future<List<NoteEntryModel>> getAllNoteEntries();
  Future<NoteEntryModel> getNoteEntry(String id);
  Future<NoteEntryModel> createNoteEntry(NoteEntryModel note);
  Future<NoteEntryModel> updateNoteEntry(NoteEntryModel note);
  Future<void> deleteNoteEntry(String id);
}

@LazySingleton(as: NoteEntryLocalDataSource)
class NoteEntryLocalDataSourceImpl implements NoteEntryLocalDataSource {
  final Box<NoteEntryModel> noteBox;

  NoteEntryLocalDataSourceImpl(this.noteBox);

  @override
  Future<NoteEntryModel> createNoteEntry(NoteEntryModel note) async {
    await noteBox.put(note.id, note);

    return note;
  }

  @override
  Future<void> deleteNoteEntry(String id) async {
    await getNoteEntry(id);
    await noteBox.delete(id);
  }

  @override
  Future<List<NoteEntryModel>> getAllNoteEntries() async {
    return noteBox.values.toList();
  }

  @override
  Future<NoteEntryModel> getNoteEntry(String id) async {
    final result = noteBox.get(id);
    if (result == null) throw NoteNotFoundException();
    return result;
  }

  @override
  Future<NoteEntryModel> updateNoteEntry(NoteEntryModel note) async {
    await getNoteEntry(note.id);
    await noteBox.put(note.id, note);
    return note;
  }
}
