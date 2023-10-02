import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shopping/models/response_item.dart';
import 'package:shopping/models/shopping_item_model.dart';

class FirebaseHandler {
  static const String baseUrl =
      'flutter-prep-e7c14-default-rtdb.firebaseio.com';
  static final url = Uri.https(baseUrl, 'shopping_app.json');
  static final headers = {'Content-Type': 'application/json'};

  static Future<ShoppingItemModel?> postItems(
      BuildContext context, ShoppingItemModel model) async {
    try {
      final res = await post(
        url,
        headers: headers,
        body: json.encode(
          {
            'title': model.name,
            'quantity': model.quantity,
          },
        ),
      );

      if (res.statusCode >= 400) {
        print(
            'Post failed: Firebase Handler POST request returned status code ${res.statusCode}.');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to add item. Try again')));
        }
        return null;
      }

      return ShoppingItemModel.fromBackend(
          id: json.decode(res.body)['name'],
          name: model.name,
          quantity: model.quantity);
    } on Exception {
      print('Post failed: Firebase Handler POST request failed!');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to connect. Try again')));
      }
      return null;
    }
  }

  static Future<Response> deleteItems(String id) {
    return delete(Uri.https(baseUrl, 'shopping_app/$id.json'));
  }

  static Future<ResponseItem> getItems() async {
    final List<ShoppingItemModel> models = [];
    final res = await get(url);

    Map<String, dynamic>? out = json.decode(res.body);
    if (res.statusCode >= 400) {
      return ResponseItem(
          models: models, errorMessage: 'Oops! Something went wrong.');
    }
    if (out == null) {
      return ResponseItem(models: models);
    }

    for (final m in out.entries) {
      models.add(ShoppingItemModel.fromBackend(
          id: m.key, name: m.value['title'], quantity: m.value['quantity']));
    }

    final response = ResponseItem(models: models);

    return response;
  }
}
