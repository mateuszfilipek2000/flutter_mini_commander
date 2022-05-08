import 'package:flutter_mini_commander/data/models/entities.dart';

abstract class DirectoryBlocEvent {
  const DirectoryBlocEvent();
}

class DirectoryBlocLoadFolderContentsEvent extends DirectoryBlocEvent {
  const DirectoryBlocLoadFolderContentsEvent({
    this.target,
  });

  final String? target;
}

class DirectoryBlocSelectTarget extends DirectoryBlocEvent {
  const DirectoryBlocSelectTarget({
    required this.target,
  });

  final Entity target;
}

class DirectoryBlocLoadUserHomeContents extends DirectoryBlocEvent {
  const DirectoryBlocLoadUserHomeContents();
}

class DirectoryBlocDoubleTap extends DirectoryBlocEvent {
  const DirectoryBlocDoubleTap({
    required this.target,
  });

  final Entity target;
}
