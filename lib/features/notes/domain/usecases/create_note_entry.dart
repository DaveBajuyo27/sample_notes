import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sample_notes/core/error/failures.dart';
import 'package:sample_notes/core/usecases/usecase.dart';
import 'package:sample_notes/features/notes/domain/dto/create_note_request.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';
import 'package:sample_notes/features/notes/domain/repository/note_entry_repository.dart';

class CreateNoteEntry implements UseCase<NoteEntry, CreateNoteRequest> {
  final NoteEntryRepository repository;

  CreateNoteEntry(this.repository);

  @override
  Future<Either<Failure, NoteEntry>> call(CreateNoteRequest request) async {
    return repository.createNoteEntry(request);
  }
}
