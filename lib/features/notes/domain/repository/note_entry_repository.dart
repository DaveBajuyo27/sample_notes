import 'package:dartz/dartz.dart';
import 'package:sample_notes/core/error/failures.dart';
import 'package:sample_notes/features/notes/domain/dto/create_note_request.dart';
import 'package:sample_notes/features/notes/domain/dto/update_note_request.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';

abstract class NoteEntryRepository {
  Future<Either<Failure, List<NoteEntry>>> getAllNoteEntries();
  Future<Either<Failure, NoteEntry>> getNoteEntry(String id);
  Future<Either<Failure, NoteEntry>> createNoteEntry(CreateNoteRequest request);
  Future<Either<Failure, NoteEntry>> updateNoteEntry(UpdateNoteRequest request);
  Future<Either<Failure, void>> deleteNoteEntry(String id);
}
