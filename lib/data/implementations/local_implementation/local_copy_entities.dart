import 'dart:developer';
import 'dart:io';

import 'package:flutter_mini_commander/data/interfaces/icopy_entities.dart';
import 'package:flutter_mini_commander/data/models/entities.dart';
import 'package:flutter_mini_commander/data/models/file_model.dart';
import 'package:io/io.dart';

extension EntityName on FileSystemEntity {
  String get name => path.split('/').last;
}

class LocalCopyEntites implements ICopyEntities {
  @override
  Future<void> copy({
    required String targetDirPath,
    required Iterable<Entity> fileSystemEntities,
  }) async {
    List<String> notCopied = [];

    log(fileSystemEntities.toList().toString());

    for (final entity in fileSystemEntities) {
      try {
        if (entity is FileModel) {
          //copy file directly to target path

          //casting file model to dart file implementation
          final file = File(entity.path);
          await file.copy("$targetDirPath/${file.name}");
        } else {
          //copy directory saving its file structure
          final item = Directory(entity.path);
          await copyPath(
            item.path,
            "$targetDirPath/${item.name}",
          );
        }
      } catch (e) {
        notCopied.add(entity.name);
      }
    }

    if (notCopied.isNotEmpty) {
      throw Exception(
        "Couldn't copy: " + notCopied.join(", "),
      );
    }
  }
}
