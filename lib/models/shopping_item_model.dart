import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final colorRange = [
  Colors.amber[200]!,
  Colors.red[200]!,
  Colors.blue[200]!,
  Colors.green[200]!,
  Colors.brown[200]!,
  Colors.cyan[200]!,
  Colors.deepOrange[200]!,
  Colors.grey[200]!,
  Colors.indigo[200]!,
  Colors.yellow[200]!,
  Colors.teal[200]!,
  Colors.purple[200]!,
  Colors.lime[200]!,
  Colors.pink[200]!,
  Colors.orange[200]!,
  Colors.lightBlue[200]!,
];

class ShoppingItemModel {
  final String id;
  String name;
  int quantity;
  final Color color;

  ShoppingItemModel({
    required this.name,
    required this.quantity,
    required this.color,
  }) : id = uuid.v4();

  ShoppingItemModel.fromBackend(
      {required this.id, required this.name, required this.quantity})
      : color = colorRange[Random().nextInt(colorRange.length)];

  ShoppingItemModel.empty()
      : id = uuid.v4(),
        name = '',
        quantity = 1,
        color = colorRange[Random().nextInt(colorRange.length)];

  ShoppingItemModel.withRandColor({
    required this.name,
    required this.quantity,
  })  : id = uuid.v4(),
        color = colorRange[Random().nextInt(colorRange.length)];

  void setName(String text) {
    name = text;
  }

  void setQuantity(String quant) {
    quantity = int.parse(quant);
  }
}
