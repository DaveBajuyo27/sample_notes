import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sample_notes/features/notes/domain/dto/create_note_request.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';
import 'package:sample_notes/features/notes/domain/usecases/create_note_entry.dart';

import '../../mocks/all_mocks.mocks.dart';

void main() {
  late MockNoteEntryRepository mockNoteEntryRepository;
  late CreateNoteEntry usecase;

  setUp(() {
    mockNoteEntryRepository = MockNoteEntryRepository();
    usecase = CreateNoteEntry(mockNoteEntryRepository);
  });

  final fixedDate = DateTime(2024, 1, 1);
  final NoteEntry note = NoteEntry(
    id: 'id123',
    title: 'sample title',
    body: 'sample body',
    dateCreated: fixedDate,
    lastUpdated: fixedDate,
  );

  test('should create note entry via repository', () async {
    // arrange
    when(
      mockNoteEntryRepository.createNoteEntry(any),
    ).thenAnswer((_) async => Right(note));

    // act
    final result = await usecase(
      CreateNoteRequest(title: 'sample title', body: 'sample body'),
    );

    // assert
    result.fold((failure) => fail('Expected Right but got $failure'), (
      createdNote,
    ) {
      expect(createdNote, note);
    });

    verify(mockNoteEntryRepository.createNoteEntry(any));
    verifyNoMoreInteractions(mockNoteEntryRepository);
  });
}
