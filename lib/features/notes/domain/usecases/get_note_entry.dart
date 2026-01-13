import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sample_notes/core/error/failures.dart';
import 'package:sample_notes/core/usecases/usecase.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';
import 'package:sample_notes/features/notes/domain/repository/note_entry_repository.dart';

@lazySingleton
class GetNoteEntry extends UseCase<NoteEntry, String> {
  final NoteEntryRepository repository;

  GetNoteEntry(this.repository);

  @override
  Future<Either<Failure, NoteEntry>> call(String id) async {
    return await repository.getNoteEntry(id);
  }
}
