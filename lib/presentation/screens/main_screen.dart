import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/destination_bloc/destination_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc_event.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc_state.dart';
import 'package:flutter_mini_commander/presentation/blocs/source_bloc/source_directory_bloc.dart';
import 'package:universal_disk_space/universal_disk_space.dart';

extension EntityName on FileSystemEntity {
  String get name => path.split('/').last;
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SourceDirectoryBloc(
            isSource: true,
          )..add(const DirectoryBlocLoadUserHomeContents()),
        ),
        BlocProvider(
          create: (context) => DestinationDirectoryBloc(
            isSource: false,
          )..add(const DirectoryBlocLoadUserHomeContents()),
        ),
      ],
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.red,
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      BlocProvider(
                        create: (context) =>
                            context.read<SourceDirectoryBloc>(),
                        child: const Expanded(
                          child: FileSystemView(),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      BlocProvider(
                        create: (context) =>
                            context.read<DestinationDirectoryBloc>(),
                        child: const Expanded(
                          child: FileSystemView(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FileSystemView extends StatelessWidget {
  const FileSystemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: BlocBuilder<SourceDirectoryBloc, DirectoryBlocState>(
        builder: (context, state) {
          if (state is DirectoryBlocStateLoadingSuccess) {
            return ListView.builder(
              shrinkWrap: true,
              controller: ScrollController(),
              itemCount: state.directoryChildren.length,
              itemBuilder: (context, index) {
                final item = state.directoryChildren[index];
                return ListTile(
                  title: Text(
                    item.name,
                  ),
                  leading: item is Directory ? const Icon(Icons.folder) : null,
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
