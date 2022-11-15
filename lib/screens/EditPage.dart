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
  void popRoute() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as GroceryItem;
    final nameValue = TextEditingController(text: item.name);
    final priceValue = TextEditingController(text: '${item.price}');
    final formKey = GlobalKey<FormState>();
    final formKey2 = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit item'),
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: () {
              context.read<ItemsBloc>().add(
                    UpdateItem(item: item),
                  );
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
                  controller: nameValue,
                ),
              ),
              Form(
                key: formKey2,
                child: TextFormField(
                  controller: priceValue,
                ),
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
