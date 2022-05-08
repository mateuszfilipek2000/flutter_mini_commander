import 'package:flutter_mini_commander/data/interfaces/icopy_entities.dart';
import 'package:flutter_mini_commander/data/interfaces/ilist_available_drives.dart';
import 'package:flutter_mini_commander/data/interfaces/imove_up.dart';
import 'package:flutter_mini_commander/data/interfaces/iopen_directory.dart';

abstract class IFileSystemOperationProvider
    implements ICopyEntities, IMoveUp, IOpenDirectory, IListAvailableDrives {}
