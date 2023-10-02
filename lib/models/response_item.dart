import 'package:shopping/models/shopping_item_model.dart';

class ResponseItem {
  List<ShoppingItemModel> models;
  String? errorMessage;

  ResponseItem({required this.models, this.errorMessage});

  void setErrorMessage(String message) {
    errorMessage = message;
  }
}
