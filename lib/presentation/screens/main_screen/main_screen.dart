import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini_commander/data/interfaces/ifile_system_operation_provider.dart';
import 'package:flutter_mini_commander/presentation/blocs/destination_bloc/destination_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/destination_drive_selection_bloc/destination_drive_selection_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc_event.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc_state.dart';
import 'package:flutter_mini_commander/presentation/blocs/file_copy_bloc/file_copy_state.dart';
import 'package:flutter_mini_commander/presentation/blocs/source_bloc/source_directory_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/source_drive_selection_bloc/source_drive_selection_bloc.dart';
import 'package:flutter_mini_commander/presentation/screens/main_screen/widgets/copy_files_button.dart';
import 'package:flutter_mini_commander/presentation/screens/main_screen/widgets/drive_selector.dart';
import 'package:flutter_mini_commander/presentation/screens/main_screen/widgets/file_system_view.dart';
import 'package:flutter_mini_commander/presentation/screens/main_screen/widgets/path_field.dart';

import '../../blocs/file_copy_bloc/file_copy_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SourceDirectoryBloc(
            isSource: true,
            openDirectory:
                RepositoryProvider.of<IFileSystemOperationProvider>(context),
          )..add(const DirectoryBlocLoadUserHomeContents()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => DestinationDirectoryBloc(
            isSource: false,
            openDirectory:
                RepositoryProvider.of<IFileSystemOperationProvider>(context),
          )..add(const DirectoryBlocLoadUserHomeContents()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => SourceDriveSelectionBloc(
            driveListProvider:
                RepositoryProvider.of<IFileSystemOperationProvider>(context),
          ),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => DestinationDriveSelectionBloc(
            driveListProvider:
                RepositoryProvider.of<IFileSystemOperationProvider>(context),
          ),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => FileCopyBloc(
            copyProvider:
                RepositoryProvider.of<IFileSystemOperationProvider>(context),
          ),
          lazy: false,
        ),
      ],
      child: BlocListener<FileCopyBloc, FileCopyState>(
        listener: (context, state) {
          if (state is FileCopyFinishedCopying) {
            final destinationDirectoryState =
                context.read<DestinationDirectoryBloc>().state;
            if (destinationDirectoryState is DirectoryBlocStateLoadingSuccess) {
              context.read<DestinationDirectoryBloc>().add(
                    DirectoryBlocLoadFolderContentsEvent(
                      target: destinationDirectoryState.currentDirectory.path,
                    ),
                  );
            }
          }
        },
        child: Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(child: PathField<SourceDirectoryBloc>()),
                    Expanded(child: PathField<DestinationDirectoryBloc>())
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    DriveSelector<SourceDirectoryBloc,
                        SourceDriveSelectionBloc>(),
                    DriveSelector<DestinationDirectoryBloc,
                        DestinationDriveSelectionBloc>(),
                  ],
                ),
              ),
              Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: const [
                      Expanded(
                        child: FileSystemView<SourceDirectoryBloc>(),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: FileSystemView<DestinationDirectoryBloc>(),
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                flex: 1,
                child: CopyFilesButton<SourceDirectoryBloc,
                    DestinationDirectoryBloc>(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
