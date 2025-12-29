import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sample_notes/features/notes/data/models/note_entry_model.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNoteEntryModel = NoteEntryModel(
    id: '1',
    title: 'Grocery List',
    body: 'Eggs\nMilk\nBread\nBananas',
    dateCreated: DateTime.parse('2025-01-10T09:30:00.000Z'),
    lastUpdated: DateTime.parse('2025-01-10T09:30:00.000Z'),
  );

  test('should be a subclass to NoteEntry entity', () {
    expect(tNoteEntryModel, isA<NoteEntry>());
  });

  test('should return a valid model from JSON source (fromJson)', () {
    // arrange
    final jsonList = jsonDecode(fixture('note_entry_sample.json')) as List;
    // action
    final result = NoteEntryModel.fromJson(jsonList.first);
    // asseert
    expect(result, equals(tNoteEntryModel));
  });

  test('should convert a NoteEntryModel into a JSON object', () {
    // action
    final result = tNoteEntryModel.toJson();
    // assert
    final expectedJSON = {
      "id": "1",
      "title": "Grocery List",
      "body": "Eggs\nMilk\nBread\nBananas",
      "dateCreated": "2025-01-10T09:30:00.000Z",
      "lastUpdated": "2025-01-10T09:30:00.000Z",
    };
    expect(result, expectedJSON);
  });
}
