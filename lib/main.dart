import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thiran_project/bloc/app_bloc.dart';
import 'bloc/drive_give_bloc/drive_give_bloc.dart';
import 'controllers/login_controller.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:thiran_project/views/home_view/home_map_view.dart';
import 'package:thiran_project/views/register_view/ride_take_view.dart';
import 'package:thiran_project/views/welcome_views.dart';
import 'package:flutter_stripe/flutter_stripe.dart';


Future<void> main() async {
  //for flutter sync with app
  WidgetsFlutterBinding.ensureInitialized();
  // Stripe.publishableKey = stipePublishableKey;
  // await Stripe.instance.applySettings();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF7453B0),
        systemNavigationBarColor: Color(0xFF632DC6),
        systemNavigationBarIconBrightness: Brightness.light));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc(),
        ),
        BlocProvider(
          create: (context) => DriveGiveAppBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',

        theme: ThemeData(
            primaryColor: Colors.white, backgroundColor: Color(0xFF2C1341)),
        home: ScreenController(),

      ),
    );
  }
}
