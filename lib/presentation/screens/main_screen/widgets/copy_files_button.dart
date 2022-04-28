import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc_state.dart';
import 'package:flutter_mini_commander/presentation/blocs/file_copy_bloc/file_copy_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/file_copy_bloc/file_copy_event.dart';
import 'package:flutter_mini_commander/presentation/blocs/file_copy_bloc/file_copy_state.dart';

class CopyFilesButton<S extends DirectoryBloc, D extends DirectoryBloc>
    extends StatelessWidget {
  const CopyFilesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocListener<FileCopyBloc, FileCopyState>(
        listener: (context, state) {
          if (state is FileCopyFinishedCopying) {
            if (state.failedToCopy.isNotEmpty) {
              showDialog(
                  builder: (BuildContext context) {
                    return Container();
                  },
                  context: context);
            }
          }
        },
        child: BlocBuilder<S, DirectoryBlocState>(
          builder: (context, state) {
            // checking if both source and directory folders are loaded properly
            final sourceState = context.read<S>().state;
            final destinationState = context.read<D>().state;

            return ElevatedButton(
              onPressed: sourceState is DirectoryBlocStateLoadingSuccess &&
                      destinationState is DirectoryBlocStateLoadingSuccess &&
                      sourceState.selectedChildren.isNotEmpty
                  ? () => context.read<FileCopyBloc>().add(
                        FileCopyCopyFiles(
                          filesToCopy: sourceState.selectedChildren,
                          targetDirectory: destinationState.currentDirectory,
                        ),
                      )
                  : null,
              child: const Text("Copy files"),
            );
          },
        ),
      ),
    );
  }
}
