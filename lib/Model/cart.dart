import 'package:flutter/material.dart';

class Cart {
  final String name;
  final String image;
  final double price;
  late final int quantity;
  final String color;
  final String size;
  Cart({
    required this.price,
    required this.name,
    required this.image,
    required this.size,
    required this.color,
    required this.quantity,
  });
}
