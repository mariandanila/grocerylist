import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerylist/bloc/items_bloc.dart';
import 'package:grocerylist/screens/HomePage.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ItemsBloc(),
        ),
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    ),
  );
}
