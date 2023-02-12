import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/drive_give_bloc/drive_give_bloc.dart';
import 'package:flutter/src/material/dialog.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../bloc/drive_give_bloc/drive_give_state.dart';
import 'package:thiran_project/bloc/drive_give_bloc/drive_give_event.dart';

import '../../controllers/ride_give_controller.dart';
import '../home_view/home_map_view.dart';
import '../popView.dart';

class DriveGivePage extends StatefulWidget {
  final Stream<QuerySnapshot> user =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  _DriveGivePageState createState() => _DriveGivePageState();
}

class _DriveGivePageState extends State<DriveGivePage> {

  final _formKey = GlobalKey<FormState>();
  late DriveGiveAppBloc _driveGiveAppBloc;

  @override
  void initState() {
    super.initState();
    _driveGiveAppBloc = DriveGiveAppBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriveGiveAppBloc, DriveGiveAppState>(
  builder: (context, state) {
    if(state is AppStateDriveGiveSaving){
      bool _isNameValid = true;
      return Scaffold(
        appBar: AppBar(
          title: Text("Drive Give"),backgroundColor: Color(0xFF725BBC),
        ),
        body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(color: Colors.black45),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF632DC6))),),

                        validator: (value) {
                          if (value.toString().isEmpty) {
                            _isNameValid = false;
                            return "Please enter a name";
                          }
                          _isNameValid = true;
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _isNameValid = true;
                          });
                        },
                      ),
                      TextFormField(
                        controller: idController,
                        decoration: InputDecoration(labelText: "Id",labelStyle: TextStyle(color: Colors.black45),focusedBorder:
                        UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF632DC6))),),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "Please enter an id";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: sourceController,
                        decoration: InputDecoration(labelText: "Source",labelStyle: TextStyle(color: Colors.black45),focusedBorder:
                        UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF632DC6))),),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "Please enter a source";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: destinationController,
                        decoration: InputDecoration(labelText: "Destination",labelStyle: TextStyle(color: Colors.black45),focusedBorder:
                        UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF632DC6))),),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "Please enter a destination";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: apxAmountController,
                        decoration:
                        InputDecoration(labelText: "Approximate Amount",labelStyle: TextStyle(color: Colors.black45),focusedBorder:
                        UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF632DC6))),),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "Please enter approximate amount";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: contactNoController,
                        decoration: InputDecoration(labelText: "Contact Number",labelStyle: TextStyle(color: Colors.black45),focusedBorder:
                        UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF632DC6))),),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "Please enter a contact number";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: genderController,
                        decoration: InputDecoration(labelText: "Gender",labelStyle: TextStyle(color: Colors.black45),focusedBorder:
                        UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF632DC6))),),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "Please enter a gender";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: vacancySeatController,
                        decoration: InputDecoration(labelText: "Vacancy Seat",labelStyle: TextStyle(color: Colors.black45),focusedBorder:
                        UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF632DC6))),),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "Please enter a vacancy seat";
                          }
                          return null;
                        },
                      ),

                      TextField(
                        controller: dateController,
                        //editing controller of this TextField
                        decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today,color:  Colors.black45,), //icon of text field
                          labelText:
                          "Enter Date of Departure" ,labelStyle: TextStyle(color: Colors.black45),focusedBorder:
                        UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF632DC6))),//label text of field
                        ),
                        readOnly: true,
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              dateController.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                      //
                      TextField(
                        controller: timeController,
                        //editing controller of this TextField
                        decoration: InputDecoration(
                          icon: Icon(Icons.timer,color:  Colors.black45,), //icon of text field
                          labelText: "Enter Time",labelStyle: TextStyle(color: Colors.black45),
                          focusedBorder:
                          UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF632DC6))),
                        ),
                        readOnly: true,
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );

                          if (pickedTime != null) {
                            DateTime parsedTime = DateFormat('HH:mm')
                                .parse(pickedTime.format(context).toString());

                            String formattedTime =
                            DateFormat('HH:mm').format(parsedTime);

                            setState(() {
                              timeController.text = formattedTime;
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      ),

                      Padding(padding: EdgeInsets.all(5),
                        child: Align(
                          alignment: Alignment.center,
                          
                          child: state.isLoading?CircularProgressIndicator(): 
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: MaterialButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()){
                                context.read<DriveGiveAppBloc>().add(AppEventSaveData(name: nameController.text,id: int.parse(idController.text),
                                    source: sourceController.text,destination: destinationController.text,apxAmount: int.parse(apxAmountController.text), contactNo: int.parse(contactNoController.text),
                                  gender: genderController.text,vacancySeat: int.parse(vacancySeatController.text),));}
                                if(state.saveSuccessfull){showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    title: Text("Success",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                    content: Text("Data saved successfully",textAlign: TextAlign.center),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeView()));
                                          dispose();
                                        },
                                        child: Text("OK",
                                          style: TextStyle(fontSize: 20,color: Color(0xFF5A41D6),),
                                          textAlign: TextAlign.start,),
                                      ),
                                    ],

                                  );
                                });}



                              },
                              color: Color(0xFF725BBC),
                              child: Text("Save",style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )


      );
    }
    else{return Container();}

  },
);
  }

  @override
  void dispose(){
    nameController.clear();
    idController.clear();
    sourceController.clear();
    destinationController.clear();
    apxAmountController.clear();
    contactNoController.clear();
    genderController.clear();
    vacancySeatController.clear();
    dateController.clear();
    timeController.clear();
    super.dispose();

  }
}
