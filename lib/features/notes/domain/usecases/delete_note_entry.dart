import 'package:dartz/dartz.dart';
import 'package:sample_notes/core/error/failures.dart';
import 'package:sample_notes/core/usecases/usecase.dart';
import 'package:sample_notes/features/notes/domain/repository/note_entry_repository.dart';

class DeleteNoteEntry implements UseCase<void, String> {
  final NoteEntryRepository repository;

  DeleteNoteEntry(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) {
    return repository.deleteNoteEntry(id);
  }
}
