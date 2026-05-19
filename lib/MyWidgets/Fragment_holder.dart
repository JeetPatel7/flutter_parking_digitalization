import 'package:flutter/material.dart';
import 'package:parking_digitalization/MyWidgets/ListingPage.dart';
import 'package:parking_digitalization/MyWidgets/PrakingData.dart';
import 'package:parking_digitalization/MyWidgets/editpage.dart';

class FragmentPlaceHolder extends StatefulWidget {
  const FragmentPlaceHolder({super.key});

  @override
  State<FragmentPlaceHolder> createState() => FragmentPlaceHolderState();
}

class FragmentPlaceHolderState extends State<FragmentPlaceHolder> {
  List<CityParking> Data = [
    CityParking(
      cityName: "Rajkot",
      totalSlots: 10,
      occupiedSlots: 6,
      availableSlots: 4,

      address: ["Address 1", "Address 2", "Address 3"],

      slotDetails: {
        1: true,
        2: false,
        3: true,
        4: false,
        5: true,
        6: true,
        7: false,
        8: true,
        9: false,
        10: true,
      },
    ),

    CityParking(
      cityName: "Ahmedabad",
      totalSlots: 5,
      occupiedSlots: 3,
      availableSlots: 2,

      address: ["Address 4", "Address 5", "Address 6"],

      slotDetails: {1: true, 2: true, 3: false, 4: true, 5: false},
    ),

    CityParking(
      cityName: "Surat",
      totalSlots: 12,
      occupiedSlots: 7,
      availableSlots: 5,

      address: ["Address 7", "Address 8", "Address 9"],

      slotDetails: {
        1: false,
        2: true,
        3: true,
        4: false,
        5: true,
        6: true,
        7: false,
        8: true,
        9: false,
        10: true,
        11: true,
        12: false,
      },
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return (
      MaterialApp(
         debugShowCheckedModeBanner: false,
      
      //   // body:FragmentPlaceHolder(),
      // )
      // ),
      initialRoute: '/',
        routes: {
        '/': (context) =>  firstpage(  parkingdata: Data),
        '/edit': (context) =>  Editpage(parkingdata: Data),
        },
        )
      );
  }
}

void main() {
  runApp(const FragmentPlaceHolder());
}
