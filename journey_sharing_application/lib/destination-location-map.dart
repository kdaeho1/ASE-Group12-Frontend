import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart';
import 'package:journey_sharing_application/result-page.dart';


class DestinationMapWidget extends StatefulWidget{
  final LatLng sourceLoc;
  DestinationMapWidget({Key? key, required this.sourceLoc}) : super(key: key);

  @override
  State<DestinationMapWidget> createState() => DestinationMapWidgetState();
}

class DestinationMapWidgetState extends State<DestinationMapWidget> {
  Completer<GoogleMapController> _controller = Completer();
  late BitmapDescriptor pinLocationIcon;
  // static final LatLng initialPos = LatLng(37.42796133580664, -122.085749655962); // TODO: get from previous screen
  // late final LatLng initialPos;
  static late LatLng initialPos;
  late LatLng secondaryPos; //TODO: assign source for init
  static int dropdownState = 1;
  String genderPreference = "everyone";
  bool preferenceVisibility = false;
  Set<Marker> _markers = {};

  bool isGenderPreference(String gender) {
    return genderPreference == gender;
  }

  void getLocation() async {
    Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(pos);
  }

  void setMarker() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), "assets/marker_test.png");
  }

  @override initState(){
    super.initState();
    setMarker();
    initialPos = widget.sourceLoc;
    // getLocation();
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: initialPos,
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            setState(() {
              _markers.add(
                  Marker(
                      markerId: MarkerId('0'),
                      position: initialPos,
                      icon: pinLocationIcon
                  )
              );
            });
          },
          onCameraMove: (object) => {
            secondaryPos = LatLng(object.target.latitude, object.target.longitude)
          },
          markers: _markers,
        ),
        Image.asset(
          'assets/2.5x/marker_test.png',
          // scale: 0.01,
          height: 35,
          width: 35, //TODO: make dynamic scaling values
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            return Transform.translate(
              offset: const Offset(8, -37),
              child: child,
            );
          },
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: (MediaQuery.of(context).size.height)*0.11,
                  // padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 0),
                  child: Card(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Where to?",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: (MediaQuery.of(context).size.height)*0.07,
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Card(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Text("preferences",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(Icons.arrow_drop_down),
                              onPressed: (){
                                setState(() {
                                  preferenceVisibility = !preferenceVisibility;
                                });
                                print(preferenceVisibility);
                              },
                            )
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: preferenceVisibility,
                  child: Container(
                  height: 180,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Card(
                    child: Column(
                      children: [
                        Row( //ROW for first option -- everyone
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: isGenderPreference("everyone"),
                                onChanged: (newValue){
                                  setState(() {
                                    genderPreference = "everyone";
                                  });
                                }),
                            Text(
                              "Everyone",
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                        Row( //ROW for first option -- everyone
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: isGenderPreference("male"),
                                onChanged: (newValue){
                                  setState(() {
                                    genderPreference = "male";
                                  });
                                }),
                            Text(
                              "Male",
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                        Row( //ROW for first option -- everyone
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: isGenderPreference("female"),
                                onChanged: (newValue){
                                  setState(() {
                                    genderPreference = "female";
                                  });
                                }),
                            Text(
                              "Female",
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            )
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: (){
                  print(initialPos);
                  print(secondaryPos);
                  print(genderPreference);

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return MainPage(sourceLoc: initialPos, destinationLoc: secondaryPos);
                      })
                  );
                },
                child: Icon(Icons.navigate_next),
              ),
            )
        )
      ],
    );

  }

}
