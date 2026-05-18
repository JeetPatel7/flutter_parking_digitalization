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
      12: true,
      11: false,
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

  String selectedcity = "Rajkot";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [IconButton(onPressed: null, icon: Icon(Icons.add))],
        ),
        Divider(color: Colors.black, thickness: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DropdownButton(
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
        Row(
          children: [
            Text(
              "Total Slots:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ],
        ),
        Container(
          height: 300,
          margin: EdgeInsets.all(15),
          color: const Color.fromARGB(145, 199, 178, 178),
          child: SingleChildScrollView(
            child: Column(
              spacing: 15,
              children: [
                // Expanded(
                //  ListView.builder(
                //   // shrinkWrap: true,
                //   // physics: NeverScrollableScrollPhysics(),
                //   itemCount: AvailableSlots[selectedcity],
                //   itemBuilder: (context, index) {
                //     int slotNumber = index + 1;
                //     // bool isOccupied = SlotDetails[selectedcity]![slotNumber]!;
                //     return Row(
                //       children: [
                //         // Text()
                //       ],
                //     );
                //   },
                // ),
                // ),
                for (int i = 1; i <= Slots[selectedcity]!; i++)
                  if (SlotDetails[selectedcity]![i] == false)
                    Row(
                      children: [
                        // Text(SlotDetails[selectedcity]![i]==false ? "Slot $i" : ""),
                        Text(
                          "Slot $i: ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight(15),
                            color: Colors.black,
                          ),
                        ),

                        Checkbox(
                          value: false,
                          onChanged: (value) {
                            setState(() {
                              SlotDetails[selectedcity]![i] = value!;
                            });
                          },
                        ),
                      ],
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
