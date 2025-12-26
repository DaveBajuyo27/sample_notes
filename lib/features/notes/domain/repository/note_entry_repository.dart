import 'package:dartz/dartz.dart';
import 'package:sample_notes/core/error/failures.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';

abstract class NoteEntryRepository {
  Future<Either<Failure, List<NoteEntry>>> getAllNoteEntries();
  Future<Either<Failure, NoteEntry>> getNoteEntry(String id);
  Future<Either<Failure, NoteEntry>> createNoteEntry(NoteEntry note);
  Future<Either<Failure, NoteEntry>> updateNoteEntry(NoteEntry note);
  Future<Either<Failure, void>> deleteNoteEntry(String id);
}
