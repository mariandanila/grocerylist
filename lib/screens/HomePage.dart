import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerylist/bloc/items_bloc.dart';
import 'package:grocerylist/models/GroceryItemModel.dart';
import 'package:grocerylist/screens/EditPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameValue = TextEditingController();
  final priceValue = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameValue.dispose();
    priceValue.dispose();
    super.dispose();
  }

  void addItemToList(GlobalKey<FormState> formKey) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      context.read<ItemsBloc>().add(AddItem(GroceryItem(
          name: nameValue.text,
          price: double.parse(priceValue.text))));
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Grocery list'),
      ),
      body: BlocBuilder<ItemsBloc, ItemsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              height: height,
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: TextFormField(
                        controller: nameValue,
                        decoration: InputDecoration(
                          hintText: 'Enter item',
                        )),
                  ),
                  TextField(
                    controller: priceValue,
                    decoration: InputDecoration(labelText: 'Enter price'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        addItemToList(_formKey);
                      },
                      child: const Text('save')),
                  Flexible(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, index) {
                        return ListTile(
                          title: Text(state.items[index].name),
                          trailing: Text('\$${state.items[index].price}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditPage(),
                                settings: RouteSettings(
                                  arguments: state.items[index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
