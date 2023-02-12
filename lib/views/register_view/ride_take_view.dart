import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:thiran_project/Repository_drive_take_give/user_model.dart';
import 'package:thiran_project/views/register_view/ride_take_lis_view.dart';
import '../../Repository_drive_take_give/user_rep.dart';
import '../../bloc/drive_give_bloc/drive_give_bloc.dart';
import '../../bloc/drive_give_bloc/drive_give_state.dart';
import '../../controllers/ride_take_controller.dart';

class DriveTakePage extends StatefulWidget {
  const DriveTakePage({Key? key}) : super(key: key);

  @override
  State<DriveTakePage> createState() => _DriveTakePageState();
}

class _DriveTakePageState extends State<DriveTakePage> {
  final _formKey = GlobalKey<FormState>();
  late DriveGiveAppBloc _driveGiveAppBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Drive Take"),
          backgroundColor: Color(0xFF725BBC),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: searchNameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(color: Colors.black45),
                      focusedBorder:
                      UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF632DC6))),
                    ),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Please enter a name";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: searchIdController,
                    decoration: InputDecoration(
                      labelText: "Valid Id",
                      labelStyle: TextStyle(color: Colors.black45),
                      focusedBorder:
                      UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF632DC6))),
                    ),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Please enter an id";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: searchSourceController,
                    decoration: InputDecoration(
                      labelText: "Source",
                      labelStyle: TextStyle(color: Colors.black45),
                      focusedBorder:
                      UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF632DC6))),
                    ),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Please enter a source";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: searchDestinationController,
                    decoration: InputDecoration(
                      labelText: "Destination",
                      labelStyle: TextStyle(color: Colors.black45),
                      focusedBorder:
                      UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF632DC6))),
                    ),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Please enter a destination";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: searchSeatNeedController,
                    decoration: InputDecoration(
                      labelText: "Number of seat needed",
                      labelStyle: TextStyle(color: Colors.black45),
                      focusedBorder:
                      UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF632DC6))),
                    ),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Please enter seat required";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: searchContactNoController,
                    decoration: InputDecoration(
                      labelText: "Contact Number",
                      labelStyle: TextStyle(color: Colors.black45),
                      focusedBorder:
                      UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF632DC6))),
                    ),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Please enter a contact number";
                      }
                      return null;
                    },
                  ),

                  TextField(
                    controller: searchDateController,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Enter Date of Departure",
                      labelStyle: TextStyle(color: Colors.black45),
                      focusedBorder:
                      UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF632DC6))),
                    ),
                    readOnly: true,

                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        setState(() {
                          searchDateController.text = formattedDate;
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  ),
                  //
                  TextField(
                    controller: searchTimeController,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                      icon: Icon(Icons.timer),
                      labelText: "Enter Time",
                      labelStyle: TextStyle(color: Colors.black45),
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
                          searchTimeController.text = formattedTime;
                        });
                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),

                  MaterialButton(
                    color: Color(0xFF725BBC),
                    onPressed: () async {
                      print("${searchSourceController}");
                      if (_formKey.currentState!.validate()) {
                        //String sourceData = searchSourceController.text;
                        // List<UserModel> retData = await retrieveDataFromFirebase() as  List<UserModel> ;
                        Navigator.push
                          (
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisplayDriveTakeListView(
                                sourceData: searchSourceController.text,
                                seatNead:
                                    int.parse(searchSeatNeedController.text)),
                          ),
                        );

                      }
                    },
                    child: Text(
                      "search",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
  @override
  void dispose(){
    searchNameController.clear();
    searchSeatNeedController.clear();
    searchSourceController.clear();
    searchContactNoController.clear();
    searchDateController.clear();
    searchDestinationController.clear();
    searchIdController.clear();
    searchTimeController.clear();
    super.dispose();

  }
}
