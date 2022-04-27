import 'dart:io';

String getUserHomeDirectoryPath() {
  String? home = "";
  Map<String, String> envVars = Platform.environment;

  if (Platform.isMacOS) {
    home = envVars['HOME'];
  } else if (Platform.isLinux) {
    home = envVars['HOME'];
  } else if (Platform.isWindows) {
    home = envVars['UserProfile'];
  }

  if (home != null) {
    return home;
  }

  throw Exception("Couldn't retrieve user home folder");
}
