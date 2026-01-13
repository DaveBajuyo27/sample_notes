import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';
import 'package:sample_notes/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:sample_notes/features/notes/presentation/pages/note_editor_page.dart';
import 'package:sample_notes/features/notes/presentation/pages/notes_main_page.dart';
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
        child: MaterialApp(home: const NotesMainPage()),
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

  testWidgets('should show empty message when notes list is empty', (
    tester,
  ) async {
    await tester.pumpWidget(
      makeTestableWidget(NotesState.initial().copyWith(notes: [])),
    );

    expect(find.text('Notes empty.'), findsOneWidget);
    expect(find.byType(ListView), findsNothing);
  });

  testWidgets('should show list of notes when notes exist', (tester) async {
    await tester.pumpWidget(
      makeTestableWidget(NotesState.initial().copyWith(notes: [note])),
    );

    expect(find.text('Test title'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('should navigate to note editor page when tapping a note', (
    tester,
  ) async {
    await tester.pumpWidget(
      makeTestableWidget(
        NotesState.initial().copyWith(notes: [note], selectedNote: note),
      ),
    );

    await tester.tap(find.text('Test title'));
    await tester.pumpAndSettle();

    verify(mockBloc.add(NoteSelected(note.id))).called(1);
    expect(find.byType(NoteEditorPage), findsOneWidget);
  });

  testWidgets('should opens an editor for new note when tapping FAB', (
    tester,
  ) async {
    await tester.pumpWidget(
      makeTestableWidget(
        NotesState.initial().copyWith(notes: [], isNewNote: true),
      ),
    );

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    verify(mockBloc.add(OpenEditorForNewNote())).called(1);
    expect(find.byType(NoteEditorPage), findsOneWidget);
  });

  testWidgets(
    'should show a divider when more than one note exist in the list',
    (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(NotesState.initial().copyWith(notes: [note, note])),
      );

      expect(find.byType(Divider), findsOneWidget);
    },
  );
}
