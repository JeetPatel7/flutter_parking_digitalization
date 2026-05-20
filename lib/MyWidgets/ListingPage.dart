import 'package:flutter/material.dart';
import 'package:parking_digitalization/MyWidgets/PrakingData.dart';
import 'package:parking_digitalization/MyWidgets/editpage.dart';

class firstpage extends StatefulWidget {
  final List<CityParking> parkingdata;
  const firstpage({super.key, required this.parkingdata});

  @override
  State<firstpage> createState() => firstpageState();
}

class firstpageState extends State<firstpage> {
  late String selectedcity;
  late String selectedarea;

  @override
  void initState() {
    super.initState();
    selectedcity = widget.parkingdata[0].cityName;
    selectedarea = widget.parkingdata
        .firstWhere((p) => p.cityName == selectedcity)
        .area[0];
  }

  @override
  Widget build(BuildContext context) {
    final selectedCityData = widget.parkingdata.firstWhere(
      (p) => p.cityName == selectedcity,
    );
    final selectedAreaSlots = selectedCityData.slotDetails[selectedarea] ?? {};
    final slotNumbers = selectedAreaSlots.keys.toList()..sort();
    final totalSlots = selectedAreaSlots.length;
    final occupiedSlots = selectedAreaSlots.values
        .where((value) => value)
        .length;
    final availableSlots = totalSlots - occupiedSlots;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
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
          child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Editpage(
                                parkingdata: widget.parkingdata,
                              ),
                            ),
                          );

                          if (result == true && widget.parkingdata.isNotEmpty) {
                            setState(() {
                              selectedcity = widget.parkingdata.last.cityName;
                              selectedarea = widget.parkingdata.last.area.first;
                            });
                          }
                        },
                        icon: const Icon(Icons.location_city),
                        label: const Text(
                          "Add City",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      TextButton.icon(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Editpage(
                                parkingdata: widget.parkingdata,
                                isAddArea: true,
                                selectedCity: selectedcity,
                              ),
                            ),
                          );

                          if (result == true) {
                            setState(() {
                              selectedarea = widget.parkingdata
                                  .firstWhere((p) => p.cityName == selectedcity)
                                  .area
                                  .last;
                            });
                          }
                        },
                        icon: const Icon(Icons.add_location_alt_outlined),
                        label: const Text(
                          "Add Area",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.black, thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 6,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(235, 227, 242, 253),
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Text(
                                    "Select City: ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DropdownButton(
                                  
                                  focusColor: Colors.grey,
                                  value: selectedcity,
                                  items: widget.parkingdata.map((parking) {
                                    return DropdownMenuItem(
                                      value: parking.cityName,
                                      child: Text(
                                        parking.cityName,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedcity = value!;
                                      selectedarea = widget.parkingdata
                                          .firstWhere(
                                            (p) => p.cityName == selectedcity,
                                          )
                                          .area[0];
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Row(
                            spacing: 6,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(235, 227, 242, 253),
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                child: Text(
                                  "Select Area",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DropdownButton(
                                focusColor: Colors.grey,
                                value: selectedarea,
                                items: widget.parkingdata
                                    .firstWhere(
                                      (p) => p.cityName == selectedcity,
                                    )
                                    .area
                                    .map((area) {
                                  return DropdownMenuItem(
                                    
                                    value: area,
                                    child: Text(                                   
                                      area,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedarea = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(color: Colors.black, thickness: 2),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "Available Slots:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 420,
                    width: 410,
                    margin: EdgeInsets.fromLTRB(14, 14, 14, 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(28, 85, 99, 222),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 18,
                        children: [
                          for (int i in slotNumbers)
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 12),
                                  height: 40,
                                  width: 320,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      161,
                                      255,
                                      255,
                                      255,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Slot $i",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Checkbox(
                                        value: selectedAreaSlots[i] ?? false,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedAreaSlots[i] = value!;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.black, thickness: 2),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 24,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 92,
                            width: 92,
                            padding: EdgeInsets.only(left: 8, top: 12),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(147, 54, 130, 244),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              " $totalSlots",
                              style: TextStyle(fontSize: 42),
                            ),
                          ),
                          Text(
                            "Total",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 92,
                            width: 92,
                            padding: EdgeInsets.only(left: 8, top: 12),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(109, 69, 244, 110),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              " $availableSlots",
                              style: TextStyle(fontSize: 42),
                            ),
                          ),
                          Text(
                            "Free",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 92,
                            width: 92,
                            padding: EdgeInsets.only(left: 8, top: 12),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(105, 244, 67, 54),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              " $occupiedSlots",
                              style: TextStyle(fontSize: 42),
                            ),
                          ),
                          Text(
                            "Occupied",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        widget.parkingdata.removeWhere(
                          (p) => p.cityName == selectedcity,
                        );

                        if (widget.parkingdata.isNotEmpty) {
                          selectedcity = widget.parkingdata.first.cityName;
                          selectedarea = widget.parkingdata.first.area.first;
                        }
                      });
                    },
                    
                    child: Container(
                      width: 100,
                      child: Row(
                        spacing: 7,
                        children: [Icon(Icons.delete), Text("Delete City",style: TextStyle(color: Colors.black),)],
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
