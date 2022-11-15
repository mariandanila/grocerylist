import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocerylist/models/GroceryItemModel.dart';
import 'package:meta/meta.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
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
        print('[ItemsBloc] Event received...');
        List<GroceryItem> newList = [...state.items];
        GroceryItem newItem = event.item; //
        for (int i = 0; i < newList.length; i++) {
          if (newList[i].name == event.item.name) {
            // stergerea elementului respectiv si adaugarea pe aceeasi pozitie
            int index = newList.indexOf(newList[i]);
            newList.removeAt(index);
            newList.add(newItem);
          }
        }
        print('[ItemsBloc] Event finished...');
        print('Updated list: $newList');
        emit(state.copyWith(items: newList));
      },
    );
  }
}
