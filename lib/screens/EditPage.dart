import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerylist/bloc/items_bloc.dart';
import 'package:grocerylist/models/GroceryItemModel.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  String updatedName = '';
  double updatedPrice = 0.00;

  void popRoute() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as GroceryItem;
    final nameValue = TextEditingController(text: item.name);
    final priceValue = TextEditingController(text: item.price.toString());
    dynamic newwItem;
    String oldItem = item.name;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit item'),
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: () {
              newwItem = GroceryItem(name: updatedName, price: updatedPrice);
              context
                  .read<ItemsBloc>()
                  .add(UpdateItem(item: newwItem, oldItem: oldItem));
              popRoute();
            },
          ),
        ],
        leading: const BackButton(color: Colors.white),
      ),
      body: BlocBuilder<ItemsBloc, ItemsState>(
        builder: ((context, state) {
          return Column(
            children: [
              Form(
                key: formKey,
                child: TextFormField(
                  onChanged: (value) {
                    updatedName = value;
                  },
                  controller: nameValue,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: nameValue.clear,
                      icon: Icon(Icons.clear),
                    ),
                  ),
                ),
              ),
              Form(
                key: formKey2,
                child: TextFormField(
                    onChanged: (value) {
                      updatedPrice = double.parse(value);
                    },
                    controller: priceValue,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: priceValue.clear,
                        icon: Icon(Icons.clear),
                      ),
                    )),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<ItemsBloc>().add(
                        RemoveItem(item),
                      );
                  popRoute();
                },
                child: const Text('remove'),
              ),
            ],
          );
        }),
      ),
    );
  }
}
