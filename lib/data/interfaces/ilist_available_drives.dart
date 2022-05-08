import 'package:flutter_mini_commander/data/models/drive_model.dart';

abstract class IListAvailableDrives {
  Future<List<Drive>> getAvailableDrives();
}
