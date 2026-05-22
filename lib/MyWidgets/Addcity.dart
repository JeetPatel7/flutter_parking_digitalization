import 'package:flutter/material.dart';
import 'package:parking_digitalization/MyWidgets/PrakingData.dart';

class Addpage extends StatefulWidget {
  final List<CityParking> parkingdata;
  final Function adddata;
  const Addpage({super.key, required this.parkingdata, required this.adddata});

  @override
  State<Addpage> createState() => _AddpageState();
}

class _AddpageState extends State<Addpage> {
  String city = "";
  String slots = "";
  String area = "";
  final TextEditingController clearcity = TextEditingController();
  final TextEditingController clearslots = TextEditingController();
  final TextEditingController cleararea = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 189, 209, 224),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 143, 192, 232),
              Color.fromARGB(255, 173, 222, 228),
              Color.fromARGB(255, 154, 180, 191),
            ],
            stops: [0.0, 0.65, 1.0],
          ),
        ),
        child: SingleChildScrollView(
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
                        final int slotCount = int.parse(slots);
                        bool enteredcity=widget.parkingdata.any((p) => p.cityName.toLowerCase() == city.trim().toLowerCase());
                        if (enteredcity) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("City already exists! Please Goto Edit Page to update the city."),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        widget.parkingdata.add(
                          CityParking(
                            cityName: city.trim(),
                            totalSlots: slotCount,
                            occupiedSlots: 0,
                            availableSlots: slotCount,
                            area: [area.trim()],
                            slotDetails: {
                              area.trim(): {
                                for (int i = 1; i <= slotCount; i++) i: false,
                              },
                            },
                          )
                        );
                        
                        // List<CityParking> updatedList = List.from(widget.parkingdata)..add(newCityData);
                        widget.adddata(widget.parkingdata);
                        

                        clearcity.clear();
                        clearslots.clear();
                        cleararea.clear();
                        city = "";
                        slots = "";
                        area = "";
                        Navigator.pop(context, true);
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
