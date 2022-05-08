import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini_commander/data/interfaces/iopen_directory.dart';
import 'package:flutter_mini_commander/data/models/directory_model.dart';
import 'package:flutter_mini_commander/data/models/entities.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc_event.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc_state.dart';

class DirectoryBloc extends Bloc<DirectoryBlocEvent, DirectoryBlocState> {
  DirectoryBloc({
    required this.isSource,
    required this.openDirectory,
  }) : super(const DirectoryBlocStateInitial()) {
    on<DirectoryBlocLoadFolderContentsEvent>((event, emit) async {
      emit(const DirectoryBlocStateLoading());
      try {
        //retrieving all the children from target dir
        // final targetChildren = Directory(event.target.path).listSync();
        final targetChildren = (await openDirectory.openDirectory(
          targetPath: event.target,
        ))
            .toList();
        log("Succesfully retrieved children of directory ${event.target}");

        emit(
          DirectoryBlocStateLoadingSuccess(
            directoryChildren: targetChildren..sort(customFileSystemEntitySort),
            selectedChildren: const [],
            currentDirectory: DirectoryModel(
              path: event.target!,
            ),
          ),
        );
        selectedChildren = [];
      } catch (e) {
        log("Couldn't retrieve children from target directory");
        emit(
          DirectoryBlocStateLoadingFailure(e),
        );
      }
    });
    on<DirectoryBlocSelectTarget>((event, emit) {
      if (selectedChildren.contains(event.target)) {
        //if the selected item is tapped again, and it isn't a double tap,
        //then the tapped item is no longer selected
        selectedChildren.remove(event.target);
      } else {
        if (isSource) {
          selectedChildren.add(event.target);
        } else if (event.target is Directory) {
          selectedChildren = [event.target];
        }
      }

      emit(
        (state as DirectoryBlocStateLoadingSuccess)
            .copyWith(selectedChildren: selectedChildren),
      );
    });
    on<DirectoryBlocDoubleTap>((event, emit) {
      if (event.target is DirectoryModel) {
        add(
          DirectoryBlocLoadFolderContentsEvent(
            target: event.target.path,
          ),
        );
      }
    });
    on<DirectoryBlocLoadUserHomeContents>((event, emit) {
      try {
        add(
          const DirectoryBlocLoadFolderContentsEvent(),
        );
      } catch (e) {
        emit(DirectoryBlocStateLoadingFailure(e));
      }
    });
  }

  List<Entity> selectedChildren = [];
  final bool isSource;

  final IOpenDirectory openDirectory;
}

// extension EntityName on Entity {
//   String get name => path.split('/').last;
// }

/// custom sorting method used for sorting file system entities,
/// directories are placed first, sorted alphabetically
/// files are placed after directories, sorted alphabetically
int customFileSystemEntitySort(Entity entity1, Entity entity2) {
  if (entity1 is DirectoryModel && entity2 is DirectoryModel) {
    //both of them are directories, sorting alphabetically
    return entity1.name.compareTo(entity2.name);
  } else if (entity1 is DirectoryModel) {
    return -1;
  } else if (entity2 is DirectoryModel) {
    return 1;
  }
  return entity1.name.compareTo(entity2.name);
}
