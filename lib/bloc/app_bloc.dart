import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thiran_project/auth/auth_error.dart';

import '../auth/auth.dart';
import '../views/home_view/home_map_view.dart';
import '../views/register_view/ride_give_view.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc <AppEvent, AppState> {

  AppBloc() : super(
      AppStateLoggedOut(isLoading: false, successful: false)) {
    on<AppEventLogIn>((event, emit) async{
      AppStateLoggedOut(isLoading: true, successful: false);
      try{

        await Auth().signInWithEmailAndPassword(email: event.email,password:event.password);
        emit(AppStateLoggedIn(isLoading: false, successful: true));

      } on FirebaseAuthException catch (e){
        print(e);
        authErrorlogin = e.toString();
        emit(AppStateLoggedOut(isLoading: false, successful: false));
      }
      // TODO: implement event handler
    });

    on<AppEventLogOut>((event, emit) async{

      try{
        emit(AppStateLoggedOut(isLoading: true, successful: false));
        await Auth().signOut();
        emit(AppStateLoggedOut(isLoading: false, successful: true));
      } on FirebaseAuthException catch (e){

      }
      // TODO: implement event handler
    });

    on<AppEventRegister>((event, emit) async{

      try{
        emit(AppStateLoggedOut(isLoading: true, successful: false));
        await Auth().createUserWithEmailAndPassword(email: event.email,password:event.password);
        emit(AppStateLoggedIn(isLoading: false, successful: true));
      } on FirebaseAuthException catch (e){
        print(e);
        authErrorlogin = e.toString();
        emit(AppStateLoggedOut(isLoading: false, successful: false));
      }
      // TODO: implement event handler
    });
    on<AppEventResetPassword>((event, emit) async{

      try{
        emit(AppStateLoggedOut(isLoading: true, successful: false));
        await Auth().sendResetPasswordEmail(email: event.email);
        emit(AppStateLoggedIn(isLoading: false, successful: false));
      } on FirebaseAuthException catch (e){
        print(e);
        authErrorlogin = e.toString();
        emit(AppStateLoggedOut(isLoading: false, successful: false));
      }
      // TODO: implement event handler
    });




  }
}
