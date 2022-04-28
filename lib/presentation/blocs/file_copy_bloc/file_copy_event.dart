import 'dart:io';

abstract class FileCopyEvent {
  const FileCopyEvent();
}

class FileCopyCopyFiles extends FileCopyEvent {
  const FileCopyCopyFiles({
    required this.filesToCopy,
    required this.targetDirectory,
  });

  final List<FileSystemEntity> filesToCopy;
  final Directory targetDirectory;
}
