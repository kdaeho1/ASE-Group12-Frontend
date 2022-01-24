import 'package:flutter/material.dart';
import 'package:journey_sharing_application/map-component.dart';

class MapScreenClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_ios,
        size: 20,
        color: Colors.black,),
        )
      ),
      body: Container(
        child: MapWidget(),
      ),
    );
  }
}