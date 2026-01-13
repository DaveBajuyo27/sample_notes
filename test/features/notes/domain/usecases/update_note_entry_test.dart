import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sample_notes/features/notes/domain/dto/update_note_request.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';
import 'package:sample_notes/features/notes/domain/usecases/update_note_entry.dart';

import '../../mocks/all_mocks.mocks.dart';

void main() {
  late MockNoteEntryRepository mockNoteEntryRepository;
  late UpdateNoteEntry usecase;

  setUp(() {
    mockNoteEntryRepository = MockNoteEntryRepository();
    usecase = UpdateNoteEntry(mockNoteEntryRepository);
  });

  final fixedDate = DateTime(2024, 1, 1);
  final NoteEntry note = NoteEntry(
    id: 'id123',
    title: 'sample title',
    body: 'sample body',
    dateCreated: fixedDate,
    lastUpdated: fixedDate,
  );

  test('should update a note entry via repository', () async {
    // arrange
    when(
      mockNoteEntryRepository.updateNoteEntry(any),
    ).thenAnswer((_) async => (Right(note)));

    // action
    final result = await usecase(
      UpdateNoteRequest(id: note.id, title: note.title, body: note.body),
    );

    // assert
    result.fold((failure) => fail('Expected Right but got $failure'), (
      updatedNote,
    ) {
      expect(updatedNote, note);
    });

    verify(mockNoteEntryRepository.updateNoteEntry(any));
    verifyNoMoreInteractions(mockNoteEntryRepository);
  });
}
