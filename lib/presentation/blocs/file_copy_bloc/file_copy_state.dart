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
  const FileCopyCopying();

  // FileCopyCopying copyWith({
  //   int? currentFileIndex,
  //   int? total,
  //   Entity? currentFile,
  // }) =>
  //     FileCopyCopying(
  //     );

  @override
  List<Object?> get props => [
        // failedToCopy,
        // currentFileIndex,
        // total,
        // currentFile,
      ];
}

class FileCopyFinishedCopying extends FileCopyState {
  const FileCopyFinishedCopying(this.message);
  // final List<FileSystemEntity> failedToCopy;

  final String message;

  @override
  List<Object?> get props => [message];
}
