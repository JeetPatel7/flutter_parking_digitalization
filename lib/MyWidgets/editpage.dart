import 'package:flutter/material.dart';
import 'package:parking_digitalization/MyWidgets/PrakingData.dart';

class Editpage extends StatefulWidget {
  final List<CityParking> parkingdata;
  const Editpage({super.key, required this.parkingdata});

  @override
  State<Editpage> createState() => _EditpageState();
}

class _EditpageState extends State<Editpage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}