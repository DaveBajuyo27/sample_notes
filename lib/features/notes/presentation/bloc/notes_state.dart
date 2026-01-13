part of 'notes_bloc.dart';

class NotesState extends Equatable {
  final List<NoteEntry> notes;
  final NoteEntry? selectedNote;
  final bool isLoading;
  final String? errorMessage;
  final bool? isNewNote;

  const NotesState({
    required this.notes,
    this.selectedNote,
    this.isLoading = false,
    this.errorMessage,
    this.isNewNote,
  });

  factory NotesState.initial() => const NotesState(notes: [], isLoading: false);

  NotesState copyWith({
    List<NoteEntry>? notes,
    NoteEntry? selectedNote,
    bool? isLoading,
    String? errorMessage,
    bool? isNewNote,
  }) {
    return NotesState(
      notes: notes ?? this.notes,
      selectedNote: selectedNote ?? this.selectedNote,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isNewNote: isNewNote,
    );
  }

  @override
  List<Object?> get props => [
    notes,
    selectedNote,
    isLoading,
    errorMessage,
    isNewNote,
  ];
}
