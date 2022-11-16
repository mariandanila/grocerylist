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
}
