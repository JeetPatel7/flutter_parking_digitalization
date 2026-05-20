import 'package:flutter/material.dart';
import 'package:parking_digitalization/MyWidgets/PrakingData.dart';

class firstpage extends StatefulWidget {
  final List<CityParking> parkingdata;
  const firstpage({super.key,required this.parkingdata});

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
    selectedarea = widget.parkingdata.firstWhere((p) => p.cityName == selectedcity).area[0];
  }
  
  @override
  Widget build(BuildContext context) {
    final selectedCityData = widget.parkingdata.firstWhere((p) => p.cityName == selectedcity);
    final selectedAreaSlots = selectedCityData.slotDetails[selectedarea] ?? {};
    final slotNumbers = selectedAreaSlots.keys.toList()..sort();
    final totalSlots = selectedAreaSlots.length;
    final occupiedSlots = selectedAreaSlots.values.where((value) => value).length;
    final availableSlots = totalSlots - occupiedSlots;

    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [IconButton(onPressed: (){
              Navigator.pushNamed(context, '/edit',arguments: widget.parkingdata);
              
            }, icon: Row(
              children: [
                Icon(Icons.edit),
                Text("Add City"),
              ],
            ))
            ],
          ),
          Divider(color: Colors.black, thickness: 2),
          Row(
            // mainAxisAlignment: MainAxisAlignment.end,
            spacing: 150,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    "Select City: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton(
                    focusColor: Colors.grey,
                    value: selectedcity,
                    items: widget.parkingdata.map((parking) {
                      return DropdownMenuItem(value: parking.cityName, child: Text(parking.cityName));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedcity = value!;    
                        selectedarea = widget.parkingdata.firstWhere((p) => p.cityName == selectedcity).area[0];
                      });
                    },
                  ),
                  Row(
                    spacing: 10,
                    children: [Text("Select Area",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    DropdownButton(
                    focusColor: Colors.grey,
                    value: selectedarea,
                    items: widget.parkingdata.firstWhere((p) => p.cityName == selectedcity).area.map((area) {
                      return DropdownMenuItem(value: area, child: Text(area));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedarea = value!;
                      });
                    },
                  ),],
                  )
                ],
              ),
            ],
          ),
          Divider(color: Colors.black, thickness: 2),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                "Total Available Slots:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ],
          ),
          SizedBox(height: 10),
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
                          // margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.only(left: 15),
                          height: 40,
                          width: 355,
                          decoration: BoxDecoration(
                            color: const Color(0xFF74ABE2),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Row(
                            spacing: 210,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

                        // Text(SlotDetails[selectedcity]![i]==false ? "Slot $i" : ""),
                      ],
                    ),

                  //Make an else to avoid empty space box
                ],
              ),
            ),
          ),
          Divider(color: Colors.black, thickness: 2),
          SizedBox(height: 10),
          // Row(
          //   children: [
          //     Text(
          //       "Occupied Slots: ",
          //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          //     ),
          //     Text(
          //       OccupiedSlots[selectedcity].toString(),
          //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          //     ),
          //   ],
          // ),
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
                      color: const Color.fromARGB(255, 54, 130, 244),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Text(
                      " $totalSlots",
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  Text(
                    "Total",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                      color: const Color.fromARGB(236, 69, 244, 110),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Text(
                      " $availableSlots",
                      style: TextStyle(fontSize: 55),
                    ),
                  ),
                  Text(
                    "Free",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                      color: const Color.fromARGB(166, 244, 67, 54),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Text(
                      " $occupiedSlots",
                      style: TextStyle(fontSize: 55),
                    ),
                  ),
                  Text(
                    "Occupied",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.parkingdata.removeWhere((p) => p.cityName == selectedcity);
                selectedcity = widget.parkingdata[1].cityName;
              });
              }
            ,
            child: Container(
              width: 100,
              child: Row(
                spacing: 7,
                children: [Icon(Icons.delete), Text("Delete City")],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
