import 'package:flutter/material.dart';
import 'package:parking_digitalization/MyWidgets/PrakingData.dart';

class Editpage extends StatefulWidget {
  final List<CityParking> parkingdata;
  const Editpage({super.key,required this.parkingdata});

  @override
  State<Editpage> createState() => _EditpageState();
}

class _EditpageState extends State<Editpage> {

  String city = "";

  String slots = "";

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 189, 209, 224),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
      
            children: [
      
              SizedBox(height: 20),
      
              Text(
                "Add City and Slots",
      
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
      
              SizedBox(height: 40),
      
              Text(
                "City Name",
      
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
      
              SizedBox(height: 10),
      
              TextField(
      
                onChanged: (value) {
      
                  city = value;
                },
      
                decoration: InputDecoration(
      
                  hintText: "Enter city name",
      
                  prefixIcon: Icon(Icons.location_city),
      
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
      
              SizedBox(height: 30),
      
      
              Text(
                "Number of Slots",
      
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
      
              SizedBox(height: 10),
      
              TextField(
      
                keyboardType: TextInputType.number,
      
                onChanged: (value) {
      
                  slots = value;
                },
      
                decoration: InputDecoration(
      
                  hintText: "Enter number of slots",
      
                  prefixIcon: Icon(Icons.local_parking),
      
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
      
              SizedBox(height: 50),
      
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
      
                children: [
      
                  // RESET BUTTON
      
                  ElevatedButton.icon(
      
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
      
                    onPressed: () {
      
                      setState(() {
      
                        city = "";
      
                        slots = "";
                      });
                    },
      
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
      
                    label: Text(
                      "Reset",
      
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
      
      
                  ElevatedButton.icon(
      
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
      
                    onPressed: () {
      
                      print(city);
      
                      print(slots);
      
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
      
                        SnackBar(
                          content: Text(
                            "Updated Successfully",
                          ),
                        ),
                      );
                    },
      
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
      
                    label: Text(
                      "Update",
      
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );//bdjbgit

  }
}

// void main() {

//   runApp(

//     MaterialApp(
//       debugShowCheckedModeBanner: false,

//       home: Editpage(),
//     ),
//   );
// }