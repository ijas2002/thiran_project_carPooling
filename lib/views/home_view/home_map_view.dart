import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thiran_project/bloc/app_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:thiran_project/views/home_view/profile.dart';

import '../../auth/auth.dart';
import '../../controllers/email_and_password_controller.dart';
import '../register_view/ride_give_view.dart';
import '../register_view/ride_take_view.dart';
import '../welcome_views.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  //  GoogleMapController? _controller;
  // Location currentLocation = Location();
  // Set<Marker> _markers={};




  // void getLocation() async{
  //   //
  //
  //   //
  //   LocationData location = await currentLocation.getLocation();
  //
  //
  //   currentLocation.onLocationChanged.listen((location){
  //
  //     _controller?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
  //       target: LatLng(location.latitude ?? 0.0,location.longitude?? 0.0),
  //       zoom: 12.0,
  //     )));
  //
  //     setState(() {
  //       _markers.clear();
  //       _markers.add(Marker(markerId: MarkerId('Home'),
  //           position: LatLng(location.latitude ?? 0.0, location.longitude ?? 0.0)
  //       ));
  //     });
  //   });
  // }
  @override
  void initState(){
    super.initState();
    setState(() {
      //getLocation();
      DriveGivePage();



    });
  }

  @override
  Widget build(BuildContext context) {
    String username =emailcontroller.text.split("@")[0];
    return BlocBuilder<AppBloc, AppState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(actions: [ IconButton(
        icon: Icon(Icons.exit_to_app),
        onPressed: () async {
          emailcontroller.clear();
          passwordcontroller.clear();
          context.read<AppBloc>().emit(
              AppStateLoggedOut(
                  isLoading: false,
                  successful: true));
          Navigator.push(context,MaterialPageRoute(builder: (context)=>WelcomeView()));
        },
      ),],
        backgroundColor:Color(0xFF725BBC),title: Text("CHOOSE THE NEED") ,),
      body:Flex(
        direction: Axis.vertical,
        children: [
          Flexible(
            flex: 6,
            child: Container(
              height: MediaQuery.of(context).size.height,
              //width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,

                  ),
                  SizedBox(height: 20),
                  Text(
                    username,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${emailcontroller.text}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 100,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text('Edit Profile',textAlign: TextAlign.center,),
                      color: Color(0xFF725BBC),
                      textColor: Colors.white,
                    ),
                  ),
                  //ProfilePage()
                ],
              ),

              // child:GoogleMap(
              //   myLocationEnabled:true,
              //   zoomControlsEnabled: false,
              //   initialCameraPosition:CameraPosition(
              //     target: LatLng(10.0735, 78.7732),
              //     zoom: 12.0,
              //   ),
              //
              //
              //   onMapCreated: (GoogleMapController controller){
              //     _controller = controller;
              //   },
              //
              //   onCameraMove: (position) {
              //     _controller?.animateCamera(CameraUpdate.newLatLng(position.target));
              //   },
              //   markers: _markers,
              // ) ,
            ),
          ),
          Flexible(flex: 1,child: Container(padding: EdgeInsets.all(5),color: Colors.indigo.shade200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                      color: Color(0xFF725BBC),
                        height:1000,
                        child: MaterialButton(
                            onPressed: (){Navigator.push(context,
                                MaterialPageRoute(builder: (context) => DriveGivePage()));},
                    child: Text("GIVE RIDE",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25),)))),
                SizedBox(width: 2,),
                Expanded(child: Container(color:Color(0xFF725BBC),height:1000,child: MaterialButton(
                    onPressed: (){Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DriveTakePage()));},
                    child: Text("TAKE RIDE",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25),))),),

              ],
            ),

          )),
        ],
      ),


    );
  },
);

  }
}
