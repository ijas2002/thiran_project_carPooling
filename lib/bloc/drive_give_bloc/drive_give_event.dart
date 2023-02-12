
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


abstract class DriveGiveAppEvent extends Equatable {
  const DriveGiveAppEvent();

}

class AppEventSaveData  extends DriveGiveAppEvent {
  final String name;
  final int id;
  final String source;
  final String destination;
  final int apxAmount;
  final int contactNo;
  final String gender;
  final int vacancySeat;


  const AppEventSaveData({
    required this.name, required this.id,
    required this.source, required this.destination,
    required this.apxAmount,required this.contactNo,
    required this.gender,required this.vacancySeat,
  });

  @override
  List<Object?> get props => [name, id,source,destination,apxAmount,contactNo,gender,vacancySeat,];
}
