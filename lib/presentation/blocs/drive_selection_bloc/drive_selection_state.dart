import 'package:equatable/equatable.dart';
import 'package:universal_disk_space/universal_disk_space.dart';

abstract class DriveSelectionState extends Equatable {
  const DriveSelectionState();
}

class DriveSelectionInitial extends DriveSelectionState {
  const DriveSelectionInitial();
  @override
  List<Object?> get props => [];
}

class DriveSelectionLoading extends DriveSelectionState {
  const DriveSelectionLoading();

  @override
  List<Object?> get props => [];
}

class DriveSelectionLoadingSuccess extends DriveSelectionState {
  const DriveSelectionLoadingSuccess(this.drives);

  final Iterable<Disk> drives;

  @override
  List<Object?> get props => [drives];
}

class DriveSelectionLoadingFailure extends DriveSelectionState {
  const DriveSelectionLoadingFailure(this.exception);

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
