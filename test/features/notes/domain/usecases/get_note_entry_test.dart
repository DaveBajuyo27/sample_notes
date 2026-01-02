import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';
import 'package:sample_notes/features/notes/domain/usecases/get_note_entry.dart';

import '../../mocks/all_mocks.mocks.dart';

void main() {
  late MockNoteEntryRepository mockNoteEntryRepository;
  late GetNoteEntry usecase;

  setUp(() {
    mockNoteEntryRepository = MockNoteEntryRepository();
    usecase = GetNoteEntry(mockNoteEntryRepository);
  });

  final fixedDate = DateTime(2024, 1, 1);
  final NoteEntry note = NoteEntry(
    id: 'id123',
    title: 'sample title',
    body: 'sample body',
    dateCreated: fixedDate,
    lastUpdated: fixedDate,
  );

  test('should get all note entries from the repository', () async {
    // arrange
    when(
      mockNoteEntryRepository.getNoteEntry('id123'),
    ).thenAnswer((_) => Future.value(Right(note)));

    // action
    final result = await usecase('id123');

    // assert
    result.fold((failure) => fail('Expected Right but got $failure'), (
      resultingNote,
    ) {
      expect(resultingNote, note);
    });
    verify(mockNoteEntryRepository.getNoteEntry('id123'));
    verifyNoMoreInteractions(mockNoteEntryRepository);
  });
}
