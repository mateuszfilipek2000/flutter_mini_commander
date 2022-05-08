import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini_commander/data/interfaces/icopy_entities.dart';

import 'package:flutter_mini_commander/presentation/blocs/file_copy_bloc/file_copy_event.dart';
import 'package:flutter_mini_commander/presentation/blocs/file_copy_bloc/file_copy_state.dart';

class FileCopyBloc extends Bloc<FileCopyEvent, FileCopyState> {
  FileCopyBloc({
    required this.copyProvider,
  }) : super(const FileCopyInitial()) {
    on<FileCopyCopyFiles>((event, emit) async {
      emit(const FileCopyCopying());
      String message = "Succesfully copied all the files";

      try {
        await copyProvider.copy(
          targetDirPath: event.targetDirectory.path,
          fileSystemEntities: event.filesToCopy,
        );
      } catch (e) {
        message = e.toString();
      }

      emit(
        FileCopyFinishedCopying(
          message,
        ),
      );
    });
  }

  final ICopyEntities copyProvider;
}

// extension EntityName on FileSystemEntity {
//   String get name => path.split('/').last;
// }
