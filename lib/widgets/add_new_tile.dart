import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/models/shopping_item_model.dart';

class AddNewTile extends ConsumerStatefulWidget {
  const AddNewTile({super.key, required this.addItem});

  final void Function(ShoppingItemModel) addItem;

  @override
  ConsumerState<AddNewTile> createState() => _AddNewTileState();
}

class _AddNewTileState extends ConsumerState<AddNewTile> {
  final _formKey = GlobalKey<FormState>();
  ShoppingItemModel item = ShoppingItemModel.empty();

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.addItem(item);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                labelText: 'Title',
              ),
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 3) {
                  return 'The title field cannot be empty. Please enter a title.';
                }
                return null;
              },
              onSaved: (newValue) {
                item.setName(newValue!);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                labelText: 'Quantity',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    int.tryParse(value) == null ||
                    int.tryParse(value)! < 0) {
                  return 'Enter a valid number.';
                }
                return null;
              },
              onSaved: (newValue) {
                item.setQuantity(newValue!);
              },
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel')),
                ElevatedButton(onPressed: _onSubmit, child: const Text('Done')),
              ],
            ),
          )
        ],
      ),
    );
  }
}
