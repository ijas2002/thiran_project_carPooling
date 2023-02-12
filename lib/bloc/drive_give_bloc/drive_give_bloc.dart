import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../auth/auth.dart';
import '../../auth/auth_error.dart';
import 'drive_give_event.dart';
import 'drive_give_state.dart';

class DriveGiveAppBloc extends Bloc <DriveGiveAppEvent, DriveGiveAppState> {
  DriveGiveAppBloc(): super(AppStateDriveGiveSaving(isLoading:false,saveSuccessfull: false )){
    on<AppEventSaveData>((event,emit)async{
      AppStateDriveGiveSaving(isLoading: true,saveSuccessfull: false);
      try{
        await Auth().saveDataToFirestoreDB(name: event.name, id: event.id,
            source: event.source,destination: event.destination,
            apxAmount: event.apxAmount,contactNo: event.contactNo,
            gender: event.gender,vacancySeat: event.vacancySeat);
        emit(AppStateDriveGiveSaving(isLoading:false ,saveSuccessfull: true),);
      }on FirebaseException catch (e){
        print(e);
        authErrorsaving = e.toString();
        emit(AppStateDriveGiveSaving(saveSuccessfull: false, isLoading: false));
      }
    });
  }


}
