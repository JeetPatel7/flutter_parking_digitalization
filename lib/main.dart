
import 'package:day_6/MyWidgets/userdatafetch.dart';
import 'package:day_6/MyWidgets/userdatausingListview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // body:,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: Center(
            child: Text("User Data")),
          
        ),
      ),
    ),
  );
  //runApp(MyApp());
}
