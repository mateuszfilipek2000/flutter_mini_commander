import 'package:flutter_mini_commander/data/interfaces/ilist_available_drives.dart';
import 'package:flutter_mini_commander/data/models/drive_model.dart';
import 'package:universal_disk_space/universal_disk_space.dart';

class LocalListAvailableDrives implements IListAvailableDrives {
  @override
  Future<List<Drive>> getAvailableDrives() async {
    final diskSpace = DiskSpace();

    await diskSpace.scan();
    final disks = diskSpace.disks;

    return disks
        .map(
          (e) => Drive(
            name: e.mountPath,
            path: e.mountPath,
          ),
        )
        .toList();
  }
}
