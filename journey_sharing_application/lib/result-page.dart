import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

// var sourceLocValue = '';
// var destinationLoc = '';

class MainPage extends StatefulWidget{
  final LatLng sourceLoc;
  final LatLng destinationLoc;
  MainPage({Key? key,required this.sourceLoc,required this.destinationLoc}) : super(key: key);
  // LatLng sourceLocValue = sourceLoc;
  HomePage createState()=> HomePage();
}



class HomePage extends State<MainPage>{
  final url = "http://172.26.176.1:5000/match-users";

  var startLoc;
  var stopLoc;

  var resBody;

  @override
  initState() {
    super.initState();
    startLoc = widget.sourceLoc;
    stopLoc = widget.destinationLoc;
    fetchPosts();
  }


  var _postsJson = [];

  void fetchPosts() async {
    try {

      final body = {
        'UserId': 1,
        'TripStartLocation': [startLoc.latitude.toString(), startLoc.longitude.toString()],
        'TripStopLocation': [stopLoc.latitude.toString(), stopLoc.longitude.toString()],
      };

      final jsonString = json.encode(body);
      final uri = Uri.http('172.26.176.1:5000', '/match-users');
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      final response = await http.post(uri, headers: headers, body: jsonString);
      print(response.body);
      print(response.statusCode);

      var jsonResponse = jsonDecode(response.body);
      resBody = jsonResponse;

      setState(() {
        // _postsJson = jsonData;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Card"),
      ),
      body: Center(
        child: Visibility(
          visible: resBody!=null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (resBody!=null)
              for (int i = 0; i < resBody.length; i++)
                Padding(
                  padding: EdgeInsets.all(15),
                  child: ListTile(
                    leading: Icon(Icons.android),
                    title: Text('User ID: ${resBody[i]["UserId"]}'),
                    subtitle: Text('SOURCE: ${resBody[i]["TripStartLocation"][0]}, ${resBody[i]["TripStartLocation"][1]}\nDISTINATION: ${resBody[i]["TripStopLocation"][0]}, ${resBody[i]["TripStopLocation"][1]}'),
                  ),
                )
            ],
          ),
        )
      ),
    );
  }
}

// DONEE