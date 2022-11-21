import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerylist/bloc/items_bloc.dart';
import 'package:grocerylist/components/FormInput.dart';
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
          name: nameValue.text, price: double.parse(priceValue.text))));
    }
  }

  void _showModalContent() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          // shape: const CircleBorder(),
          children: [
            SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: nameValue,
                        decoration: InputDecoration(
                          hintText: 'Enter item',
                          suffixIcon: IconButton(
                            onPressed: nameValue.clear,
                            icon: Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: priceValue,
                      decoration: InputDecoration(
                        labelText: 'Enter price',
                        suffixIcon: IconButton(
                          onPressed: priceValue.clear,
                          icon: Icon(Icons.clear),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          addItemToList(_formKey);
                          nameValue.clear();
                          priceValue.clear();
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: const Text('save')),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showOverlay(BuildContext context) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Align(
          alignment: Alignment.center,
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: nameValue,
                        decoration: InputDecoration(
                          hintText: 'Enter item',
                          suffixIcon: IconButton(
                            onPressed: nameValue.clear,
                            icon: Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: priceValue,
                      decoration: InputDecoration(
                        labelText: 'Enter price',
                        suffixIcon: IconButton(
                          onPressed: priceValue.clear,
                          icon: Icon(Icons.clear),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          addItemToList(_formKey);
                          nameValue.clear();
                          priceValue.clear();
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: const Text('save')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    overlayState!.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Grocery list'),
      ),
      body: BlocBuilder<ItemsBloc, ItemsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Container(
                height: height,
                margin: const EdgeInsets.only(left: 16, right: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          child: Text(
                            'Add item',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          onPressed: () {
                            _showModalContent();
                          },
                        ),
                        Image.asset(
                          'lib/icons/grocery-cart.png',
                          height: 50,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    if (state.items.isEmpty) ...[
                      Text('Your grocery list is empty.'),
                    ] else ...[
                      Flexible(
                        child: ListView.separated(
                          itemCount: state.items.length,
                          itemBuilder: (BuildContext context, index) {
                            return Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                context.read<ItemsBloc>().add(
                                      RemoveItem(state.items[index]),
                                    );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${state.items[index].name} removed'),
                                  ),
                                );
                              },
                              background: Container(
                                color: Color.fromARGB(255, 255, 162, 150)
                              ),
                              child: ListTile(
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
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                                  thickness: 1,
                                  color: Color.fromARGB(255, 119, 66, 66)),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
