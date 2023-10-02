import 'package:flutter/material.dart';
import 'package:shopping/models/shopping_item_model.dart';

class ShoppingTile extends StatelessWidget {
  const ShoppingTile({super.key, required this.model});

  final ShoppingItemModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: model.color,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(model.name,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Text(model.quantity.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ));
  }
}
