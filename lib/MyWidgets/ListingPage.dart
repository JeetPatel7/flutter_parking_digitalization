import 'package:flutter/material.dart';
import 'package:parking_digitalization/MyWidgets/PrakingData.dart';

class firstpage extends StatefulWidget {
  final List<CityParking> parkingdata;
  const firstpage({super.key,required this.parkingdata});

  @override
  State<firstpage> createState() => firstpageState();
}

class firstpageState extends State<firstpage> {
 
  String selectedcity = "Rajkot";
  // String selectedarea = widget.parkingdata[0].area[0];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [IconButton(onPressed: (){
              Navigator.pushNamed(context, '/edit',arguments: widget.parkingdata);
              
            }, icon: Icon(Icons.add))],
          ),
          Divider(color: Colors.black, thickness: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 150,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.end,
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
                      });
                    },
                  ),
                  // Text("Selec Area: ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  // DropdownButton(
                  //   focusColor: Colors.grey,
                  //   value: selectedarea,
                  //   items: widget.parkingdata.map((parking) {
                  //     return DropdownMenuItem(value: parking.cityName, child: Text(parking.cityName));
                  //   }).toList(),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       selectedcity = value!;
                  //     });
                  //   },
                  // ),
                ],
              ),
            ],
          ),
          // Row(
          //   children: [
          //     Text(
          //       "Total Slots:${Slots[selectedcity]}",
          //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          //     ),
          //   ],
          // ),
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
                  for (int i = 1; i <= widget.parkingdata.firstWhere((p) => p.cityName == selectedcity).totalSlots; i++)
                    // if (SlotDetails[selectedcity]![i] == false)
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
                                // title: Text("Slot $i: ",style: TextStyle(
                                //   fontSize: 20,
                                //   fontWeight: FontWeight.w500,
                                //   color: Colors.black,
                                // )),
                                value: widget.parkingdata.firstWhere((p) => p.cityName == selectedcity).slotDetails[i],
                                onChanged: (value) {
                                  setState(() {
                                    bool oldValue =
                                        widget.parkingdata.firstWhere((p) => p.cityName == selectedcity).slotDetails[i]!;

                                    // update checkbox value
                                    widget.parkingdata.firstWhere((p) => p.cityName == selectedcity).slotDetails[i] = value!;

                                    // if free -> occupied
                                    if (oldValue == false && value == true) {
                                      widget.parkingdata.firstWhere((p) => p.cityName == selectedcity).occupiedSlots =
                                          widget.parkingdata.firstWhere((p) => p.cityName == selectedcity).occupiedSlots + 1;

                                      widget.parkingdata.firstWhere((p) => p.cityName == selectedcity).availableSlots =
                                          widget.parkingdata.firstWhere((p) => p.cityName == selectedcity).availableSlots - 1;
                                    }
                                    // if occupied -> free
                                    else if (oldValue == true &&
                                        value == false) {
                                      widget.parkingdata.firstWhere((p) => p.cityName == selectedcity).occupiedSlots =
                                          widget.parkingdata.firstWhere((p) => p.cityName == selectedcity).occupiedSlots - 1;

                                      widget.parkingdata.firstWhere((p) => p.cityName == selectedcity).availableSlots =
                                          widget.parkingdata.firstWhere((p) => p.cityName == selectedcity).availableSlots + 1;
                                    }
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
                      " ${widget.parkingdata.firstWhere((p) => p.cityName == selectedcity).totalSlots}",
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
                      " ${widget.parkingdata.firstWhere((p) => p.cityName == selectedcity).availableSlots}",
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
                      " ${widget.parkingdata.firstWhere((p) => p.cityName == selectedcity).occupiedSlots}",
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
