// import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sample_notes/features/notes/data/models/note_entry_model.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';

// import '../../../../fixtures/fixture_reader.dart';

void main() {
  // final tNoteEntryModel = NoteEntryModel(
  //   id: '1',
  //   title: 'Grocery List',
  //   body: 'Eggs\nMilk\nBread\nBananas',
  //   dateCreated: DateTime.parse('2025-01-10T09:30:00.000Z'),
  //   lastUpdated: DateTime.parse('2025-01-10T09:30:00.000Z'),
  // );

  test('should convert NoteEntry entity to NoteEntryModel', () {
    final entity = NoteEntry(
      id: '1',
      title: 'Test',
      body: 'Body',
      dateCreated: DateTime(2025),
      lastUpdated: DateTime(2025, 2),
    );

    final model = NoteEntryModel.fromEntity(entity);

    expect(model.id, entity.id);
    expect(model.title, entity.title);
    expect(model.body, entity.body);
    expect(model.dateCreated, entity.dateCreated);
    expect(model.lastUpdated, entity.lastUpdated);
  });

  test('should convert NoteEntryModel to NoteEntry entity', () {
    final model = NoteEntryModel(
      id: '1',
      title: 'Test',
      body: 'Body',
      dateCreated: DateTime(2025),
      lastUpdated: DateTime(2025, 2),
    );

    final entity = model.toEntity();

    expect(entity.id, model.id);
    expect(entity.title, model.title);
    expect(entity.body, model.body);
    expect(entity.dateCreated, model.dateCreated);
    expect(entity.lastUpdated, model.lastUpdated);
  });

  // test('should return a valid model from JSON source (fromJson)', () {
  //   // arrange
  //   final jsonList = jsonDecode(fixture('note_entry_sample.json')) as List;
  //   // action
  //   final result = NoteEntryModel.fromJson(jsonList.first);
  //   // asseert
  //   expect(result, equals(tNoteEntryModel));
  // });

  // test('should convert a NoteEntryModel into a JSON object', () {
  //   // action
  //   final result = tNoteEntryModel.toJson();
  //   // assert
  //   final expectedJSON = {
  //     "id": "1",
  //     "title": "Grocery List",
  //     "body": "Eggs\nMilk\nBread\nBananas",
  //     "dateCreated": "2025-01-10T09:30:00.000Z",
  //     "lastUpdated": "2025-01-10T09:30:00.000Z",
  //   };
  //   expect(result, expectedJSON);
  // });
}
