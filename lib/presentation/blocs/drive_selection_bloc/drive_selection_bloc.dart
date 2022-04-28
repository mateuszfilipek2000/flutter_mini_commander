import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/drive_selection_bloc/drive_selection_event.dart';
import 'package:flutter_mini_commander/presentation/blocs/drive_selection_bloc/drive_selection_state.dart';
import 'package:universal_disk_space/universal_disk_space.dart';

class DriveSelectionBloc
    extends Bloc<DriveSelectionEvent, DriveSelectionState> {
  DriveSelectionBloc() : super(const DriveSelectionInitial()) {
    on<DriveSelectionShowAvailableDrives>((event, emit) async {
      final diskSpace = DiskSpace();

      // scanning for available drives
      try {
        await diskSpace.scan();
        final disks = diskSpace.disks;

        log("Succesfully retrieved available drives");

        emit(DriveSelectionLoadingSuccess(disks));
      } catch (e) {
        log("Couldn't retrieve drives");

        emit(DriveSelectionLoadingFailure(e));
      }
    });
  }
}
