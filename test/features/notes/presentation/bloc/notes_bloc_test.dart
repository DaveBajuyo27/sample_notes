import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:sample_notes/core/error/failures.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';
import 'package:sample_notes/features/notes/presentation/bloc/notes_bloc.dart';

import '../../mocks/all_mocks.mocks.dart'; // your generated Mockito mocks

void main() {
  late MockGetAllNoteEntries mockGetAll;
  late MockGetNoteEntry mockGetNote;
  late MockCreateNoteEntry mockCreate;
  late MockDeleteNoteEntry mockDelete;
  late MockUpdateNoteEntry mockUpdate;
  late NotesBloc bloc;

  setUp(() {
    mockGetAll = MockGetAllNoteEntries();
    mockGetNote = MockGetNoteEntry();
    mockCreate = MockCreateNoteEntry();
    mockDelete = MockDeleteNoteEntry();
    mockUpdate = MockUpdateNoteEntry();

    bloc = NotesBloc(
      getAllNoteEntries: mockGetAll,
      getNoteEntry: mockGetNote,
      createNoteEntry: mockCreate,
      deleteNoteEntry: mockDelete,
      updateNoteEntry: mockUpdate,
    );
  });

  final fixedDate = DateTime(2024, 1, 1);
  final tNote = NoteEntry(
    id: 'id123',
    title: 'sample title',
    body: 'sample body',
    dateCreated: fixedDate,
    lastUpdated: fixedDate,
  );
  final tNotesList = [tNote];

  group('NotesBloc', () {
    test('initial state is NotesState.initial()', () {
      expect(bloc.state, NotesState.initial());
    });

    test('should load all notes successfully when NotesOpened', () async {
      when(mockGetAll(any)).thenAnswer((_) async => Right(tNotesList));

      bloc.add(NotesOpened());
      await Future.delayed(Duration.zero);

      verify(mockGetAll(any)).called(1);
      expect(bloc.state.notes, tNotesList);
      expect(bloc.state.isLoading, false);
    });

    test(
      'should have errorMessage when get all notes fail when NotesOpened',
      () async {
        when(
          mockGetAll(any),
        ).thenAnswer((_) async => Left(LocalStorageFailure()));

        bloc.add(NotesOpened());
        await Future.delayed(Duration.zero);

        verify(mockGetAll(any)).called(1);
        expect(bloc.state.errorMessage, 'Error loading all notes.');
        expect(bloc.state.isLoading, false);
      },
    );

    test(
      'should set isNewNote true and selectedNote null when OpenEditorForNewNote',
      () async {
        bloc.add(OpenEditorForNewNote());
        await Future.delayed(Duration.zero);

        expect(bloc.state.isNewNote, true);
        expect(bloc.state.selectedNote, null);
      },
    );

    test('should load selected note successfully when NoteSelected', () async {
      when(mockGetNote(any)).thenAnswer((_) async => Right(tNote));

      bloc.add(NoteSelected(tNote.id));
      await Future.delayed(Duration.zero);

      verify(mockGetNote(any)).called(1);
      expect(bloc.state.selectedNote, tNote);
      expect(bloc.state.isLoading, false);
    });

    test(
      'should have errorMessage when get note fails when NoteSelected',
      () async {
        when(
          mockGetNote(any),
        ).thenAnswer((_) async => Left(LocalStorageFailure()));

        bloc.add(NoteSelected(tNote.id));
        await Future.delayed(Duration.zero);

        verify(mockGetNote(any)).called(1);
        expect(bloc.state.errorMessage, 'Error loading note.');
        expect(bloc.state.isLoading, false);
      },
    );

    test('should create new note when isNewNote true EditorClosed', () async {
      when(mockCreate(any)).thenAnswer((_) async => Right(tNote));
      when(mockGetAll(any)).thenAnswer((_) async => Right(tNotesList));

      bloc.emit(bloc.state.copyWith(isNewNote: true));
      bloc.add(EditorClosed('New Title', 'New Body', true));
      await Future.delayed(Duration.zero);

      verify(mockCreate(any)).called(1);
      verify(mockGetAll(any)).called(1);
      expect(bloc.state.notes, tNotesList);
      expect(bloc.state.isLoading, false);
    });

    test(
      'should update existing note when isNewNote false and draft not empty when EditorClosed',
      () async {
        when(mockUpdate(any)).thenAnswer((_) async => Right(tNote));
        when(mockGetAll(any)).thenAnswer((_) async => Right(tNotesList));

        bloc.emit(bloc.state.copyWith(selectedNote: tNote, isNewNote: false));
        bloc.add(EditorClosed('Updated Title', 'Updated Body', false));
        await Future.delayed(Duration.zero);

        verify(mockUpdate(any)).called(1);
        verify(mockGetAll(any)).called(1);
        expect(bloc.state.notes, tNotesList);
        expect(bloc.state.isLoading, false);
      },
    );

    test(
      'should NOT update existing note when isNewNote false and draft = selectedNote when EditorClosed',
      () async {
        when(mockUpdate(any)).thenAnswer((_) async => Right(tNote));
        when(mockGetAll(any)).thenAnswer((_) async => Right(tNotesList));

        bloc.emit(bloc.state.copyWith(selectedNote: tNote, isNewNote: false));
        bloc.add(EditorClosed('sample title', 'sample body', false));
        await Future.delayed(Duration.zero);

        verifyNever(mockUpdate(any));
        verifyNever(mockGetAll(any));
        expect(bloc.state.isLoading, false);
      },
    );

    test(
      'should delete note when draft is empty and isNewNote false when EditorClosed',
      () async {
        when(mockDelete(any)).thenAnswer((_) async => Right(null));
        when(mockGetAll(any)).thenAnswer((_) async => Right(tNotesList));

        bloc.emit(bloc.state.copyWith(selectedNote: tNote, isNewNote: false));
        bloc.add(EditorClosed('', '', false));
        await Future.delayed(Duration.zero);

        verify(mockDelete(tNote.id)).called(1);
        verify(mockGetAll(any)).called(1);
        expect(bloc.state.notes, tNotesList);
        expect(bloc.state.isLoading, false);
      },
    );

    test(
      'should do nothing when selectedNote is null and isNewNote false when EditorClosed',
      () async {
        when(mockGetAll(any)).thenAnswer((_) async => Right(tNotesList));

        bloc.emit(bloc.state.copyWith(selectedNote: null, isNewNote: false));
        bloc.add(EditorClosed('', '', false));
        await Future.delayed(Duration.zero);

        verifyNever(mockUpdate(any));
        verifyNever(mockGetAll(any));
        expect(bloc.state.isLoading, false);
      },
    );

    test(
      'should handle error when get all for refreshing fails on EditorClosed',
      () async {
        when(mockCreate(any)).thenAnswer((_) async => Right(tNote));
        when(
          mockGetAll(any),
        ).thenAnswer((_) async => Left(LocalStorageFailure()));

        bloc.emit(bloc.state.copyWith(isNewNote: true));
        bloc.add(EditorClosed('New Title', 'New Body', true));
        await Future.delayed(Duration.zero);

        verify(mockCreate(any)).called(1);
        verify(mockGetAll(any)).called(1);
        expect(bloc.state.errorMessage, 'Error refreshing notes');
        expect(bloc.state.isLoading, false);
      },
    );
  });
}
