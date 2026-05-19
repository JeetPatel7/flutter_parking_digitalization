//fkdsvfjefefkg
import 'package:flutter/material.dart';
//nothing

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: Container(
          width: double.infinity,

          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Splash_background.png'),
              fit: BoxFit.cover,
            ),
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
              Padding(padding: EdgeInsets.only(top: 30,left: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text("Version 1.0",
                          style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: const Color.fromARGB(183, 0, 0, 0),
                                letterSpacing: 1,
                                fontSize: 12)
                          ),
                  )
                ],
              ),

              SizedBox(height: 70),

              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(18, 0, 0, 0),
                      blurRadius: 25,
                    ),
                  ],
                ),

                child: Image.asset("assets/images/logo.png",
                                    height: 180,
                                  ),
                        ),

               SizedBox(height: 20),

              Text("Parking Made Simple", style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,letterSpacing: 1,
                  color: Color(0xFF243B6B))
                  ),

              SizedBox(height: 8),

               Text(
                "Find • Navigate • Park",

                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 2,
                  color: Colors.black45,
                ),
              ),

              SizedBox(height: 45),

            
              CircularProgressIndicator(
                  color: Color(0xFF4A6FA5),
                  strokeWidth: 3,
                ),
              

              SizedBox(height: 15),

              Text("Loading....", 
                     style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 1,
                                color: Colors.black54,
                                      )
                ),

                Spacer(),

               Padding(
                padding: const EdgeInsets.only(bottom: 40),

                child: Text(
                  "© 2026 Smart Parking Solutions",

                  style: TextStyle(
                    fontSize: 13,
                    color: const Color.fromARGB(161, 0, 0, 0),
                    letterSpacing: 2,
                                  )
                            )
                        )        
          
          ],
          ),
        )
      ),
    ),
  );
}
