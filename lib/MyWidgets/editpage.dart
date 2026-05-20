import 'package:flutter/material.dart';
import 'package:parking_digitalization/MyWidgets/PrakingData.dart';

class Editpage extends StatefulWidget {
  final List<CityParking> parkingdata;
  // final VoidCallback onaddpressed;
  const Editpage({super.key, required this.parkingdata});

  @override
  State<Editpage> createState() => _EditpageState();
}

class _EditpageState extends State<Editpage> {
  String city = "";
  String slots = "";
  String area = "";
  final TextEditingController clearcity = TextEditingController();
  final TextEditingController clearslots = TextEditingController();
  final TextEditingController cleararea = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 189, 209, 224),
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                }, 
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              const SizedBox(height: 24),
              const Text(
                "Add City and Slots",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              const Text(
                "City Name",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: clearcity,
                onChanged: (value) {
                  city = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter city name",
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Icon(Icons.location_on_outlined),
               
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              const Text(
                "City Area",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: cleararea,
                onChanged: (value) {
                  area = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter area name",
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Icon(Icons.location_city),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              const Text(
                "Number of Slots",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: clearslots,
                onChanged: (value) {
                  slots = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter number of slots",
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Icon(Icons.local_parking),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        city = "";
                        slots = "";
                        clearcity.clear();
                        clearslots.clear();
                        cleararea.clear();
                      });
                    },
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    label: const Text(
                      "Reset",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      print(city);
                      print(slots);
                      print(area);

                      
                      setState(() {
                        // widget.parkingdata.add(
                          CityParking newdata=CityParking(
                            cityName: city,
                            totalSlots: int.parse(slots),
                            occupiedSlots: 0,
                            availableSlots: int.parse(slots),
                            area: [area],
                            slotDetails: {
                              area: {for (int i = 1; i <= int.parse(slots); i++) i: false},
                            },
                          );
                        // );
                        city = "";
                        slots = "";
                        clearcity.clear();
                        clearslots.clear();
                        cleararea.clear();
                         Navigator.pop(context, newdata);
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Updated Successfully"),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: const Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
      ),
        ),
      ),
    );
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
