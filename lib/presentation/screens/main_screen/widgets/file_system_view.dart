import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc_event.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc_state.dart';

class FileSystemView<T extends DirectoryBloc> extends StatelessWidget {
  const FileSystemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: BlocBuilder<T, DirectoryBlocState>(
        builder: (context, state) {
          if (state is DirectoryBlocStateLoadingSuccess) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                state.hasParent
                    ? GestureDetector(
                        onDoubleTap: () => context.read<T>().add(
                              DirectoryBlocDoubleTap(
                                target: state.currentDirectory.parent,
                              ),
                            ),
                        child: const ListTile(
                          title: Text(
                            "..",
                          ),
                        ),
                      )
                    : const SizedBox(),
                Expanded(
                  flex: 9,
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: ScrollController(),
                    itemCount: state.directoryChildren.length,
                    itemBuilder: (context, index) {
                      final item = state.directoryChildren[index];
                      return GestureDetector(
                        onTap: () => context.read<T>().add(
                              DirectoryBlocSelectTarget(target: item),
                            ),
                        onDoubleTap: () => context.read<T>().add(
                              DirectoryBlocDoubleTap(target: item),
                            ),
                        child: ListTile(
                          title: Text(
                            item.name,
                          ),
                          leading: item is Directory
                              ? const Icon(Icons.folder)
                              : null,
                          selected: state.selectedChildren.contains(item),
                        ),
                      );
                    },
                  ),
                ),
              ],
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
