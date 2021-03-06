import 'package:flutter_mini_commander/data/models/directory_model.dart';
import 'package:flutter_mini_commander/data/models/entities.dart';

abstract class IOpenDirectory {
  /// if possible 'opens' the target directory
  /// if successful target directory content is returned
  Future<MapEntry<DirectoryModel, Iterable<Entity>>> openDirectory({
    String? targetPath,
  });
}
