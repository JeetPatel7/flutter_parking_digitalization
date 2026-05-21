import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parking_digitalization/MyWidgets/ListingPage.dart';
import 'package:parking_digitalization/MyWidgets/PrakingData.dart';
import 'package:parking_digitalization/MyWidgets/Addcity.dart';
import 'package:parking_digitalization/MyWidgets/editpage.dart';
import 'package:parking_digitalization/MyWidgets/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FragmentPlaceHolder extends StatefulWidget {
  const FragmentPlaceHolder({super.key});

  @override
  State<FragmentPlaceHolder> createState() => FragmentPlaceHolderState();
}

class FragmentPlaceHolderState extends State<FragmentPlaceHolder> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  List<CityParking> Data = [
    CityParking(
      cityName: "Rajkot",
      totalSlots: 31,
      occupiedSlots: 19,
      availableSlots: 12,

      area: ["Area 1", "Area 2", "Area 3"],

      slotDetails: {
        "Area 1": {
          1: true,
          2: false,
          3: true,
          4: false,
          5: true,
          6: false,
          7: true,
          8: false,
        },
        "Area 2": {
          1: false,
          2: true,
          3: false,
          4: true,
          5: false,
          6: true,
          7: false,
          8: true,
          9: true,
          10: false,
          11: true,
          12: true,
        },
        "Area 3": {
          1: true,
          2: true,
          3: false,
          4: true,
          5: false,
          6: true,
          7: false,
          8: true,
          9: false,
          10: true,
          11: false,
        },
      },
    ),

    CityParking(
      cityName: "Ahmedabad",
      totalSlots: 31,
      occupiedSlots: 17,
      availableSlots: 14,

      area: ["Area 4", "Area 5", "Area 6"],

      slotDetails: {
        "Area 4": {
          1: true,
          2: true,
          3: false,
          4: true,
          5: false,
          6: true,
          7: false,
        },
        "Area 5": {
          1: false,
          2: true,
          3: true,
          4: false,
          5: true,
          6: false,
          7: true,
          8: false,
          9: true,
        },
        "Area 6": {
          1: true,
          2: false,
          3: true,
          4: false,
          5: true,
          6: false,
          7: true,
          8: true,
          9: false,
          10: true,
          11: false,
          12: true,
          13: false,
          14: true,
          15: false,
        },
      },
    ),

    CityParking(
      cityName: "Surat",
      totalSlots: 37,
      occupiedSlots: 22,
      availableSlots: 15,

      area: ["Area 7", "Area 8", "Area 9"],

      slotDetails: {
        "Area 7": {
          1: false,
          2: true,
          3: true,
          4: false,
          5: true,
          6: false,
          7: true,
          8: true,
          9: false,
          10: true,
          11: false,
          12: true,
          13: true,
          14: false,
        },
        "Area 8": {
          1: true,
          2: false,
          3: true,
          4: true,
          5: false,
          6: true,
          7: false,
          8: true,
          9: false,
          10: true,
        },
        "Area 9": {
          1: false,
          2: true,
          3: false,
          4: true,
          5: false,
          6: true,
          7: true,
          8: false,
          9: true,
          10: false,
          11: true,
          12: false,
          13: true,
        },
      },
    ),
  ];
  

  @override
  void initState() {
    super.initState();
    // Timer(const Duration(seconds: 4), () {
    //   navigatorKey.currentState?.pushReplacement(
    //     MaterialPageRoute(builder: (context) => _buildMainNavigator()),
    //   );
    // });
     preparelist();
    Future.delayed(Duration(seconds: 4), () {
      navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (context) => _buildMainNavigator()),
      );
    });
  }

  
  Future<void> Savelist(List<CityParking> updateddata) async {
      final pref = await SharedPreferences.getInstance();
      String jsonList =jsonEncode(updateddata.map((item) => item.toJson()).toList());
      // String jsonList =Data.map((item) => item.toJson()).toList().toString();
       pref.setString('parking_Data', jsonList);

       setState(() {
        Data = updateddata;
       });
      //newData=[]; 
      // print("Initial Data:");
      // print(jsonList);
    }
    // Savelist(Data);

  Future<void> preparelist() async {
    final pref = await SharedPreferences.getInstance();
    String? jsonList = pref.getString('parking_Data');
    if (jsonList != null) {
      List<dynamic> decodedList = jsonDecode(jsonList);
      // List<CityParking> parkingData = decodedList
      //     .map((item) => CityParking.fromJson(item))
      //     .toList();
      setState(() {
        Data =decodedList
          .map((item) => CityParking.fromJson(item))
          .toList();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: const SplashScreen()),
    );
  }

  Widget _buildMainNavigator() {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Navigator(
              initialRoute: '/',
              onGenerateRoute: (RouteSettings settings) {
                WidgetBuilder builder;
                switch (settings.name) {
                  case '/':
                    builder = (BuildContext _) => firstpage(parkingdata: Data,deletdata: Savelist,);
                    break;
                  case '/add':
                    builder = (BuildContext _) => Addpage(parkingdata: Data,adddata: Savelist,);
                    break;
                  case '/edit':
                    builder = (BuildContext _) => editpage(parkingdata: Data);
                    break;
                  default:
                    throw Exception('Invalid route: ${settings.name}');
                }
                return MaterialPageRoute(builder: builder, settings: settings);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// void main() {
//   runApp(const FragmentPlaceHolder());
// }
