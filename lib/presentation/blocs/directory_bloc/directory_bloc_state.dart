import 'dart:io';

extension Equals on FileSystemEntity {}

abstract class DirectoryBlocState {
  const DirectoryBlocState();
}

class DirectoryBlocStateInitial extends DirectoryBlocState {
  const DirectoryBlocStateInitial();
  // @override
  // List<Object?> get props => [];
}

class DirectoryBlocStateLoading extends DirectoryBlocState {
  const DirectoryBlocStateLoading();

  // @override
  // List<Object?> get props => [];
}

class DirectoryBlocStateLoadingSuccess extends DirectoryBlocState {
  const DirectoryBlocStateLoadingSuccess({
    required this.directoryChildren,
    required this.hasParent,
    required this.selectedChildren,
    required this.currentDirectory,
  });

  final List<FileSystemEntity> directoryChildren;
  final bool hasParent;
  final List<FileSystemEntity> selectedChildren;
  final Directory currentDirectory;

  DirectoryBlocStateLoadingSuccess copyWith({
    List<FileSystemEntity>? directoryChildren,
    bool? hasParent,
    List<FileSystemEntity>? selectedChildren,
    Directory? currentDirectory,
  }) =>
      DirectoryBlocStateLoadingSuccess(
        directoryChildren: directoryChildren ?? this.directoryChildren,
        hasParent: hasParent ?? this.hasParent,
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
