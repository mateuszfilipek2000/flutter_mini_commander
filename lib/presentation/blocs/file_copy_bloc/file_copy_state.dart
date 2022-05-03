import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class FileCopyState extends Equatable {
  const FileCopyState();
}

class FileCopyInitial extends FileCopyState {
  const FileCopyInitial();

  @override
  List<Object?> get props => [];
}

class FileCopyCopying extends FileCopyState {
  const FileCopyCopying({
    required this.failedToCopy,
    required this.currentFileIndex,
    required this.total,
    required this.currentFile,
  });

  final List<FileSystemEntity> failedToCopy;
  final int currentFileIndex;
  final int total;
  final FileSystemEntity currentFile;

  FileCopyCopying copyWith({
    List<FileSystemEntity>? failedToCopy,
    int? currentFileIndex,
    int? total,
    FileSystemEntity? currentFile,
  }) =>
      FileCopyCopying(
        failedToCopy: failedToCopy ?? this.failedToCopy,
        currentFileIndex: currentFileIndex ?? this.currentFileIndex,
        currentFile: currentFile ?? this.currentFile,
        total: total ?? this.total,
      );

  @override
  List<Object?> get props => [
        failedToCopy,
        currentFileIndex,
        total,
        currentFile,
      ];
}

class FileCopyFinishedCopying extends FileCopyState {
  const FileCopyFinishedCopying(this.message);
  // final List<FileSystemEntity> failedToCopy;

  final String message;

  @override
  List<Object?> get props => [message];
}
