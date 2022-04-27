import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class DirectoryBlocState extends Equatable {
  const DirectoryBlocState();
}

class DirectoryBlocStateInitial extends DirectoryBlocState {
  const DirectoryBlocStateInitial();
  @override
  List<Object?> get props => [];
}

class DirectoryBlocStateLoading extends DirectoryBlocState {
  const DirectoryBlocStateLoading();

  @override
  List<Object?> get props => [];
}

class DirectoryBlocStateLoadingSuccess extends DirectoryBlocState {
  const DirectoryBlocStateLoadingSuccess({
    required this.directoryChildren,
    required this.hasParent,
    required this.selectedChildren,
  });

  final List<FileSystemEntity> directoryChildren;
  final bool hasParent;
  final List<FileSystemEntity> selectedChildren;

  DirectoryBlocStateLoadingSuccess copyWith({
    List<FileSystemEntity>? directoryChildren,
    bool? hasParent,
    List<FileSystemEntity>? selectedChildren,
  }) =>
      DirectoryBlocStateLoadingSuccess(
        directoryChildren: directoryChildren ?? this.directoryChildren,
        hasParent: hasParent ?? this.hasParent,
        selectedChildren: selectedChildren ?? this.selectedChildren,
      );

  @override
  List<Object?> get props => [
        directoryChildren,
        hasParent,
        selectedChildren,
      ];
}

class DirectoryBlocStateLoadingFailure extends DirectoryBlocState {
  const DirectoryBlocStateLoadingFailure(this.exception);
  @override
  List<Object?> get props => [];

  final Object? exception;
}
