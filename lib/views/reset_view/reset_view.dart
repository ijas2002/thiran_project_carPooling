import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thiran_project/bloc/app_bloc.dart';
import 'package:thiran_project/controllers/email_and_password_controller.dart';

import '../welcome_views.dart';

void ResetPasswordView(BuildContext context) {
  showModalBottomSheet(context: context, builder: (context)=> SingleChildScrollView(
    child: Container(
      padding:
      EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 5),
            child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  height: 3,width: 40,color: Colors.grey.shade500,
                ),
              ),
          ),),
          Padding(padding: EdgeInsets.only(left: 25,top: 25),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Reset Password',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                  Text('Insert your Email below \n We gonna send you a link to reset your password',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.grey.shade500),),
                  Padding(padding: EdgeInsets.only(top: 25),
                  child: Row(
                    children: [
                      Icon(Icons.alternate_email,color: Colors.grey.shade500,),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 50,
                          width: 250,
                          child: TextField(
                            controller: emailResetcontroller,
                            decoration:InputDecoration(
                              hintText: 'Email ID',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)
                              )
                            ) ,
                          ),
                      )
                    ],
                  ),)
                ],
              ),
            ),),
          Padding(padding: EdgeInsets.only(top: 25,bottom: 25),
          child: ClipRRect(
            borderRadius : BorderRadius.circular(12),
            child: SizedBox(
              height: 50,
                width: 200,
              child: BlocBuilder<AppBloc,AppState>(
                builder: (context,state){
                  return MaterialButton(
                      onPressed: (){
                        context.read<AppBloc>().add(AppEventResetPassword(
                            email: emailResetcontroller.text));
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeView(),));
                        showDialog(context: context, builder: (context)=>CupertinoAlertDialog(
                          title: Text('Email sended'),
                          content: Text('An Email with your password recovery link was send to Email provided'),
                          actions: [
                            CupertinoDialogAction(child: Text('ok'),onPressed: ()=>Navigator.pop(context),)
                          ],
                        ));
                        
                    
                  },
                    child: Text('sent'),

                  );

                },
              ),
            ),
          ),)

        ],
      ),
    ),
  ));
}