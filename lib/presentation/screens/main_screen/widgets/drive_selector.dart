import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/directory_bloc/directory_bloc_event.dart';
import 'package:flutter_mini_commander/presentation/blocs/drive_selection_bloc/drive_selection_bloc.dart';
import 'package:flutter_mini_commander/presentation/blocs/drive_selection_bloc/drive_selection_event.dart';
import 'package:flutter_mini_commander/presentation/blocs/drive_selection_bloc/drive_selection_state.dart';

class DriveSelector<T extends DirectoryBloc, V extends DriveSelectionBloc>
    extends StatelessWidget {
  const DriveSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<V, DriveSelectionState>(
      listener: (context, state) {
        if (state is DriveSelectionLoadingSuccess) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return AlertDialog(
                content: SizedBox(
                  height: 300.0,
                  width: 175.0,
                  child: SelectableList(
                    onConfirm: (String selectedDrive) => context.read<T>().add(
                          DirectoryBlocLoadFolderContentsEvent(
                            target: selectedDrive,
                          ),
                        ),
                    items: state.drives.map((disk) => disk.path),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              );
            },
          );
        }
      },
      child: ElevatedButton(
        onPressed: () => context.read<V>().add(
              const DriveSelectionShowAvailableDrives(),
            ),
        child: const Text("Select Drive"),
      ),
    );
  }
}

class SelectableList extends StatefulWidget {
  const SelectableList({
    Key? key,
    required this.onConfirm,
    required this.items,
  }) : super(key: key);

  final Function(String) onConfirm;
  final Iterable<String> items;

  @override
  State<SelectableList> createState() => _SelectableListState();
}

class _SelectableListState extends State<SelectableList> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      // mainAxisAlignment: MainAxisAlignment,
      children: [
        Expanded(
          flex: 9,
          child: ListView.builder(
            // shrinkWrap: true,
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              final item = widget.items.elementAt(index);
              return ListTile(
                selected: index == selectedIndex,
                title: Text(item),
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              );
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                child: const Text("Select"),
                onPressed: selectedIndex == null
                    ? null
                    : () {
                        widget.onConfirm(
                          widget.items.elementAt(selectedIndex!),
                        );
                        Navigator.of(context).pop();
                      },
              ),
            ],
          ),
        )
      ],
    );
  }
}
