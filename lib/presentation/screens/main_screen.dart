import 'package:flutter/material.dart';
import 'package:universal_disk_space/universal_disk_space.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final diskSpace = DiskSpace();
            await diskSpace.scan();

            diskSpace.disks.forEach((element) => print(element.mountPath));
          },
          child: const Text(
            "click me",
          ),
        ),
      ),
    );
  }
}
