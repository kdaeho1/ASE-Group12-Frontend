import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart';


class DestinationMapWidget extends StatefulWidget{
  final LatLng sourceLoc;
  const DestinationMapWidget({Key? key, required this.sourceLoc}) : super(key: key);

  @override
  State<DestinationMapWidget> createState() => DestinationMapWidgetState();
}

class DestinationMapWidgetState extends State<DestinationMapWidget> {
  Completer<GoogleMapController> _controller = Completer();
  late BitmapDescriptor pinLocationIcon;
  // static final LatLng initialPos = LatLng(37.42796133580664, -122.085749655962); // TODO: get from previous screen
  // late final LatLng initialPos;
  static late final LatLng initialPos;
  late LatLng secondaryPos; //TODO: assign source for init
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
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: (){
                  print(initialPos);
                  print(secondaryPos);
                },
                child: Icon(Icons.navigate_next),
              ),
            )
        )
      ],
    );

  }

}