import 'package:flutter/material.dart';
import 'package:parking_digitalization/MyWidgets/PrakingData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class firstpage extends StatefulWidget {
  final List<CityParking> parkingdata;
  final Function deletdata;

  const firstpage({
    super.key,
    required this.parkingdata,
    required this.deletdata,
  });

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
        .area
        .first;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;

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
      body: SafeArea(
        child: Container(
          width: double.infinity,

          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/image4.png'),

              fit: BoxFit.cover,
            ),

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
                // TOP BUTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,

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

                    SizedBox(width: 15),

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

                    SizedBox(width: 10),
                  ],
                ),

                Divider(color: Colors.black, thickness: 2),

                // DROPDOWNS
                Padding(
                  padding: const EdgeInsets.all(8.0),

                  child: Row(
                    children: [
                      // CITY DROPDOWN
                      Flexible(
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white70,

                                borderRadius: BorderRadius.circular(8),
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(4.0),

                                child: Text(
                                  "Select City:",

                                  style: TextStyle(
                                    fontSize: 18,

                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: DropdownButton(
                                isExpanded: true,

                                value: selectedcity,

                                items: widget.parkingdata.map((parking) {
                                  return DropdownMenuItem(
                                    value: parking.cityName,

                                    child: Text(parking.cityName),
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
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 10),

                      // AREA DROPDOWN
                      Flexible(
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white70,

                                borderRadius: BorderRadius.circular(8),
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(4.0),

                                child: Text(
                                  "Area",

                                  style: TextStyle(
                                    fontSize: 18,

                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: DropdownButton(
                                isExpanded: true,

                                value: selectedarea,

                                items: widget.parkingdata
                                    .firstWhere(
                                      (p) => p.cityName == selectedcity,
                                    )
                                    .area
                                    .map((area) {
                                      return DropdownMenuItem(
                                        value: area,

                                        child: Text(area),
                                      );
                                    })
                                    .toList(),

                                onChanged: (value) {
                                  setState(() {
                                    selectedarea = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Divider(color: Colors.black, thickness: 2),

                SizedBox(height: 10),

                // TITLE
                Padding(
                  padding: const EdgeInsets.all(8.0),

                  child: Row(
                    children: [
                      Text(
                        "Slots in $selectedarea",

                        style: TextStyle(
                          fontWeight: FontWeight.bold,

                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),

                // SLOT CONTAINER
                Container(
                  height: height * 0.55,

                  width: width * 0.92,

                  margin: EdgeInsets.all(20),

                  padding: EdgeInsets.all(15),

                  decoration: BoxDecoration(
                    color: const Color.fromARGB(28, 85, 99, 222),

                    borderRadius: BorderRadius.circular(10),

                    border: Border.all(color: Colors.black, width: 1),
                  ),

                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i in slotNumbers)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),

                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),

                              height: 50,

                              width: width * 0.80,

                              decoration: BoxDecoration(
                                color: Colors.white,

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
                                  Text(
                                    "Slot $i",

                                    style: TextStyle(
                                      fontSize: 20,

                                      fontWeight: FontWeight.w500,
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
                          ),
                      ],
                    ),
                  ),
                ),

                Divider(color: Colors.black, thickness: 2),

                SizedBox(height: 20),

                // STATISTICS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    // TOTAL
                    Column(
                      children: [
                        Container(
                          height: width * 0.22,
                          width: width * 0.22,

                          alignment: Alignment.center,

                          decoration: BoxDecoration(
                            color: const Color.fromARGB(147, 54, 130, 244),

                            borderRadius: BorderRadius.circular(15),

                            border: Border.all(color: Colors.black, width: 3),
                          ),

                          child: Text(
                            "$totalSlots",

                            style: TextStyle(fontSize: 40),
                          ),
                        ),

                        SizedBox(height: 8),

                        Text(
                          "Total",

                          style: TextStyle(
                            fontWeight: FontWeight.bold,

                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),

                    // FREE
                    Column(
                      children: [
                        Container(
                          height: width * 0.22,
                          width: width * 0.22,

                          alignment: Alignment.center,

                          decoration: BoxDecoration(
                            color: const Color.fromARGB(109, 69, 244, 110),

                            borderRadius: BorderRadius.circular(15),

                            border: Border.all(color: Colors.black, width: 3),
                          ),

                          child: Text(
                            "$availableSlots",

                            style: TextStyle(fontSize: 40),
                          ),
                        ),

                        SizedBox(height: 8),

                        Text(
                          "Free",

                          style: TextStyle(
                            fontWeight: FontWeight.bold,

                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),

                    // OCCUPIED
                    Column(
                      children: [
                        Container(
                          height: width * 0.22,
                          width: width * 0.22,

                          alignment: Alignment.center,

                          decoration: BoxDecoration(
                            color: const Color.fromARGB(105, 244, 67, 54),

                            borderRadius: BorderRadius.circular(15),

                            border: Border.all(color: Colors.black, width: 3),
                          ),

                          child: Text(
                            "$occupiedSlots",

                            style: TextStyle(fontSize: 40),
                          ),
                        ),

                        SizedBox(height: 8),

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

                SizedBox(height: 20),

                // DELETE BUTTON
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.parkingdata.removeWhere(
                        (p) => p.cityName == selectedcity,
                      );

                      if (widget.parkingdata.isNotEmpty) {
                        selectedcity = widget.parkingdata.first.cityName;

                        selectedarea = widget.parkingdata.first.area.first;
                      } else {
                       selectedcity = "";
      selectedarea = "";
                      }

                      widget.deletdata(widget.parkingdata);
                    });
                  },

                  child: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Icon(Icons.delete),

                      SizedBox(width: 8),

                      Text(
                        "Delete City",

                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
