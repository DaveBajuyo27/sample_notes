import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';
import 'package:sample_notes/features/notes/presentation/widgets/note_tile_widget.dart';

void main() {
  final fixedDate = DateTime(2024, 1, 1, 22, 0);
  final note = NoteEntry(
    id: 'id1',
    title: 'Test title',
    body: 'Test body',
    dateCreated: fixedDate,
    lastUpdated: fixedDate,
  );

  testWidgets('should render NoteTileWidget with title, date, and body', (
    tester,
  ) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NoteTileWidget(
            note: note,
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    );

    expect(find.text('Test title'), findsOneWidget);
    expect(find.text('10:00PM Jan 1'), findsOneWidget);
    expect(find.text('| Test body'), findsOneWidget);

    await tester.tap(find.byType(NoteTileWidget));
    expect(tapped, isTrue);
  });

  testWidgets('should render "(No Title)" when title is empty', (tester) async {
    final emptyTitleNote = NoteEntry(
      id: 'id2',
      title: '',
      body: 'Some body',
      dateCreated: fixedDate,
      lastUpdated: fixedDate,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NoteTileWidget(note: emptyTitleNote, onTap: () {}),
        ),
      ),
    );

    expect(find.text('(No Title)'), findsOneWidget);
    expect(find.text('| Some body'), findsOneWidget);
  });

  testWidgets('should not render body Text if body is empty', (tester) async {
    final emptyBodyNote = NoteEntry(
      id: 'id3',
      title: 'Title only',
      body: '',
      dateCreated: fixedDate,
      lastUpdated: fixedDate,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NoteTileWidget(note: emptyBodyNote, onTap: () {}),
        ),
      ),
    );

    expect(find.text('Title only'), findsOneWidget);
    expect(find.textContaining('|'), findsNothing);
  });
}
