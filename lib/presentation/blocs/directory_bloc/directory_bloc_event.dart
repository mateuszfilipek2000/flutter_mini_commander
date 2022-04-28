import 'dart:io';

abstract class DirectoryBlocEvent {
  const DirectoryBlocEvent();
}

class DirectoryBlocLoadFolderContentsEvent extends DirectoryBlocEvent {
  const DirectoryBlocLoadFolderContentsEvent({
    required this.target,
  });

  final FileSystemEntity target;
}

class DirectoryBlocSelectTarget extends DirectoryBlocEvent {
  const DirectoryBlocSelectTarget({
    required this.target,
  });

  final FileSystemEntity target;
}

class DirectoryBlocLoadUserHomeContents extends DirectoryBlocEvent {
  const DirectoryBlocLoadUserHomeContents();
}

class DirectoryBlocDoubleTap extends DirectoryBlocEvent {
  const DirectoryBlocDoubleTap({
    required this.target,
  });

  final FileSystemEntity target;
}
