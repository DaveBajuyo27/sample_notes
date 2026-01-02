import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sample_notes/core/error/exceptions.dart';
import 'package:sample_notes/features/notes/data/datasources/note_entry_local_data_source.dart';
import 'package:sample_notes/features/notes/data/models/note_entry_model.dart';

import '../../mocks/all_mocks.mocks.dart';

void main() {
  late MockBox<NoteEntryModel> mockBox;
  late NoteEntryLocalDataSourceImpl dataSource;

  setUp(() {
    mockBox = MockBox();
    dataSource = NoteEntryLocalDataSourceImpl(mockBox);
  });

  final model = NoteEntryModel(
    id: '1',
    title: 'Test',
    body: 'Body',
    dateCreated: DateTime(2025),
    lastUpdated: DateTime(2025),
  );

  test(
    'should create a noteEntry in box succesfully and return a noteEntryModel',
    () async {
      // arrange
      when(mockBox.put('1', model)).thenAnswer((_) => Future.value());
      // action
      final result = await dataSource.createNoteEntry(model);
      // assert
      expect(result, model);
      verify(mockBox.put('1', model)).called(1);
      verifyNoMoreInteractions(mockBox);
    },
  );

  test('should delete a noteEntry in box succesfully', () async {
    // arrange
    when(mockBox.get('1')).thenAnswer((_) => model);
    when(mockBox.delete('1')).thenAnswer((_) => Future.value());
    // action
    await dataSource.deleteNoteEntry('1');
    // assert
    verify(mockBox.get('1')).called(1);
    verify(mockBox.delete('1')).called(1);
    verifyNoMoreInteractions(mockBox);
  });

  test(
    'should throw a NoteNotFoundException when deleting an inexisting noteEntry in box',
    () async {
      // arrange
      when(mockBox.get('1')).thenAnswer((_) => null);
      // action & assert
      expect(
        () async => await dataSource.deleteNoteEntry('1'),
        throwsA(isA<NoteNotFoundException>()),
      );
      verifyNever(mockBox.delete('1'));
    },
  );

  test('should get all noteEntry/s in box', () async {
    // arrange
    when(mockBox.values.toList()).thenAnswer((_) => [model]);
    // action
    final result = await dataSource.getAllNoteEntries();
    // assert
    expect(result, [model]);
    verify(mockBox.values).called(1);
    verifyNoMoreInteractions(mockBox);
  });

  test('should get one noteEntry in box', () async {
    // arrange
    when(mockBox.get('id')).thenAnswer((_) => model);
    // action
    final result = await dataSource.getNoteEntry('id');
    // assert
    expect(result, model);
    verify(mockBox.get('id')).called(1);
    verifyNoMoreInteractions(mockBox);
  });

  test('should throw when getiing inexistent noteEntry in box', () async {
    // arrange
    when(mockBox.get('1')).thenAnswer((_) => null);
    // action and assert
    expect(
      () async => await dataSource.getNoteEntry('1'),
      throwsA(isA<NoteNotFoundException>()),
    );
  });

  test(
    'should update a noteEntry in box succesfully and return a noteEntryModel',
    () async {
      // arrange
      when(mockBox.get('1')).thenAnswer((_) => model);
      when(mockBox.put('1', model)).thenAnswer((_) => Future.value());
      // action
      final result = await dataSource.updateNoteEntry(model);
      // assert
      expect(result, model);
      verify(mockBox.get('1')).called(1);
      verify(mockBox.put('1', model)).called(1);
      verifyNoMoreInteractions(mockBox);
    },
  );

  test(
    'should throw a NoteNotFoundException when updating an inexisting noteEntry in box',
    () async {
      // arrange
      when(mockBox.get('1')).thenAnswer((_) => null);
      // action & assert
      expect(
        () async => await dataSource.deleteNoteEntry('1'),
        throwsA(isA<NoteNotFoundException>()),
      );
      verifyNever(mockBox.delete('1'));
    },
  );
}
