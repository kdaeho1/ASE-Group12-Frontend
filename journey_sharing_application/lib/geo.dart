import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:core';
import 'package:app_settings/app_settings.dart';

class FindLocation extends StatefulWidget {
  @override
  State<FindLocation> createState() => _FindLocationState();
}

class _FindLocationState extends State<FindLocation> {

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: FutureBuilder<Position>(
          future: _determinePosition(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Center(child: Text(snapshot.data!.toString()));
                    //Text("Location: ${snapshot.data!.latitude}, ${snapshot.data!.longitude}");
            }
              else{
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                      title: Text('Location Permission'),
                      content: Text(
                          'This app needs access to location'),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: Text('Deny'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        CupertinoDialogAction(
                          child: Text('Settings'),
                          onPressed: () => AppSettings.openLocationSettings(),
                        ),
                      ],
                    ));
                return Center(
                  child: CircularProgressIndicator(),
                );
              //Display loading, you may adapt this widget to your interface or use some state management solution
              }
            }
            return Container();
          }
      )
    );
  }


}