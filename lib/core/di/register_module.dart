// injection_module.dart
import 'package:injectable/injectable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_notes/features/notes/data/models/note_entry_model.dart';
import 'package:sample_notes/features/notes/data/models/note_entry_model_adapter.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<Box<NoteEntryModel>> get noteBox async {
    await Hive.initFlutter();
    Hive.registerAdapter(NoteEntryModelAdapter());
    return await Hive.openBox<NoteEntryModel>('noteBox');
  }
}
