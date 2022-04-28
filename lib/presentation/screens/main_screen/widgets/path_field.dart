import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc_state.dart';

class PathField<T extends DirectoryBloc> extends StatelessWidget {
  const PathField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<T, DirectoryBlocState>(
        builder: (context, state) {
          if (state is DirectoryBlocStateLoadingSuccess) {
            return TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: state.currentDirectory.path,
              ),
            );
          }
          return const TextField(
            enabled: false,
            decoration: InputDecoration(
              hintText: "Path",
            ),
          );
        },
      ),
    );
  }
}
