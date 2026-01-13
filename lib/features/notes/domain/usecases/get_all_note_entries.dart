import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sample_notes/core/error/failures.dart';
import 'package:sample_notes/core/usecases/usecase.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';
import 'package:sample_notes/features/notes/domain/repository/note_entry_repository.dart';

@lazySingleton
class GetAllNoteEntries implements UseCase<List<NoteEntry>, NoParams> {
  final NoteEntryRepository repository;

  GetAllNoteEntries(this.repository);

  @override
  Future<Either<Failure, List<NoteEntry>>> call(NoParams params) async {
    return await repository.getAllNoteEntries();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
