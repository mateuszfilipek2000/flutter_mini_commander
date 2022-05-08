import 'package:flutter_mini_commander/data/interfaces/iopen_directory.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc.dart';

class SourceDirectoryBloc extends DirectoryBloc {
  SourceDirectoryBloc({
    required bool isSource,
    required IOpenDirectory openDirectory,
  }) : super(
          isSource: isSource,
          openDirectory: openDirectory,
        );
}
