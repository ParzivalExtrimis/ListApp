import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/backend/firebase_handler.dart';
import 'package:shopping/models/response_item.dart';
import 'package:shopping/models/shopping_item_model.dart';
import 'package:shopping/widgets/add_new_tile.dart';
import 'package:shopping/widgets/dismiss_bkgrnd_tile.dart';
import 'package:shopping/widgets/shopping_tile.dart';

class ShoppingListScreen extends ConsumerStatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  ConsumerState<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends ConsumerState<ShoppingListScreen> {
  ResponseItem _response = ResponseItem(models: []);
  bool isLoading = true;

  void _init() async {
    final response = await FirebaseHandler.getItems();
    setState(() {
      _response = response;
      isLoading = false;
    });
  }

  void _addItem(ShoppingItemModel item) async {
    setState(() {
      isLoading = true;
    });

    final response = _response;
    final ShoppingItemModel? model =
        await FirebaseHandler.postItems(context, item);

    if (model != null) {
      response.models.add(model);
    }

    setState(() {
      _response = response;
      isLoading = false;
    });
  }

  void _remove(String modelId) {
    setState(() {
      _response.models.removeWhere((m) => m.id == modelId);
    });
    FirebaseHandler.deleteItems(modelId);
  }

  void _onFabPressed(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return AddNewTile(
            addItem: _addItem,
          );
        });
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceS = MediaQuery.of(context).size;
    Widget? content;

    setState(() {
      if (isLoading) {
        content = const Center(child: CircularProgressIndicator());
      } else if (_response.errorMessage != null) {
        content = Center(
          child: Column(
            children: [
              SizedBox(height: deviceS.height * 0.2),
              Image.asset(
                'images/connection_down.png',
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                height: deviceS.height * 0.3,
                width: deviceS.width * 0.4,
              ),
              Text(
                _response.errorMessage!,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5),
                    ),
              ),
            ],
          ),
        );
      } else if (_response.models.isEmpty) {
        content = Center(
          child: Text(
            'Nothing to see here yet.',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.5),
                ),
          ),
        );
      } else {
        content = ListView.builder(
            itemCount: _response.models.length,
            itemBuilder: (ctx, ix) => Dismissible(
                key: ValueKey(_response.models[ix].id),
                onDismissed: (_) {
                  _remove(_response.models[ix].id);
                },
                background: const DismissBackgroundTile(),
                child: ShoppingTile(model: _response.models[ix])));
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Shopper')),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _onFabPressed(context),
          child: const Icon(Icons.add)),
      body: content,
    );
  }
}
