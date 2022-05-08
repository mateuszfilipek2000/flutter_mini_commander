import 'dart:io';

import 'package:flutter_mini_commander/data/models/directory_model.dart';
import 'package:flutter_mini_commander/data/models/entities.dart';

extension Equals on FileSystemEntity {}

abstract class DirectoryBlocState {
  const DirectoryBlocState();
}

class DirectoryBlocStateInitial extends DirectoryBlocState {
  const DirectoryBlocStateInitial();
}

class DirectoryBlocStateLoading extends DirectoryBlocState {
  const DirectoryBlocStateLoading();
}

class DirectoryBlocStateLoadingSuccess extends DirectoryBlocState {
  const DirectoryBlocStateLoadingSuccess({
    required this.directoryChildren,
    // required this.hasParent,
    required this.selectedChildren,
    required this.currentDirectory,
  });

  final List<Entity> directoryChildren;
  // final bool hasParent;
  final List<Entity> selectedChildren;
  final DirectoryModel currentDirectory;

  DirectoryBlocStateLoadingSuccess copyWith({
    List<Entity>? directoryChildren,
    // bool? hasParent,
    List<Entity>? selectedChildren,
    DirectoryModel? currentDirectory,
  }) =>
      DirectoryBlocStateLoadingSuccess(
        directoryChildren: directoryChildren ?? this.directoryChildren,
        // hasParent: hasParent ?? this.hasParent,
        selectedChildren: selectedChildren ?? this.selectedChildren,
        currentDirectory: currentDirectory ?? this.currentDirectory,
      );

  // @override
  // List<Object?> get props => [
  //       directoryChildren,
  //       hasParent,
  //       selectedChildren,
  //     ];
}

class DirectoryBlocStateLoadingFailure extends DirectoryBlocState {
  const DirectoryBlocStateLoadingFailure(this.exception);
  // @override
  // List<Object?> get props => [];

  final Object? exception;
}
