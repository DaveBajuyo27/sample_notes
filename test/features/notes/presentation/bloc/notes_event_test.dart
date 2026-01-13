import 'package:flutter_test/flutter_test.dart';
import 'package:sample_notes/features/notes/presentation/bloc/notes_bloc.dart';

void main() {
  test('should instantiate NotesOpened properly', () {
    final event = NotesOpened();
    expect(event.props, []);
  });

  test('should instantiate NoteSelected properly', () {
    final event = NoteSelected('sampleId');
    expect(event.props, ['sampleId']);
  });

  test('should instantiate OpenEditorForNewNote  properly', () {
    final event = OpenEditorForNewNote();
    expect(event.props, []);
  });

  test('should instantiate EditorClosed properly', () {
    final event = EditorClosed('title', 'body', false);
    expect(event.props, ['title', 'body', false]);
  });
}
