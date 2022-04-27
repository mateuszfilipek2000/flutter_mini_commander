import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/destination_bloc/destination_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc_event.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc_state.dart';
import 'package:flutter_mini_commander/presentation/blocs/source_bloc/source_directory_bloc.dart';

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
          lazy: false,
        ),
        BlocProvider(
          create: (context) => DestinationDirectoryBloc(
            isSource: false,
          )..add(const DirectoryBlocLoadUserHomeContents()),
          lazy: false,
        ),
      ],
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
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
            )
          ],
        ),
      ),
    );
  }
}

class FileSystemView<T extends DirectoryBloc> extends StatelessWidget {
  const FileSystemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: BlocBuilder<T, DirectoryBlocState>(
        builder: (context, state) {
          if (state is DirectoryBlocStateLoadingSuccess) {
            return ListView.builder(
              // shrinkWrap: true,
              controller: ScrollController(),
              itemCount: state.directoryChildren.length,
              itemBuilder: (context, index) {
                final item = state.directoryChildren[index];
                return ListTile(
                  title: Text(
                    item.name,
                  ),
                  leading: item is Directory ? const Icon(Icons.folder) : null,
                  onTap: () => context.read<T>().add(
                        DirectoryBlocSelectTarget(target: item),
                      ),
                  selected: state.selectedChildren.contains(item),
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
