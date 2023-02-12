import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thiran_project/controllers/email_and_password_controller.dart';
import 'package:thiran_project/views/home_view/home_map_view.dart';

import '../../bloc/app_bloc.dart';

class EmailAndPasswordView extends StatefulWidget {
  const EmailAndPasswordView({Key? key}) : super(key: key);

  @override
  State<EmailAndPasswordView> createState() => _EmailAndPasswordViewState();
}

class _EmailAndPasswordViewState extends State<EmailAndPasswordView> {
  bool visiblePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0), //may be change
        ),
        body: Center(
            child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(left: 25, bottom: 25, top: 25),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Insert your Email & Password",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                          "Insert your Email & password to create your account",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500,
                          )),
                    ],
                  ))),
          Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.alternate_email,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            height: 50,
                            width: 250,
                            child: BlocBuilder<AppBloc, AppState>(
                              builder: (context, state) {
                                return TextField(
                                  controller: emailcontroller,
                                  onSubmitted: (value) {
                                    context.read<AppBloc>().emit(
                                        AppStateLoggedOut(
                                            isLoading: false,
                                            successful: false));
                                  },
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Color(0xFF632DC6))),
                                      hintText: 'Email ID',
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade500),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500))),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.password_outlined,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            height: 50,
                            width: 250,
                            child: BlocBuilder<AppBloc, AppState>(
                              builder: (context, state) {
                                return TextField(
                                  controller: passwordcontroller,
                                  obscureText: visiblePassword,
                                  onSubmitted: (value) {
                                    context.read<AppBloc>().emit(
                                        AppStateLoggedOut(
                                            isLoading: false,
                                            successful: false));
                                  },
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            visiblePassword = !visiblePassword;
                                          });
                                        },
                                        icon: Icon(Icons.remove_red_eye),
                                        color: visiblePassword
                                            ? Colors.grey.shade500
                                            : Colors.red,
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Color(0xFF632DC6))),
                                      hintText: 'password',
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade500),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500))),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<AppBloc, AppState>(
                        builder: (context, state) {
                          return Padding(
                            padding: EdgeInsets.only(top: 50, right: 25),
                            child: Align(
                                alignment: Alignment.center,
                                child: state.isLoading
                                    ? CircularProgressIndicator()
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: SizedBox(
                                          width: 250,
                                          height: 50,
                                          child: MaterialButton(
                                            onPressed: () {
                                              context.read<AppBloc>().add(
                                                  AppEventRegister(
                                                      email:
                                                          emailcontroller.text,
                                                      password:
                                                          passwordcontroller
                                                              .text));
                                              Navigator.of(context).popUntil(
                                                  (route) => route.isFirst);
                                            },
                                            color: Color(0xFF725BBC),
                                            child: Text('configure',style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                      )),
                          );
                        },
                      )
                    ],
                  )))
        ])));
  }
}
