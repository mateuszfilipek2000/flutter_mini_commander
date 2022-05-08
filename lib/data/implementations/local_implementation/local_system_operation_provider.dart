import 'package:flutter_mini_commander/data/implementations/local_implementation/local_copy_entities.dart';
import 'package:flutter_mini_commander/data/implementations/local_implementation/local_list_available_drives.dart';
import 'package:flutter_mini_commander/data/implementations/local_implementation/local_move_up.dart';
import 'package:flutter_mini_commander/data/implementations/local_implementation/local_open_directory.dart';
import 'package:flutter_mini_commander/data/interfaces/ifile_system_operation_provider.dart';

class LocalSystemOperationProvider
    with
        LocalCopyEntites,
        // LocalMoveUp,
        LocalOpenDirectory,
        LocalListAvailableDrives
    implements
        IFileSystemOperationProvider {}
