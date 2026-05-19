//fkdsvfjefefkg
import 'package:flutter/material.dart';
import 'package:parking_digitalization/MyWidgets/Fragment_holder.dart';
import 'package:parking_digitalization/MyWidgets/ListingPage.dart';
import 'package:parking_digitalization/MyWidgets/editpage.dart';
import 'package:parking_digitalization/MyWidgets/PrakingData.dart';



void main() {
  // runApp(
  //   MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     home: Scaffold(
  //       body:FragmentPlaceHolder(),
  //     ),
  //     initialRoute: '/',
  //     onGenerateRoute: (settings) {
  //       if (settings.name == '/') {
  //         return MaterialPageRoute(
  //           builder: (context) => FragmentPlaceHolder(),
  //         );
  //       } else if (settings.name == '/edit') {
  //         final parkingdata = settings.arguments as List<CityParking>;
  //         return MaterialPageRoute(
  //           builder: (context) => Editpage(parkingdata: Data),
  //         );
  //       }
  //       return null;
  //     },

  //     ),
  //   );
  runApp(FragmentPlaceHolder());
}
