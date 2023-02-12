import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thiran_project/auth/auth_error.dart';
import 'package:thiran_project/bloc/app_bloc.dart';
import 'package:thiran_project/views/reset_view/reset_view.dart';
import '../controllers/email_and_password_controller.dart';
import 'home_view/home_map_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool visiblePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      if (state is AppStateLoggedIn) {
        return HomeView();
      }
      if (state is AppStateLoggedOut) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0,
              backgroundColor: Colors.white.withOpacity(0),
            ),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 25, bottom: 25, top: 25,right: 25),
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
                                      child: TextField(
                                        controller: emailcontroller,
                                        autofocus: true,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                            focusedBorder:
                                                UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color(0xFF632DC6))),
                                            hintText: 'Email ID',
                                            hintStyle: TextStyle(
                                                color: Colors.grey.shade500),
                                            enabledBorder:
                                                UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade500))),
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
                                      child: TextField(
                                        controller: passwordcontroller,
                                        obscureText: visiblePassword,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  visiblePassword =
                                                      !visiblePassword;
                                                });
                                              },
                                              icon:
                                                  Icon(Icons.remove_red_eye),
                                              color: visiblePassword
                                                  ? Colors.grey.shade500
                                                  : Colors.red,
                                            ),
                                            focusedBorder:
                                                UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color(0xFF632DC6))),
                                            hintText: 'password',
                                            hintStyle: TextStyle(
                                                color: Colors.grey.shade500),
                                            enabledBorder:
                                                UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade500))),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ))),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: authErrorlogin != ''
                          ? Text(
                              textAlign: TextAlign.center,
                              authErrorlogin.split(']')[1],
                              style: const TextStyle(
                                  color: Colors.red, fontWeight: FontWeight.bold),
                            )
                          : null,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(children: [
                          state.isLoading
                              ? CircularProgressIndicator()
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: MaterialButton(
                                    onPressed: () {
                                      context.read<AppBloc>().add(AppEventLogIn(
                                          email: emailcontroller.text,
                                          password: passwordcontroller.text));
                                    },
                                    color: Color(0xFF725BBC),
                                    child: Text('login',style: TextStyle(color: Colors.white),),
                                  ),
                                ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: TextButton(
                              onPressed: () {
                                ResetPasswordView(context);
                              },
                              child: Text("forget your password",style: TextStyle(color: Color(0xFF2C1341)),),
                            ),
                          )
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ));
      } else {
        return Container();
      }
    });
  }
}
