import 'package:flutter/material.dart';
import 'package:parking_digitalization/MyWidgets/PrakingData.dart';

class Editpage extends StatefulWidget {
  final List<CityParking> parkingdata;
  final bool isAddArea;
  final String selectedCity;

  const Editpage({
    super.key,
    required this.parkingdata,
    this.isAddArea = false,
    this.selectedCity = "",
  });

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
    if (widget.isAddArea && city.isEmpty) {
      city = widget.selectedCity;
      clearcity.text = widget.selectedCity;
    }

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
              Text(
                widget.isAddArea ? "Add Area and Slots" : "Add City and Slots",
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
                readOnly: widget.isAddArea,
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
                        city = widget.isAddArea ? widget.selectedCity : "";
                        slots = "";
                        area = "";
                        clearcity.clear();
                        clearslots.clear();
                        cleararea.clear();
                        if (widget.isAddArea) {
                          clearcity.text = widget.selectedCity;
                        }
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
                      final String cityName = city.trim();
                      final int slotCount = int.parse(slots);
                      final String areaName = area.trim();

                      if (widget.isAddArea) {
                        final CityParking selectedParking = widget.parkingdata
                            .firstWhere((parking) => parking.cityName == cityName);
                        final bool areaExists = selectedParking.area.any(
                          (existingArea) =>
                              existingArea.toLowerCase() ==
                              areaName.toLowerCase(),
                        );

                        if (areaExists) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Area already exist"),
                            ),
                          );
                          return;
                        }

                        selectedParking.area.add(areaName);
                        selectedParking.slotDetails[areaName] = {
                          for (int i = 1; i <= slotCount; i++) i: false,
                        };
                        selectedParking.totalSlots =
                            selectedParking.totalSlots + slotCount;
                        selectedParking.availableSlots =
                            selectedParking.availableSlots + slotCount;
                      } else {
                        final bool cityExists = widget.parkingdata.any(
                          (parking) =>
                              parking.cityName.toLowerCase() ==
                              cityName.toLowerCase(),
                        );

                        if (cityExists) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("City already exist"),
                            ),
                          );
                          return;
                        }

                        widget.parkingdata.add(
                          CityParking(
                            cityName: cityName,
                            totalSlots: slotCount,
                            occupiedSlots: 0,
                            availableSlots: slotCount,
                            area: [areaName],
                            slotDetails: {
                              areaName: {
                                for (int i = 1; i <= slotCount; i++) i: false,
                              },
                            },
                          ),
                        );
                      }

                      clearcity.clear();
                      clearslots.clear();
                      cleararea.clear();
                      city = widget.isAddArea ? widget.selectedCity : "";
                      slots = "";
                      area = "";
                      if (widget.isAddArea) {
                        clearcity.text = widget.selectedCity;
                      }
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
