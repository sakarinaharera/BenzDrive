import 'package:flutter/material.dart';

class CarModel {
  final String id;
  final String name;
  final String type;
  final String price;
  final String image;
  final String description;
  final int year;
  final String engine;
  bool isFavorite;
  final List<String> availableColors;
  final List<Color> colorHexCodes;

  CarModel({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.image,
    required this.description,
    required this.year,
    required this.engine,
    this.isFavorite = false,
    this.availableColors = const ['Hitam', 'Putih', 'Silver'],
    this.colorHexCodes = const [Colors.black, Colors.white, Colors.grey],
  });
}
