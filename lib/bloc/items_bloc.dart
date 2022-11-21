import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocerylist/models/GroceryItemModel.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'items_event.dart';
part 'items_state.dart';

const String KEY_ITEMS_IN_GROCERY_LIST = 'items_in_list';

class ItemsBloc extends HydratedBloc<ItemsEvent, ItemsState> {
  ItemsBloc()
      : super(
          const ItemsState(
            items: [],
          ),
        ) {
    on<AddItem>(
      (event, emit) {
        List<GroceryItem> newList = [...state.items];
        newList.add(event.item);
        emit(state.copyWith(items: newList));
      },
    );

    on<RemoveItem>(
      (event, emit) {
        List<GroceryItem> newList = [...state.items];
        newList.remove(event.item);
        emit(state.copyWith(items: newList));
      },
    );

    on<UpdateItem>(
      (event, emit) {
        List<GroceryItem> newList = [...state.items];
        for (int i = 0; i < newList.length; i++) {
          if (newList[i].name == event.oldItem) {
            // stergerea elementului respectiv si adaugarea pe aceeasi pozitie
            int index = newList.indexOf(newList[i]);
            newList.removeAt(index);
            newList.insert(index, event.item);
          }
        }
        emit(state.copyWith(items: newList));
      },
    );
  }

  @override
  ItemsState fromJson(Map<String, dynamic> json) {
    try {
      final List<GroceryItem> lastGroceryList = [];

      for (var entry in json[KEY_ITEMS_IN_GROCERY_LIST]) {
        lastGroceryList.add(GroceryItem.fromJson(entry));
      }

      return ItemsState(
        items: lastGroceryList,
      );
    } catch (err) {
      print('[From Json Profile Bloc] : $err');

      return ItemsState(
        items: [],
      );
    }
  }

  @override
  Map<String, dynamic> toJson(ItemsState state) {
    final List<GroceryItem> lastGroceryList = [];

    for (int i = 0; i < state.items.length; i++) {
      lastGroceryList.add(state.items[i]);
    }

    return {
      KEY_ITEMS_IN_GROCERY_LIST: lastGroceryList,
    };
  }
}
