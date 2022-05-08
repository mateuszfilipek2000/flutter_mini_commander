import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini_commander/data/interfaces/ilist_available_drives.dart';
import 'package:flutter_mini_commander/presentation/blocs/drive_selection_bloc/drive_selection_event.dart';
import 'package:flutter_mini_commander/presentation/blocs/drive_selection_bloc/drive_selection_state.dart';

class DriveSelectionBloc
    extends Bloc<DriveSelectionEvent, DriveSelectionState> {
  DriveSelectionBloc({
    required this.driveListProvider,
  }) : super(const DriveSelectionInitial()) {
    on<DriveSelectionShowAvailableDrives>((event, emit) async {
      // scanning for available drives
      try {
        final disks = await driveListProvider.getAvailableDrives();

        emit(DriveSelectionLoadingSuccess(disks));
      } catch (e) {
        log("Couldn't retrieve drives");

        emit(DriveSelectionLoadingFailure(e));
      }
    });
  }

  final IListAvailableDrives driveListProvider;
}
