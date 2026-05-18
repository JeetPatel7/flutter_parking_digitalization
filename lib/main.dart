
import 'package:flutter/material.dart';
//nothing

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          //color: Gradient.lerp(a, b, t),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Version 1.0"),
                ],
              ),

              SizedBox(height: 20),

              // Image.asset(name)

              Text("Parking Made Simple", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
            ],
          ),
        )
      ),
    ),
  );
 
}
