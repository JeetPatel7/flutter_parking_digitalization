import 'package:flutter/material.dart';

class firstpage extends StatefulWidget {
  const firstpage({super.key});

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  Map<String, int> Slots = {
    "Rajkot": 10,
    "Ahmedabad": 5,
    "Surat": 12,
    // "Vadodara": 80,
    // "Gandhinagar": 50,
  };
  Map<String, Map<int, bool>> SlotDetails = {
    "Rajkot": {
      1: true,
      2: false,
      3: true,
      4: false,
      5: true,
      6: true,
      7: false,
      8: true,
      9: false,
      10: true,
    },
    "Ahmedabad": {1: true, 2: true, 3: false, 4: true, 5: false},
    "Surat": {
      1: false,
      2: true,
      3: true,
      4: false,
      5: true,
      6: true,
      7: false,
      8: true,
      9: false,
      10: true,
      11: true,
      12: false,
    },
    // "Vadodara": {1: true, 2: false, 3: true, 4: true, 5: false},
    // "Gandhinagar": {1: false, 2: true, 3: false, 4: true, 5: true},
  };
  Map<String, int> OccupiedSlots = {
    "Rajkot": 6,
    "Ahmedabad": 3,
    "Surat": 7,
    // "Vadodara": 40,
    // "Gandhinagar": 30,
  };
  List<String> Cities = [
    "Rajkot",
    "Ahmedabad",
    "Surat",
    // "Vadodara",
    // "Gandhinagar",
  ];
  Map<String, int> AvailableSlots = {
    "Rajkot": 4,
    "Ahmedabad": 2,
    "Surat": 5,
    // "Vadodara": 40,
    // "Gandhinagar": 30,
  };
  Map<String, List<String>> Address = {
    "Rajkot": ["Address 1", "Address 2", "Address 3"],
    "Ahmedabad": ["Address 4", "Address 5", "Address 6"],
    "Surat": ["Address 7", "Address 8", "Address 9"],
    // "Vadodara": ["Address 10", "Address 11", "Address 12"],
    // "Gandhinagar": ["Address 13", "Address 14", "Address 15"],
  };

  String selectedcity = "Rajkot";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [IconButton(onPressed: null, icon: Icon(Icons.add))],
          ),
          Divider(color: Colors.black, thickness: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 80,
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
                    items: Cities.map((c) {
                      return DropdownMenuItem(value: c, child: Text(c));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedcity = value!;
                      });
                    },
                  ),
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
                  for (int i = 1; i <= Slots[selectedcity]!; i++)
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
                            children: [
                              Text(
                                "Slot $i",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),

                              Checkbox(
                                // title: Text("Slot $i: ",style: TextStyle(
                                //   fontSize: 20,
                                //   fontWeight: FontWeight.w500,
                                //   color: Colors.black,
                                // )),
                                value: SlotDetails[selectedcity]![i],
                                onChanged: (value) {
                                  setState(() {
                                    SlotDetails[selectedcity]![i] = value!;
                                    if (value) {
                                      OccupiedSlots[selectedcity] =
                                          OccupiedSlots[selectedcity]! + 1;
                                    } else {
                                      AvailableSlots[selectedcity] =
                                          AvailableSlots[selectedcity]! + 1;
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
                    padding: EdgeInsets.only(left: 8,top: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 54, 130, 244),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Text(
                      " ${Slots[selectedcity]}",
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
                    padding: EdgeInsets.only(left: 8,top: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(236, 69, 244, 110),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Text(
                      " ${AvailableSlots[selectedcity]}",
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
                    padding: EdgeInsets.only(left: 8,top: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(166, 244, 67, 54),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child:
                       Text(
                        " ${OccupiedSlots[selectedcity]}",
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
                Cities.remove(selectedcity);
                selectedcity = Cities[1];
                OccupiedSlots.remove('selectedcity');
                Slots.remove('selectedcity');
                AvailableSlots.remove('selectedcity');
                SlotDetails.remove('selectedcity');
              });
            },
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
