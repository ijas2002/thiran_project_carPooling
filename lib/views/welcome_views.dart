import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thiran_project/views/register_view/email_view.dart';

import '../auth/auth_error.dart';
import 'login_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/3636253.jpg'),),


              const Text("welcome",
                style: TextStyle(
                fontSize: 50,fontStyle: FontStyle.italic,fontWeight:FontWeight.bold,fontFamily: 'Trebuchet MS'

                ),),
              Text("Sharing the ride, sharing the cost, sharing the responsibility"),
              SizedBox(
                height: 50,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: EmailAndPasswordView(),
                                type: PageTransitionType.rightToLeftWithFade,
                                duration: Duration(milliseconds: 250)));
                      },
                      color: Color(0xFF725BBC),
                      child: const Center(
                        child: Text("create account",style: TextStyle(color: Colors.white),),
                      )),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        (PageTransition(
                            child: LoginView(),
                            type: PageTransitionType.fade)));
                  },
                  child: Text("I already have account",style: TextStyle(color: Color(0xFF2C1341)),)),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: authErrorRegister != ''
                    ? Text(
                        authErrorRegister.split(']')[1],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      )
                    : null,
              ),
            ],
          ),
        ));
  }
}
