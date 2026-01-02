import 'package:dartz/dartz.dart';
import 'package:sample_notes/core/error/failures.dart';
import 'package:sample_notes/core/usecases/usecase.dart';
import 'package:sample_notes/features/notes/domain/dto/update_note_request.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';
import 'package:sample_notes/features/notes/domain/repository/note_entry_repository.dart';

class UpdateNoteEntry extends UseCase<NoteEntry, UpdateNoteRequest> {
  final NoteEntryRepository repository;

  UpdateNoteEntry(this.repository);

  @override
  Future<Either<Failure, NoteEntry>> call(UpdateNoteRequest request) async {
    return repository.updateNoteEntry(request);
  }
}
