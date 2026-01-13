import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sample_notes/features/notes/domain/dto/create_note_request.dart';
import 'package:sample_notes/features/notes/domain/dto/update_note_request.dart';
import 'package:sample_notes/features/notes/domain/entities/note_entry.dart';
import 'package:sample_notes/features/notes/domain/usecases/create_note_entry.dart';
import 'package:sample_notes/features/notes/domain/usecases/delete_note_entry.dart';
import 'package:sample_notes/features/notes/domain/usecases/get_all_note_entries.dart';
import 'package:sample_notes/features/notes/domain/usecases/get_note_entry.dart';
import 'package:sample_notes/features/notes/domain/usecases/update_note_entry.dart';

part 'notes_event.dart';
part 'notes_state.dart';

@injectable
class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetAllNoteEntries getAllNoteEntries;
  final GetNoteEntry getNoteEntry;
  final CreateNoteEntry createNoteEntry;
  final DeleteNoteEntry deleteNoteEntry;
  final UpdateNoteEntry updateNoteEntry;

  late List<NoteEntry> notes;

  NotesBloc({
    required this.getAllNoteEntries,
    required this.getNoteEntry,
    required this.createNoteEntry,
    required this.deleteNoteEntry,
    required this.updateNoteEntry,
  }) : super(NotesState.initial()) {
    on<NotesOpened>(_onNotesOpened);

    on<OpenEditorForNewNote>((event, emit) async {
      final newState = state.copyWith(selectedNote: null, isNewNote: true);
      emit(newState);
    });

    on<NoteSelected>(_onNoteSelected);

    on<EditorClosed>(_editorClosed);
  }

  Future<void> _onNotesOpened(
    NotesOpened event,
    Emitter<NotesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await getAllNoteEntries(NoParams());

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Error loading all notes.',
          ),
        );
      },
      (notes) {
        this.notes = notes;
        emit(state.copyWith(notes: notes, isLoading: false));
      },
    );
  }

  // note: unnecessary api call, should've just passed the note entry directly
  Future<void> _onNoteSelected(
    NoteSelected event,
    Emitter<NotesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await getNoteEntry(event.noteId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(isLoading: false, errorMessage: 'Error loading note.'),
        );
      },
      (note) {
        emit(
          state.copyWith(
            isLoading: false,
            selectedNote: note,
            isNewNote: false,
          ),
        );
      },
    );
  }

  Future<void> _editorClosed(
    EditorClosed event,
    Emitter<NotesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final isNewNote = event.isNewNote;
    final draftTitle = event.draftTitle.trim();
    final draftBody = event.draftBody.trim();

    if (isNewNote) {
      // CreateNoteRequested logic
      if (draftTitle.isNotEmpty || draftBody.isNotEmpty) {
        await createNoteEntry(
          CreateNoteRequest(title: draftTitle, body: draftBody),
        );
      }
    } else {
      final selectedNote = state.selectedNote;
      // if selectedNote is null, do nothing
      if (selectedNote == null) {
        emit(state.copyWith(isLoading: false));
        return;
      }
      // if draft is same as selectedNote, do nothing
      if (selectedNote.title == draftTitle && selectedNote.body == draftBody) {
        emit(state.copyWith(isLoading: false));
        return;
      }
      if (draftTitle.isEmpty && draftBody.isEmpty) {
        // DeleteNoteRequested logic
        await deleteNoteEntry(selectedNote.id);
      } else {
        // UpdateNoteRequested logic
        await updateNoteEntry(
          UpdateNoteRequest(
            id: selectedNote.id,
            title: draftTitle,
            body: draftBody,
          ),
        );
      }
    }

    // refetch the notes list to keep state up-to-date
    final result = await getAllNoteEntries(NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          errorMessage: 'Error refreshing notes',
          isLoading: false,
        ),
      ),
      (notes) {
        emit(
          state.copyWith(
            notes: [...notes],
            selectedNote: null,
            isLoading: false,
          ),
        );
      },
    );
  }
}
