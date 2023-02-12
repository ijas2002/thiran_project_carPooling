import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thiran_project/Repository_drive_take_give/user_model.dart';
import 'package:thiran_project/controllers/ride_give_controller.dart';
import 'package:thiran_project/views/register_view/paymentMethod/cardList.dart';

import '../../Repository_drive_take_give/user_rep.dart';
import '../../controllers/ride_take_controller.dart';

class DisplayDriveTakeListView extends StatefulWidget {
  final String sourceData;
  final int seatNead;

  // DocumentSnapshot<Map<String,dynamic>>Document;
  const DisplayDriveTakeListView(
      {Key? key, required this.sourceData, required this.seatNead})
      : super(key: key);

  //String get sourceData => _sourceData;
  //String _sourceData;

  @override
  State<DisplayDriveTakeListView> createState() =>
      _DisplayDriveTakeListViewState();
}

class _DisplayDriveTakeListViewState extends State<DisplayDriveTakeListView> {
  //String get sourceData => this.sourceData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List of cars"),backgroundColor: Color(0xFF725BBC),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: FutureBuilder<List<UserModel>>(
                future: retrieveDataFromFirebase(widget.sourceData),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      //UserModel userdata=snapshot.data as UserModel;

                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (c, index) {
                            return Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: ListTile(
                                    onTap: () {
                                      if (snapshot.data![index].vacancySeat >=
                                          widget.seatNead) {
                                        int updatedVacancySeat;
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                CupertinoAlertDialog(
                                                  title: Text(
                                                      'BOOK THE SEAT REQUIRE'),
                                                  content: Container(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            "vacancy seat:${snapshot.data![index].vacancySeat}"),
                                                        Text(
                                                            "seat need:${widget.seatNead}"),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    CupertinoDialogAction(
                                                        child: Text('BOOK',textAlign:TextAlign.center,style: TextStyle(fontSize:20,color: Color(0xFF5A41D6)),),
                                                        onPressed: () => {
                                                              updatedVacancySeat = snapshot
                                                                      .data![
                                                                          index]
                                                                      .vacancySeat -
                                                                  widget
                                                                      .seatNead,
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'users')
                                                                  .doc(
                                                                      "${snapshot.data![index].documentName}")
                                                                  .update({
                                                                'vacancySeat':
                                                                    updatedVacancySeat
                                                              }),
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              cardListView())),
                                                              //print(snapshot.data),
                                                            })
                                                  ],
                                                ));
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                CupertinoAlertDialog(
                                                  title: Text('SORRY!'),
                                                  content: Container(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            "DONT HAVE ENOUGH SEAT"),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    CupertinoDialogAction(
                                                      child: Text('OK'),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    )
                                                  ],
                                                ));
                                      }
                                    },
                                    iconColor: Color(0xFF5A41D6),
                                    tileColor: Color(0xFF5A41D6).withOpacity(0.1),
                                    leading: const Icon(
                                        Icons.person_outline_outlined),
                                    title: Text(
                                        "Name:${snapshot.data![index].name}"),
                                    subtitle: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "id: ${snapshot.data![index].id.toString()}"),
                                            Text(
                                                "source:${snapshot.data![index].source}"),
                                            Text(
                                                "destination:${snapshot.data![index].destination}"),
                                            Text(
                                                "number of seat available:${snapshot.data![index].vacancySeat.toString()}"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return const Center(child: Text('something went wrong'));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ));
  }
}

Future<List<UserModel>> retrieveDataFromFirebase(String SourceData) async {
  final snapshot = await FirebaseFirestore.instance
      .collection("users")
      .where("source", isEqualTo: SourceData)
      //.where("dateOfDeparture",isGreaterThanOrEqualTo: searchDateController)
      .get();
  final userdata = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();

  return Future.value(userdata);
}
