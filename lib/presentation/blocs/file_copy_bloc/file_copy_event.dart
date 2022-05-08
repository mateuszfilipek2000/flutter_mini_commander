import 'package:flutter_mini_commander/data/models/directory_model.dart';
import 'package:flutter_mini_commander/data/models/entities.dart';

abstract class FileCopyEvent {
  const FileCopyEvent();
}

class FileCopyCopyFiles extends FileCopyEvent {
  const FileCopyCopyFiles({
    required this.filesToCopy,
    required this.targetDirectory,
  });

  final List<Entity> filesToCopy;
  final DirectoryModel targetDirectory;
}
