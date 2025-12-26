import 'package:dartz/dartz.dart';
import 'package:sample_notes/core/error/failures.dart';
import 'package:sample_notes/core/usecases/usecase.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';
import 'package:sample_notes/features/notes/domain/repository/note_entry_repository.dart';

class UpdateNoteEntry extends UseCase<NoteEntry, NoteEntry> {
  final NoteEntryRepository repository;

  UpdateNoteEntry(this.repository);

  @override
  Future<Either<Failure, NoteEntry>> call(NoteEntry note) async {
    return repository.updateNoteEntry(note);
  }
}
