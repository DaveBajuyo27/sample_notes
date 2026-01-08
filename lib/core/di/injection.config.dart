// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:hive_flutter/hive_flutter.dart' as _i986;
import 'package:injectable/injectable.dart' as _i526;
import 'package:sample_notes/core/di/register_module.dart' as _i626;
import 'package:sample_notes/features/notes/data/datasources/note_entry_local_data_source.dart'
    as _i334;
import 'package:sample_notes/features/notes/data/models/note_entry_model.dart'
    as _i174;
import 'package:sample_notes/features/notes/data/repositories/note_entry_repository_impl.dart'
    as _i781;
import 'package:sample_notes/features/notes/domain/repository/note_entry_repository.dart'
    as _i436;
import 'package:sample_notes/features/notes/domain/usecases/create_note_entry.dart'
    as _i416;
import 'package:sample_notes/features/notes/domain/usecases/delete_note_entry.dart'
    as _i115;
import 'package:sample_notes/features/notes/domain/usecases/get_all_note_entries.dart'
    as _i932;
import 'package:sample_notes/features/notes/domain/usecases/get_note_entry.dart'
    as _i893;
import 'package:sample_notes/features/notes/domain/usecases/update_note_entry.dart'
    as _i410;
import 'package:sample_notes/features/notes/presentation/bloc/notes_bloc.dart'
    as _i598;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i986.Box<_i174.NoteEntryModel>>(
      () => registerModule.noteBox,
      preResolve: true,
    );
    gh.lazySingleton<_i334.NoteEntryLocalDataSource>(
      () => _i334.NoteEntryLocalDataSourceImpl(
        gh<_i979.Box<_i174.NoteEntryModel>>(),
      ),
    );
    gh.lazySingleton<_i436.NoteEntryRepository>(
      () => _i781.NoteEntryRepositoryImpl(gh<_i334.NoteEntryLocalDataSource>()),
    );
    gh.lazySingleton<_i416.CreateNoteEntry>(
      () => _i416.CreateNoteEntry(gh<_i436.NoteEntryRepository>()),
    );
    gh.lazySingleton<_i115.DeleteNoteEntry>(
      () => _i115.DeleteNoteEntry(gh<_i436.NoteEntryRepository>()),
    );
    gh.lazySingleton<_i932.GetAllNoteEntries>(
      () => _i932.GetAllNoteEntries(gh<_i436.NoteEntryRepository>()),
    );
    gh.lazySingleton<_i893.GetNoteEntry>(
      () => _i893.GetNoteEntry(gh<_i436.NoteEntryRepository>()),
    );
    gh.lazySingleton<_i410.UpdateNoteEntry>(
      () => _i410.UpdateNoteEntry(gh<_i436.NoteEntryRepository>()),
    );
    gh.factory<_i598.NotesBloc>(
      () => _i598.NotesBloc(
        getAllNoteEntries: gh<_i932.GetAllNoteEntries>(),
        getNoteEntry: gh<_i893.GetNoteEntry>(),
        createNoteEntry: gh<_i416.CreateNoteEntry>(),
        deleteNoteEntry: gh<_i115.DeleteNoteEntry>(),
        updateNoteEntry: gh<_i410.UpdateNoteEntry>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i626.RegisterModule {}
