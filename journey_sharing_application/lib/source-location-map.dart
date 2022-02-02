import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:journey_sharing_application/destination-location-map.dart';
// import 'package:http/http.dart';

class SourceMapWidget extends StatefulWidget{
  @override
  State<SourceMapWidget> createState() => SourceMapWidgetState();
}

class SourceMapWidgetState extends State<SourceMapWidget> {
  Completer<GoogleMapController> _controller = Completer();
  late BitmapDescriptor pinLocationIcon;
  static final LatLng initialPos = LatLng(37.42796133580664, -122.085749655962);
  static LatLng secondaryPos = LatLng(47.42796133580664, -122.085749655962);
  Set<Marker> _markers = {};

  void getLocation() async {
    Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(pos);
  }

  void setMarker() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), "assets/marker_test.png");
  }

  @override initState(){
    super.initState();
    getLocation();
    // setMarker();
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: initialPos,
    zoom: 15,
  );

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

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
            // setState(() {
            //
            // });
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
          child: Container(
            width: double.infinity,
            height: (MediaQuery.of(context).size.height)*0.17,
            // height: 120,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Card(
              child: Align(
                alignment: Alignment.center,
                child: Text("Starting at?",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),),
              ),
            ),
          )
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: (){
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return DestinationMapWidget(sourceLoc: secondaryPos);
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