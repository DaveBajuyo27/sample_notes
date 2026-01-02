import 'package:dartz/dartz.dart';
import 'package:sample_notes/core/error/exceptions.dart';
import 'package:sample_notes/core/error/failures.dart';
import 'package:sample_notes/features/notes/data/datasources/note_entry_local_data_source.dart';
import 'package:sample_notes/features/notes/data/models/note_entry_model.dart';
import 'package:sample_notes/features/notes/domain/dto/create_note_request.dart';
import 'package:sample_notes/features/notes/domain/dto/update_note_request.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';
import 'package:sample_notes/features/notes/domain/repository/note_entry_repository.dart';
import 'package:uuid/uuid.dart';

class NoteEntryRepositoryImpl implements NoteEntryRepository {
  final NoteEntryLocalDataSource dataSource;

  NoteEntryRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, NoteEntry>> createNoteEntry(
    CreateNoteRequest request,
  ) async {
    try {
      final now = DateTime.now();
      final NoteEntryModel noteToCreate = NoteEntryModel(
        id: const Uuid().v4(),
        title: request.title,
        body: request.body,
        dateCreated: now,
        lastUpdated: now,
      );
      final createdNode = await dataSource.createNoteEntry(noteToCreate);
      return Right(createdNode.toEntity());
    } on LocalStorageException {
      return Left(LocalStorageFailure());
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteNoteEntry(String id) async {
    try {
      await dataSource.deleteNoteEntry(id);
      return Right(null);
    } on LocalStorageException {
      return Left(LocalStorageFailure());
    } on NoteNotFoundException {
      return Left(NoteNotFoundFailure());
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, List<NoteEntry>>> getAllNoteEntries() async {
    try {
      final noteList = await dataSource.getAllNoteEntries();
      final newList = noteList.map((e) => e.toEntity()).toList();
      return Right(newList);
    } on LocalStorageException {
      return Left(LocalStorageFailure());
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, NoteEntry>> getNoteEntry(String id) async {
    try {
      final fetchedNote = await dataSource.getNoteEntry(id);
      return Right(fetchedNote.toEntity());
    } on LocalStorageException {
      return Left(LocalStorageFailure());
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, NoteEntry>> updateNoteEntry(
    UpdateNoteRequest request,
  ) async {
    try {
      // fetch note to edit and validation
      final noteToEdit = (await getNoteEntry(
        request.id,
      )).getOrElse(() => throw NoteNotFoundException());

      final now = DateTime.now();
      final NoteEntryModel noteToSubmit = NoteEntryModel(
        id: noteToEdit.id,
        title: request.title ?? noteToEdit.title,
        body: request.body ?? noteToEdit.body,
        dateCreated: noteToEdit.dateCreated,
        lastUpdated: now,
      );
      final updatedNote = await dataSource.updateNoteEntry(noteToSubmit);
      return Right(updatedNote.toEntity());
    } on LocalStorageException {
      return Left(LocalStorageFailure());
    } on NoteNotFoundException {
      return Left(NoteNotFoundFailure());
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }
}
