//fkdsvfjefefkg
import 'package:flutter/material.dart';
import 'package:parking_digitalization/MyWidgets/Fragment_holder.dart';
import 'package:parking_digitalization/MyWidgets/ListingPage.dart';
import 'package:parking_digitalization/MyWidgets/editpage.dart';
import 'package:parking_digitalization/MyWidgets/PrakingData.dart';



void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Scaffold(
      //   // body:FragmentPlaceHolder(),
      // )
      // ),
      // initialRoute: '/',
      
        routes: {
        '/': (context) =>  firstpage(  parkingdata: Data),
        '/edit': (context) =>  Editpage(parkingdata: Data),
        },
        )
    );
  //runApp(MyApp());
}
