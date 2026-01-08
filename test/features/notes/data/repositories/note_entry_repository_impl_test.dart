import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sample_notes/core/error/exceptions.dart';
import 'package:sample_notes/core/error/failures.dart';
import 'package:sample_notes/features/notes/data/models/note_entry_model.dart';
import 'package:sample_notes/features/notes/data/repositories/note_entry_repository_impl.dart';
import 'package:sample_notes/features/notes/domain/dto/create_note_request.dart';
import 'package:sample_notes/features/notes/domain/dto/update_note_request.dart';

import '../../mocks/all_mocks.mocks.dart';

void main() {
  late NoteEntryRepositoryImpl repository;
  late MockNoteEntryLocalDataSource localDataSource;

  setUp(() {
    localDataSource = MockNoteEntryLocalDataSource();
    repository = NoteEntryRepositoryImpl(localDataSource);
  });

  final fixedDate = DateTime(2024, 1, 1);
  final NoteEntryModel note = NoteEntryModel(
    id: 'id123',
    title: 'sample title',
    body: 'sample body',
    dateCreated: fixedDate,
    lastUpdated: fixedDate,
  );

  group('create note entry', () {
    test(
      'should return a NoteEntry when creating a note succesfully',
      () async {
        // arrange
        when(
          localDataSource.createNoteEntry(any),
        ).thenAnswer((_) async => note);

        // action
        final result = await repository.createNoteEntry(
          CreateNoteRequest(title: 'sample title', body: 'sample body'),
        );

        // assert
        result.fold((failure) => fail('Expected Right but got $failure'), (
          createdNote,
        ) {
          expect(createdNote, note.toEntity());
        });

        verify(localDataSource.createNoteEntry(any));
        verifyNoMoreInteractions(localDataSource);
      },
    );
    test(
      'should return a LocalStorageFailure when a LocalStorageException occurs during note creation',
      () async {
        // arrange
        when(
          localDataSource.createNoteEntry(any),
        ).thenThrow(LocalStorageException());
        // action
        final result = await repository.createNoteEntry(
          CreateNoteRequest(title: 'sample title', body: 'sample body'),
        );
        // assert
        result.fold((failure) => expect(failure, isA<LocalStorageFailure>()), (
          createdNote,
        ) {
          fail(
            'expected to throw exception but got note titled=${createdNote.title} instead',
          );
        });

        verify(localDataSource.createNoteEntry(any));
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'should return an UnexpectedFailure when any Exception occurs during note creation',
      () async {
        // arrange
        when(localDataSource.createNoteEntry(any)).thenThrow(Exception());
        // action
        final result = await repository.createNoteEntry(
          CreateNoteRequest(title: 'sample title', body: 'sample body'),
        );
        // assert
        result.fold((failure) => expect(failure, isA<UnexpectedFailure>()), (
          createdNote,
        ) {
          fail(
            'expected to throw exception but got note titled=${createdNote.title} instead',
          );
        });

        verify(localDataSource.createNoteEntry(any));
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });

  group('delete note entry', () {
    test('should delete a NoteEntry succesfully', () async {
      // arrange
      when(localDataSource.deleteNoteEntry(any)).thenAnswer((_) async {});

      // action
      final result = await repository.deleteNoteEntry('sampleId');

      // assert
      result.fold((failure) => fail('Expected Right but got $failure'), (
        createdNote,
      ) {
        expect(true, true);
      });

      verify(localDataSource.deleteNoteEntry(any));
      verifyNoMoreInteractions(localDataSource);
    });
    test(
      'should return a LocalStorageFailure when an Exception occurs during note deletion',
      () async {
        // arrange
        when(
          localDataSource.deleteNoteEntry(any),
        ).thenThrow(LocalStorageException());
        // action
        final result = await repository.deleteNoteEntry('sampleId');
        // assert
        result.fold((failure) => expect(failure, isA<LocalStorageFailure>()), (
          deletedNote,
        ) {
          fail('expected to throw exception but got something instead');
        });

        verify(localDataSource.deleteNoteEntry(any));
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'should return a NoteNotFoundFailure when note to delete doesnt exist',
      () async {
        // arrange
        when(
          localDataSource.deleteNoteEntry(any),
        ).thenThrow(NoteNotFoundException());
        // action
        final result = await repository.deleteNoteEntry('sampleId');
        // assert
        result.fold((failure) => expect(failure, isA<NoteNotFoundFailure>()), (
          deletedNote,
        ) {
          fail('expected to throw exception but got something instead');
        });

        verify(localDataSource.deleteNoteEntry(any));
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'should return a UnexpectedFailure when any Exception occurs during note deletion',
      () async {
        // arrange
        when(localDataSource.deleteNoteEntry(any)).thenThrow(Exception());
        // action
        final result = await repository.deleteNoteEntry('sampleId');
        // assert
        result.fold((failure) => expect(failure, isA<UnexpectedFailure>()), (
          deletedNote,
        ) {
          fail('expected to throw exception but got something instead');
        });

        verify(localDataSource.deleteNoteEntry(any));
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });

  group('get all note entry', () {
    test('should retrun a list of NoteEntry/s succesfully', () async {
      // arrange
      when(localDataSource.getAllNoteEntries()).thenAnswer((_) async => [note]);

      // action
      final result = await repository.getAllNoteEntries();

      // assert
      result.fold((failure) => fail('Expected Right but got $failure'), (list) {
        expect(list.first, note.toEntity());
      });

      verify(localDataSource.getAllNoteEntries());
      verifyNoMoreInteractions(localDataSource);
    });
    test(
      'should return a LocalStorageFailure when an LocalStorageException occurs during note fetching',
      () async {
        // arrange
        when(
          localDataSource.getAllNoteEntries(),
        ).thenThrow(LocalStorageException());
        // action
        final result = await repository.getAllNoteEntries();
        // assert
        result.fold((failure) => expect(failure, isA<LocalStorageFailure>()), (
          list,
        ) {
          fail('expected to throw exception but got a list instead');
        });

        verify(localDataSource.getAllNoteEntries());
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'should return a UnexpectedFailure when any Exception occurs during note fetching',
      () async {
        // arrange
        when(localDataSource.getAllNoteEntries()).thenThrow(Exception());
        // action
        final result = await repository.getAllNoteEntries();
        // assert
        result.fold((failure) => expect(failure, isA<UnexpectedFailure>()), (
          list,
        ) {
          fail('expected to throw exception but got a list instead');
        });

        verify(localDataSource.getAllNoteEntries());
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });

  group('get note entry', () {
    test('should retrun an NoteEntry succesfully', () async {
      // arrange
      when(
        localDataSource.getNoteEntry('sampleId'),
      ).thenAnswer((_) async => note);

      // action
      final result = await repository.getNoteEntry('sampleId');

      // assert
      result.fold((failure) => fail('Expected Right but got $failure'), (
        fetchedNote,
      ) {
        expect(fetchedNote, note.toEntity());
      });

      verify(localDataSource.getNoteEntry('sampleId'));
      verifyNoMoreInteractions(localDataSource);
    });
    test(
      'should return a LocalStorageFailure when a LocalStorageException occurs during note fetching',
      () async {
        // arrange
        when(
          localDataSource.getNoteEntry('sampleId'),
        ).thenThrow(LocalStorageException());
        // action
        final result = await repository.getNoteEntry('sampleId');
        // assert
        result.fold((failure) => expect(failure, isA<LocalStorageFailure>()), (
          list,
        ) {
          fail('expected to throw exception but got a list instead');
        });

        verify(localDataSource.getNoteEntry('sampleId'));
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'should return a UnexpectedFailure when any Exception occurs during note fetching',
      () async {
        // arrange
        when(localDataSource.getNoteEntry('sampleId')).thenThrow(Exception());
        // action
        final result = await repository.getNoteEntry('sampleId');
        // assert
        result.fold((failure) => expect(failure, isA<UnexpectedFailure>()), (
          list,
        ) {
          fail('expected to throw exception but got a list instead');
        });

        verify(localDataSource.getNoteEntry('sampleId'));
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });

  group('update note entry', () {
    test(
      'should return a NoteEntry when updating a note succesfully',
      () async {
        // arrange
        when(localDataSource.getNoteEntry(any)).thenAnswer((_) async => note);
        when(
          localDataSource.updateNoteEntry(any),
        ).thenAnswer((_) async => note);

        // action
        final result = await repository.updateNoteEntry(
          UpdateNoteRequest(
            id: 'sampleId',
            title: 'sample title',
            body: 'sample body',
          ),
        );

        // assert
        result.fold((failure) => fail('Expected Right but got $failure'), (
          updatedNote,
        ) {
          expect(updatedNote, note.toEntity());
        });

        verify(localDataSource.getNoteEntry(any));
        verify(localDataSource.updateNoteEntry(any));
        verifyNoMoreInteractions(localDataSource);
      },
    );
    test(
      'should return a LocalStorageFailure when a LocalStorageException occurs during note updating',
      () async {
        // arrange
        when(localDataSource.getNoteEntry(any)).thenAnswer((_) async => note);
        when(
          localDataSource.updateNoteEntry(any),
        ).thenThrow(LocalStorageException());
        // action
        final result = await repository.updateNoteEntry(
          UpdateNoteRequest(
            id: 'sampleId',
            title: 'sample title',
            body: 'sample body',
          ),
        );
        // assert
        result.fold((failure) => expect(failure, isA<LocalStorageFailure>()), (
          updatedNote,
        ) {
          fail(
            'expected to throw exception but got note titled=${updatedNote.title} instead',
          );
        });

        verify(localDataSource.getNoteEntry(any));
        verify(localDataSource.updateNoteEntry(any));
        verifyNoMoreInteractions(localDataSource);
      },
    );
    test('should return a NoteNotFoundFailure when no note is found', () async {
      // arrange
      when(
        localDataSource.getNoteEntry(any),
      ).thenThrow(NoteNotFoundException());

      // action
      final result = await repository.updateNoteEntry(
        UpdateNoteRequest(
          id: 'sampleId',
          title: 'sample title',
          body: 'sample body',
        ),
      );
      // assert
      result.fold((failure) => expect(failure, isA<NoteNotFoundFailure>()), (
        updatedNote,
      ) {
        fail(
          'expected to throw exception but got note titled=${updatedNote.title} instead',
        );
      });

      verify(localDataSource.getNoteEntry(any));
      verifyNoMoreInteractions(localDataSource);
    });

    test(
      'should return a UnexpectedFailure when any Exception occurs during note updating',
      () async {
        // arrange
        when(localDataSource.getNoteEntry(any)).thenAnswer((_) async => note);
        when(localDataSource.updateNoteEntry(any)).thenThrow(Exception());
        // action
        final result = await repository.updateNoteEntry(
          UpdateNoteRequest(
            id: 'sampleId',
            title: 'sample title',
            body: 'sample body',
          ),
        );
        // assert
        result.fold((failure) => expect(failure, isA<UnexpectedFailure>()), (
          updatedNote,
        ) {
          fail(
            'expected to throw exception but got note titled=${updatedNote.title} instead',
          );
        });

        verify(localDataSource.getNoteEntry(any));
        verify(localDataSource.updateNoteEntry(any));
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });
}
