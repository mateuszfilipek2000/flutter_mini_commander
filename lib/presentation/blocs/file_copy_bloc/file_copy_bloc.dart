import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/file_copy_bloc/file_copy_event.dart';
import 'package:flutter_mini_commander/presentation/blocs/file_copy_bloc/file_copy_state.dart';
import 'package:io/io.dart' show copyPath;

class FileCopyBloc extends Bloc<FileCopyEvent, FileCopyState> {
  FileCopyBloc() : super(const FileCopyInitial()) {
    on<FileCopyCopyFiles>((event, emit) async {
      emit(
        FileCopyCopying(
          failedToCopy: const [],
          currentFileIndex: 1,
          total: event.filesToCopy.length,
          currentFile: event.filesToCopy.first,
        ),
      );

      for (final item in event.filesToCopy) {
        try {
          if (item is File) {
            await item.copy("${event.targetDirectory.path}/${item.name}");
          } else if (item is Directory) {
            await copyPath(
              item.path,
              "${event.targetDirectory.path}/${item.name}",
            );
          }
        } catch (e) {
          log(e.toString());
          emit(
            (state as FileCopyCopying).copyWith(
              failedToCopy: List.from(
                (state as FileCopyCopying).failedToCopy,
              )..add(item),
            ),
          );
        }
      }

      // for (int i = 0; i < event.filesToCopy.length; i++) {
      //   final item = event.filesToCopy[i];
      //   try {
      //     if (item is File) {
      //       await item.copy(event.targetDirectory.path + '/${item.name}');
      //     } else if (item is Directory) {
      //       await copyPath(
      //           item.path, event.targetDirectory.path + '/${item.name}/');
      //     }
      //   } catch (e) {
      //     log(e.toString());
      //     emit((state as FileCopyCopying).copyWith(
      //         failedToCopy: List.from(
      //       (state as FileCopyCopying).failedToCopy,
      //     )..add(item)));
      //   }
      // }

      emit(
        FileCopyFinishedCopying(
          (state as FileCopyCopying).failedToCopy.isNotEmpty
              ? "Failed to copy: " +
                  (state as FileCopyCopying).failedToCopy.join(", ")
              : "Succesfully copied all the files",
        ),
      );
    });
  }
}

extension EntityName on FileSystemEntity {
  String get name => path.split('/').last;
}
