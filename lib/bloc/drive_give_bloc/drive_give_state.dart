import 'package:equatable/equatable.dart';

abstract class DriveGiveAppState extends Equatable {
  const DriveGiveAppState();
}

class AppStateDriveGiveInitial extends DriveGiveAppState {
  @override
  List<Object?> get props => [];
}
class DriveGiveAppStateLoading extends DriveGiveAppState {
   final bool isLoading;


  const DriveGiveAppStateLoading({
    required this.isLoading
  });

  @override
  List<Object> get props => [isLoading];
}

class AppStateDriveGiveSaving extends DriveGiveAppState {

  final bool isLoading;

  final bool saveSuccessfull;

  const AppStateDriveGiveSaving({

    required this.saveSuccessfull,
    required this.isLoading,
  });

  @override
  List<Object?> get props => [isLoading, saveSuccessfull];
}

class AppStateDriveGiveSuccess extends DriveGiveAppState {
  @override
  List<Object?> get props => [];
}

class AppStateDriveGiveFailure extends DriveGiveAppState {
  final String error;

  const AppStateDriveGiveFailure({required this.error});

  @override
  List<Object?> get props => [error];
}