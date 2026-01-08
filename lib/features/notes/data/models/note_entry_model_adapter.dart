import 'package:hive/hive.dart';
import 'note_entry_model.dart';

/// Asked for this to be generated, so I can save time

class NoteEntryModelAdapter extends TypeAdapter<NoteEntryModel> {
  @override
  final int typeId = 0;

  @override
  NoteEntryModel read(BinaryReader reader) {
    return NoteEntryModel(
      id: reader.readString(),
      title: reader.readString(),
      body: reader.readString(),
      dateCreated: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
    );
  }

  @override
  void write(BinaryWriter writer, NoteEntryModel obj) {
    writer
      ..writeString(obj.id)
      ..writeString(obj.title)
      ..writeString(obj.body)
      ..writeInt(obj.dateCreated.millisecondsSinceEpoch)
      ..writeInt(obj.lastUpdated.millisecondsSinceEpoch);
  }
}
