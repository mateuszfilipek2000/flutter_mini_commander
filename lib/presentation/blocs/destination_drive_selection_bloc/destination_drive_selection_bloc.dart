import 'package:flutter_mini_commander/data/interfaces/ilist_available_drives.dart';
import 'package:flutter_mini_commander/presentation/blocs/drive_selection_bloc/drive_selection_bloc.dart';

class DestinationDriveSelectionBloc extends DriveSelectionBloc {
  DestinationDriveSelectionBloc({
    required IListAvailableDrives driveListProvider,
  }) : super(driveListProvider: driveListProvider);
}
