import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sample_notes/features/notes/domain/usecases/delete_note_entry.dart';

import '../../mocks/all_mocks.mocks.dart';

void main() {
  late MockNoteEntryRepository mockNoteEntryRepository;
  late DeleteNoteEntry usecase;

  setUp(() {
    mockNoteEntryRepository = MockNoteEntryRepository();
    usecase = DeleteNoteEntry(mockNoteEntryRepository);
  });

  test('should delete a note entry via repository', () async {
    // arrange
    when(
      mockNoteEntryRepository.deleteNoteEntry(any),
    ).thenAnswer((_) async => (Right(null)));

    // action
    final result = await usecase('id123');

    // assert
    result.fold((failure) => fail('Expected Right but got $failure'), (
      deleteResult,
    ) {
      expect(true, true);
    });

    verify(mockNoteEntryRepository.deleteNoteEntry('id123'));
    verifyNoMoreInteractions(mockNoteEntryRepository);
  });
}
