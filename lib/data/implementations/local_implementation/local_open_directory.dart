import 'dart:io';

import 'package:flutter_mini_commander/data/interfaces/iopen_directory.dart';
import 'package:flutter_mini_commander/data/models/directory_model.dart';
import 'package:flutter_mini_commander/data/models/entities.dart';
import 'package:flutter_mini_commander/data/models/file_model.dart';
import 'package:flutter_mini_commander/utils/get_home_directory_path.dart';

class LocalOpenDirectory implements IOpenDirectory {
  @override
  Future<MapEntry<DirectoryModel, Iterable<Entity>>> openDirectory({
    String? targetPath,
  }) async {
    final currentDir = Directory(
      targetPath ?? LocalGetUserHomeDirectoryPath(),
    );
    final contents = currentDir.listSync();
    final currentDirectory = DirectoryModel(
      path: currentDir.path,
      parentPath: currentDir.parent.path != currentDir.path
          ? currentDir.parent.path
          : null,
    );
    return MapEntry(
        currentDirectory,
        Iterable<Entity>.generate(
          contents.length,
          (int i) {
            return contents[i] is Directory
                ? DirectoryModel(
                    path: contents[i].path,
                    parentPath: contents[i].parent.path != contents[i].path
                        ? contents[i].parent.path
                        : null,
                  )
                : FileModel(
                    path: contents[i].path,
                  );
          },
        ));
    // return Directory(targetPath).listSync()..map((e) {
    //   return e is Directory ?
    //   DirectoryModel(path: e.path, name: e.name)
    //   :
    //   FileModel(path: e.path, name: e.name);
    // });
  }
}
