import 'package:flutter_mini_commander/data/models/entities.dart';

abstract class ICopyEntities {
  /// copies all
  Future<void> copy({
    required String targetDirPath,
    required Iterable<Entity> fileSystemEntities,
  });
}
