part of 'notes_bloc.dart';

sealed class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object?> get props => [];
}

// Main screen
final class NotesOpened extends NotesEvent {}

// Viewing screen
final class NoteSelected extends NotesEvent {
  final String noteId;
  const NoteSelected(this.noteId);

  @override
  List<Object> get props => [noteId];
}

// Open blank note viewing screen for creation
final class OpenEditorForNewNote extends NotesEvent {}

// Close editor
final class EditorClosed extends NotesEvent {
  final String draftTitle;
  final String draftBody;
  final bool isNewNote;
  const EditorClosed(this.draftTitle, this.draftBody, this.isNewNote);

  @override
  List<Object> get props => [draftTitle, draftBody, isNewNote];
}
