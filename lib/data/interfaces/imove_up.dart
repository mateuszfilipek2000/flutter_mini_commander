import 'package:flutter_mini_commander/data/models/drive_model.dart';
import 'package:flutter_mini_commander/data/models/entities.dart';

abstract class IMoveUp {
  /// if possible 'moves' up the file directory tree based on current location
  /// if successful parent directory content is returned
  Future<List<Iterable<Entity>>> moveUp({
    required Drive currentDirectory,
  });
}
