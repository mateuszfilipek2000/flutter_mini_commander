import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc_event.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc_state.dart';
import 'package:flutter_mini_commander/utils/get_home_directory_path.dart';

class DirectoryBloc extends Bloc<DirectoryBlocEvent, DirectoryBlocState> {
  DirectoryBloc({
    required this.isSource,
  }) : super(const DirectoryBlocStateInitial()) {
    on<DirectoryBlocLoadFolderContentsEvent>((event, emit) {
      emit(const DirectoryBlocStateLoading());
      try {
        //retrieving all the children from target dir
        final targetChildren = Directory(event.target.path).listSync();
        log("Succesfully retrieved children of directory ${event.target.path}");
        emit(
          DirectoryBlocStateLoadingSuccess(
            directoryChildren: targetChildren..sort(customFileSystemEntitySort),
            hasParent: event.target.parent != event.target,
            selectedChildren: const [],
          ),
        );
      } catch (e) {
        log("Couldn't retrieve children from target directory");
        emit(
          DirectoryBlocStateLoadingFailure(e),
        );
      }
    });
    on<DirectoryBlocSelectTarget>((event, emit) {
      if (selectedChildren.contains(event.target)) {
        //item is already selected, checking if it is a directory
        if (event.target is Directory) {
          // target is already selected, and is a directory, moving up the tree
          add(
            DirectoryBlocLoadFolderContentsEvent(target: event.target),
          );
        }
      } else {
        if (isSource) {
          selectedChildren.add(event.target);
        } else {
          selectedChildren = [event.target];
        }

        emit(
          (state as DirectoryBlocStateLoadingSuccess)
              .copyWith(selectedChildren: selectedChildren),
        );
      }
    });
    on<DirectoryBlocLoadUserHomeContents>((event, emit) {
      try {
        add(
          DirectoryBlocLoadFolderContentsEvent(
            target: Directory(
              getUserHomeDirectoryPath(),
            ),
          ),
        );
      } catch (e) {
        emit(DirectoryBlocStateLoadingFailure(e));
      }
    });
  }

  List<FileSystemEntity> selectedChildren = [];
  //if bloc is a source bloc then multiple children can be selected
  final bool isSource;
  // Directory currentDirectory;
  // List<FileSystemEntity> selectedChildren = [];
}

//TODO MOVE THIS EXTENSION, AND SORT FUNC TO OTHER FILE, EXTENSION IS ALSO USED IN MAIN SCREEN
extension EntityName on FileSystemEntity {
  String get name => path.split('/').last;
}

int customFileSystemEntitySort(
    FileSystemEntity entity1, FileSystemEntity entity2) {
  if (entity1 is Directory && entity2 is Directory) {
    //both of them are directories, sorting alphabetically
    return entity1.name.compareTo(entity2.name);
  } else if (entity1 is Directory) {
    return -1;
  } else if (entity2 is Directory) {
    return 1;
  }
  return entity1.name.compareTo(entity2.name);
}
