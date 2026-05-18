//fkdsvfjefefkg
import 'package:flutter/material.dart';
//nothing

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: Container(
          decoration: BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,

    colors: [
      Color(0xFF64B5F6),
      Color(0xFFB2EBF2),
      Color(0xFFF8FDFF),
    ],

    stops: [
      0.0,
      0.65,
      1.0,
    ],
  ),
),
       
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Version 1.0",style: TextStyle(fontWeight: FontWeight.w200)),
                ],
              ),

              SizedBox(height: 100),

              Image.asset("assets/images/logo.png",height: 200),

              Text("Parking Made Simple", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: const Color.fromARGB(194, 11, 11, 11)),),

               SizedBox(height: 60),

              CircularProgressIndicator(
                color: const Color.fromARGB(255, 75, 75, 75),
                strokeWidth: 3,
              ),
              SizedBox(height: 10,),
              Text("Loading...."),
              SizedBox(height: 100,),
                Text("© 2026 Smart Parking Solutions",
                        style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,)
          )          
          
          ],
          ),
        )
      ),
    ),
  );
}
