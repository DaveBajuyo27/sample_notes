import 'package:sample_notes/features/notes/data/models/note_entry_model.dart';

abstract class NoteEntryLocalDataSource {
  // TODO: add documentation
  Future<List<NoteEntryModel>> getAllNoteEntries();
  Future<NoteEntryModel> getNoteEntry(String id);
  Future<NoteEntryModel> createNoteEntry(NoteEntryModel note);
  Future<NoteEntryModel> updateNoteEntry(NoteEntryModel note);
  Future<void> deleteNoteEntry(String id);
}
