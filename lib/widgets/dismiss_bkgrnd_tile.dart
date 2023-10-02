import 'package:flutter/material.dart';

class DismissBackgroundTile extends StatelessWidget {
  const DismissBackgroundTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.red[300]),
      child: Row(children: [
        const SizedBox(
          width: 14,
        ),
        const Icon(Icons.delete),
        const SizedBox(
          width: 4,
        ),
        Text(
          'Remove',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ]),
    );
  }
}
