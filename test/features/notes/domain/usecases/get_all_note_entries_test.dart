import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';
import 'package:sample_notes/features/notes/domain/usecases/get_all_note_entries.dart';
import '../../mocks/note_entry_repository_mocks.mocks.dart';

void main() {
  late MockNoteEntryRepository mockNoteEntryRepository;
  late GetAllNoteEntries usecase;

  setUp(() {
    mockNoteEntryRepository = MockNoteEntryRepository();
    usecase = GetAllNoteEntries(mockNoteEntryRepository);
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
      mockNoteEntryRepository.getAllNoteEntries(),
    ).thenAnswer((_) => Future.value(Right([note])));

    // action
    final result = await usecase(NoParams());

    // assert
    result.fold((failure) => fail('Expected Right but got $failure'), (notes) {
      expect(notes.length, 1);
      expect(notes.first, note);
    });
    verify(mockNoteEntryRepository.getAllNoteEntries());
    verifyNoMoreInteractions(mockNoteEntryRepository);
  });
}
