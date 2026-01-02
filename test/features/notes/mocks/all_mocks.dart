import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:sample_notes/features/notes/data/datasources/note_entry_local_data_source.dart';
import 'package:sample_notes/features/notes/domain/repository/note_entry_repository.dart';
import 'package:sample_notes/features/notes/domain/usecases/create_note_entry.dart';
import 'package:sample_notes/features/notes/domain/usecases/delete_note_entry.dart';
import 'package:sample_notes/features/notes/domain/usecases/get_all_note_entries.dart';
import 'package:sample_notes/features/notes/domain/usecases/get_note_entry.dart';
import 'package:sample_notes/features/notes/domain/usecases/update_note_entry.dart';

@GenerateMocks([
  HiveInterface,
  Box,
  NoteEntryLocalDataSource,
  NoteEntryRepository,
  GetAllNoteEntries,
  GetNoteEntry,
  CreateNoteEntry,
  DeleteNoteEntry,
  UpdateNoteEntry,
])
void main() {}
