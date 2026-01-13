import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';
import 'package:sample_notes/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:sample_notes/features/notes/presentation/pages/note_editor_page.dart';
import '../../mocks/all_mocks.mocks.dart';

void main() {
  late MockNotesBloc mockBloc;

  setUp(() {
    mockBloc = MockNotesBloc();
  });

  Widget makeTestableWidget(NotesState state) {
    when(mockBloc.state).thenReturn(state);
    when(mockBloc.stream).thenAnswer((_) => Stream.value(state));

    return MaterialApp(
      home: BlocProvider<NotesBloc>.value(
        value: mockBloc,
        child: MaterialApp(home: const NoteEditorPage()),
      ),
    );
  }

  final fixedDate = DateTime(2024, 1, 1);
  final note = NoteEntry(
    id: 'id1',
    title: 'Test title',
    body: 'Test body',
    dateCreated: fixedDate,
    lastUpdated: fixedDate,
  );

  testWidgets(
    'should show error message when there is error on note fetching',
    (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          NotesState.initial().copyWith(
            errorMessage: 'Error loading note.',
            selectedNote: note,
            isNewNote: false,
          ),
        ),
      );

      expect(find.text('Error loading note.'), findsOneWidget);
      expect(find.byType(TextField), findsNothing);
    },
  );

  testWidgets('should show the note when selected note exist', (tester) async {
    await tester.pumpWidget(
      makeTestableWidget(NotesState.initial().copyWith(selectedNote: note)),
    );

    expect(find.text('Test title'), findsOneWidget);
    expect(find.text('Test body'), findsOneWidget);
    expect(find.byType(TextField), findsWidgets);
  });

  testWidgets('should go back to main page when tapping back button', (
    tester,
  ) async {
    await tester.pumpWidget(
      makeTestableWidget(
        NotesState.initial().copyWith(
          notes: [note],
          selectedNote: note,
          isNewNote: false,
        ),
      ),
    );

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    verify(
      mockBloc.add(EditorClosed('Test title', 'Test body', false)),
    ).called(1);
    expect(find.byType(NoteEditorPage), findsNothing);
  });
}
