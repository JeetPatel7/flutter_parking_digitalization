import 'package:flutter/material.dart';
import 'package:parking_digitalization/MyWidgets/PrakingData.dart';

class editpage extends StatefulWidget {
  final List<CityParking> parkingdata;
  const editpage({super.key, required this.parkingdata});

  @override
  State<editpage> createState() => _editpageState();
}

class _editpageState extends State<editpage> {
  late List<CityParking> parkingdata;
  late String selectedcity;
  late String selectedarea;
  bool _initialized = false;

  final TextEditingController areaNameController = TextEditingController();
  final TextEditingController slotCountController = TextEditingController();
  final TextEditingController newAreaNameController = TextEditingController();
  final TextEditingController newAreaSlotsController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      // Use the list passed to this widget (from Fragment_holder) as source of truth.
      parkingdata = widget.parkingdata;
      if (parkingdata.isNotEmpty) {
        selectedcity = parkingdata.first.cityName;
        selectedarea = parkingdata.first.area.first;
        _syncControllers();
      } else {
        selectedcity = '';
        selectedarea = '';
      }
      _initialized = true;
    }
  }

  CityParking? get _selectedCity {
    if (parkingdata.isEmpty) return null;
    return parkingdata.firstWhere(
      (item) => item.cityName == selectedcity,
      orElse: () => parkingdata.first,
    );
  }

  Map<int, bool> get _selectedAreaSlots {
    final city = _selectedCity;
    if (city == null) return {};
    return city.slotDetails[selectedarea] ?? {};
  }

  void _syncControllers() {
    if (selectedarea.isNotEmpty) {
      areaNameController.text = selectedarea;
      slotCountController.text = _selectedAreaSlots.length.toString();
    }
  }

  void _updateCityTotals(CityParking city) {
    final allSlots = city.slotDetails.values.expand((map) => map.entries);
    final occupied = allSlots.where((entry) => entry.value).length;
    final total = city.slotDetails.values.fold<int>(
      0,
      (sum, map) => sum + map.length,
    );
    city.totalSlots = total;
    city.occupiedSlots = occupied;
    city.availableSlots = total - occupied;
  }

  void _renameArea(String newName) {
    final city = _selectedCity;
    if (city == null) return;
    final trimmedName = newName.trim();
    if (trimmedName.isEmpty || trimmedName == selectedarea) return;
    if (city.area.contains(trimmedName)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Area already exists in this city.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final existingIndex = city.area.indexOf(selectedarea);
    if (existingIndex >= 0) {
      city.area[existingIndex] = trimmedName;
    }
    final slots = city.slotDetails.remove(selectedarea) ?? {};
    city.slotDetails[trimmedName] = slots;
    selectedarea = trimmedName;
  }

  void _saveAreaEdits() {
    final city = _selectedCity;
    if (city == null) return;
    final newName = areaNameController.text.trim();
    if (newName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter an area name.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_selectedAreaSlots.containsKey(1)) {
      selectedarea = city.area.first;
    }

    if (newName != selectedarea) {
      _renameArea(newName);
    }

    final int newSlotCount =
        int.tryParse(slotCountController.text.trim()) ??
        _selectedAreaSlots.length;
    if (newSlotCount < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Slot count must be at least 1.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final currentSlots = _selectedAreaSlots;
    final updatedSlots = <int, bool>{};
    for (var index = 1; index <= newSlotCount; index++) {
      if (currentSlots.containsKey(index)) {
        updatedSlots[index] = currentSlots[index]!;
      } else {
        updatedSlots[index] = false;
      }
    }

    city.slotDetails[selectedarea] = updatedSlots;
    _updateCityTotals(city);

    setState(() {
      slotCountController.text = updatedSlots.length.toString();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Area updated successfully.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Slot toggling removed: editing slot occupancy is not allowed here.

  void _addNewArea() {
    final city = _selectedCity;
    if (city == null) return;
    final newAreaName = newAreaNameController.text.trim();
    final newAreaSlotCount =
        int.tryParse(newAreaSlotsController.text.trim()) ?? 0;

    if (newAreaName.isEmpty || newAreaSlotCount < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter a valid area name and slot count.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (city.area.contains(newAreaName)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This area already exists.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newSlots = <int, bool>{};
    for (var i = 1; i <= newAreaSlotCount; i++) {
      newSlots[i] = false;
    }

    city.area.add(newAreaName);
    city.slotDetails[newAreaName] = newSlots;
    _updateCityTotals(city);

    setState(() {
      selectedarea = newAreaName;
      areaNameController.text = newAreaName;
      newAreaNameController.clear();
      newAreaSlotsController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('New area added successfully.'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(  context, true);
  }

  @override
  void dispose() {
    areaNameController.dispose();
    newAreaNameController.dispose();
    newAreaSlotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final city = _selectedCity;
    final areaSlots = _selectedAreaSlots;
    final slotCount = areaSlots.length;

    return Scaffold(
      body: Container(
        height: double.infinity,
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Edit City and Slots',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                if (parkingdata.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Text('No city data available.'),
                    ),
                  )
                else ...[
                  const Text(
                    'Select City',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedcity,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: parkingdata.map((parking) {
                      return DropdownMenuItem(
                        value: parking.cityName,
                        child: Text(parking.cityName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        selectedcity = value;
                        final cityData = _selectedCity!;
                        selectedarea = cityData.area.first;
                        _syncControllers();
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Select Area',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedarea,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: city!.area.map((area) {
                      return DropdownMenuItem(value: area, child: Text(area));
                    }).toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        selectedarea = value;
                        _syncControllers();
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Edit Area',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: areaNameController,
                    decoration: InputDecoration(
                      labelText: 'Area Name',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: slotCountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Slot Count',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: _saveAreaEdits,
                        icon: const Icon(Icons.save),
                        label: const Text('Save Area'),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                        ),
                        onPressed: () {
                          setState(() {
                            _syncControllers();
                          });
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Total slots in this area: $slotCount',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.black,thickness: 2),
                  const SizedBox(height: 20),
                  const Text(
                    'Add New Area to City',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: newAreaNameController,
                    decoration: InputDecoration(
                      labelText: 'New Area Name',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: newAreaSlotsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Number of Slots',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: _addNewArea,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Area'),
                  ),
                  const SizedBox(height: 40),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
