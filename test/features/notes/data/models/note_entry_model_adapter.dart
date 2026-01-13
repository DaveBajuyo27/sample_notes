import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_notes/features/notes/data/models/note_entry_model.dart';
import 'package:sample_notes/features/notes/data/models/note_entry_model_adapter.dart';

void main() {
  group('NoteEntryModelAdapter', () {
    late NoteEntryModel testNote;

    setUpAll(() async {
      await Hive.initFlutter(); // in-memory
      Hive.registerAdapter(NoteEntryModelAdapter());
    });

    setUp(() {
      testNote = NoteEntryModel(
        id: '123',
        title: 'Test Title',
        body: 'Test Body',
        dateCreated: DateTime(2024, 12, 31, 10, 0),
        lastUpdated: DateTime(2025, 1, 1, 15, 30),
      );
    });

    test('should save and read NoteEntryModel from box', () async {
      final box = await Hive.openBox<NoteEntryModel>('testBox');

      await box.put(testNote.id, testNote);

      final result = box.get(testNote.id);

      expect(result?.id, testNote.id);
      expect(result?.title, testNote.title);
      expect(result?.body, testNote.body);
      expect(result?.dateCreated, testNote.dateCreated);
      expect(result?.lastUpdated, testNote.lastUpdated);

      await box.clear();
      await box.close();
    });
  });
}
