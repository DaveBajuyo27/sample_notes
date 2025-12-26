import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sample_notes/core/error/failures.dart';
import 'package:sample_notes/core/usecases/usecase.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';
import 'package:sample_notes/features/notes/domain/repository/note_entry_repository.dart';

class CreateNoteEntry implements UseCase<NoteEntry, Params> {
  final NoteEntryRepository repository;

  CreateNoteEntry(this.repository);

  @override
  Future<Either<Failure, NoteEntry>> call(Params params) async {
    return repository.createNoteEntry(
      NoteEntry(
        id: '',
        title: params.title,
        body: params.body,
        dateCreated: DateTime.now(),
        lastUpdated: DateTime.now(),
      ),
    );
  }
}

class Params extends Equatable {
  final String title;
  final String body;

  const Params({required this.title, required this.body});

  @override
  List<Object?> get props => [title, body];
}
