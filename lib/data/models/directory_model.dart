import 'package:flutter_mini_commander/data/models/entities.dart';

class DirectoryModel extends Entity {
  DirectoryModel({
    required String path,
    this.parentPath,
    // this.contents,
  }) : super(path: path);

  // final Iterable<Entity>? contents;
  // Future<Iterable<Entity>> get listContents {

  // }
  String? parentPath;

  DirectoryModel copyWith({
    String? path,
    String? parentPath,
  }) =>
      DirectoryModel(
        path: path ?? this.path,
        parentPath: parentPath ?? this.parentPath,
      );
}
