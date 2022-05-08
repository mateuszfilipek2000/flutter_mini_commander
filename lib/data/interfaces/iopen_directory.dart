import 'package:flutter_mini_commander/data/models/entities.dart';

abstract class IOpenDirectory {
  /// if possible 'opens' the target directory
  /// if successful target directory content is returned
  Future<Iterable<Entity>> openDirectory({
    String? targetPath,
  });
}
