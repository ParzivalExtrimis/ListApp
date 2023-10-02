import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/backend/firebase_handler.dart';
import 'package:shopping/models/response_item.dart';
import 'package:shopping/models/shopping_item_model.dart';
import 'package:shopping/providers/loading_provider.dart';

// sample list
final List<ShoppingItemModel> sampleItems = [
  ShoppingItemModel(name: 'Apple', quantity: 8, color: Colors.red[200]!),
  ShoppingItemModel(name: 'Pencils', quantity: 4, color: Colors.grey[200]!),
  ShoppingItemModel(name: 'Lampshades', quantity: 2, color: Colors.amber[200]!),
];

StateNotifierProvider<ShoppingListNotifier, ResponseItem>
    shoppingListNotifierProvider =
    StateNotifierProvider<ShoppingListNotifier, ResponseItem>((ref) {
  return ShoppingListNotifier(
      loadingStateNotifier: ref.read(loadingStateNotifierProvider.notifier));
});

class ShoppingListNotifier extends StateNotifier<ResponseItem> {
  ShoppingListNotifier({required LoadingStateNotifier loadingStateNotifier})
      : loader = loadingStateNotifier,
        super(ResponseItem(models: []));

  LoadingStateNotifier loader;

  void init() async {
    state = await FirebaseHandler.getItems();
    loader.toggle();
  }

  void append(ShoppingItemModel m) async {
    state.models = [...state.models, m];
  }

  void delete(String modelId) {
    state.models = state.models.where((m) => m.id != modelId).toList();
    FirebaseHandler.deleteItems(modelId);
  }
}
