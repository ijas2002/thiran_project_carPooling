import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thiran_project/bloc/app_bloc.dart';
import 'package:thiran_project/auth/auth.dart';
import 'package:thiran_project/views/welcome_views.dart';


class ScreenController extends StatelessWidget {
  const ScreenController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context,snapshot){
        return BlocBuilder<AppBloc,AppState>(builder:(context,state){
          if(state is AppStateLoggedIn){
            return WelcomeView();
          }
          if(state is AppStateLoggedOut){
            return WelcomeView();
          }
          else{
            return Container();
          }
        });
      },
    );
  }
}
