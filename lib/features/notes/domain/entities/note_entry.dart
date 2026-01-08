import 'package:equatable/equatable.dart';

class NoteEntry extends Equatable {
  final String id;
  final String title;
  final String body;
  final DateTime dateCreated;
  final DateTime lastUpdated;

  const NoteEntry({
    required this.id,
    required this.title,
    required this.body,
    required this.dateCreated,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [id];
}
