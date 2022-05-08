/// the built in dart file system entity, file and directory classes are not
/// used here because remote file system will be accessed, dart implementations
/// are going to be used in local implementation
abstract class Entity {
  const Entity({
    required this.path,
  });
  final String path;

  String get name => path.split('/').last;
}
