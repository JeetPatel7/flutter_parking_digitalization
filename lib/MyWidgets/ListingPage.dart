import 'package:flutter/material.dart';
import 'package:parking_digitalization/MyWidgets/PrakingData.dart';

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
    selectedcity = widget.parkingdata.first.cityName;
    selectedarea = widget.parkingdata
        .firstWhere((p) => p.cityName == selectedcity)
        .area.first;
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
                    mainAxisAlignment: MainAxisAlignment.end,spacing: 30,
                    children: [
                      IconButton(
                        onPressed: () async {
                          final result = await Navigator.pushNamed(
                            context,
                            '/edit',
                            arguments: widget.parkingdata,
                          );

                          if (result == true && widget.parkingdata.isNotEmpty) {
                            setState(() {
                              selectedcity = widget.parkingdata.first.cityName;
                              selectedarea = widget.parkingdata.first.area.first;
                            });
                          }
                        },
                        icon: Row(
                          children: [
                            Text(
                              "Edit City",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            Icon(Icons.edit),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final result = await Navigator.pushNamed(
                            context,
                            '/add',
                            arguments: widget.parkingdata,
                          );

                          if (result == true && widget.parkingdata.isNotEmpty) {
                            setState(() {
                              selectedcity = widget.parkingdata.first.cityName;
                              selectedarea = widget.parkingdata.first.area.first;
                            });
                          }
                        },
                        icon: Row(
                          children: [
                            Text(
                              "Add City",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            Icon(Icons.location_on_outlined),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.black, thickness: 2),
                  Column(
                    // spacing: 150,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 10,
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DropdownButton(
                                  menuMaxHeight: 200,
                                  focusColor: Colors.grey,
                                  value: selectedcity,
                                  items: widget.parkingdata.map((parking) {
                                    return DropdownMenuItem(
                                      value: parking.cityName,
                                      child: Text(
                                        parking.cityName,
                                        style: TextStyle(fontSize: 18),
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
                            spacing: 10,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(235, 227, 242, 253),
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                child: Text(
                                  "Select Area",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DropdownButton(
                                menuMaxHeight: 200,
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
                                      style: TextStyle(fontSize: 16),
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
                          "Available Slots in ${selectedarea}:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  Container(
                    height: 500,
                    width: 470,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(15),
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
                                  padding: EdgeInsets.only(left: 15),
                                  height: 40,
                                  width: 355,
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
                                    spacing: 210,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 13),
                                        child: Text(
                                          "Slot $i",
                                          style: TextStyle(
                                            fontSize: 20,
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
                    spacing: 50,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            padding: EdgeInsets.only(left: 8, top: 12),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(147, 54, 130, 244),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.black,
                                width: 3,
                              ),
                            ),
                            child: Text(
                              " $totalSlots",
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                          Text(
                            "Total",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            padding: EdgeInsets.only(left: 8, top: 12),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(109, 69, 244, 110),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.black,
                                width: 3,
                              ),
                            ),
                            child: Text(
                              " $availableSlots",
                              style: TextStyle(fontSize: 55),
                            ),
                          ),
                          Text(
                            "Free",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            padding: EdgeInsets.only(left: 8, top: 12),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(105, 244, 67, 54),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.black,
                                width: 3,
                              ),
                            ),
                            child: Text(
                              " $occupiedSlots",
                              style: TextStyle(fontSize: 55),
                            ),
                          ),
                          Text(
                            "Occupied",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
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
                  SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
