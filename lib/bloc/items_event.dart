part of 'items_bloc.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object> get props => [];
}

class AddItem extends ItemsEvent {
  final GroceryItem item;

  const AddItem(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveItem extends ItemsEvent {
  final GroceryItem item;

  const RemoveItem(this.item);
}

class UpdateItem extends ItemsEvent {
  final GroceryItem item;
  final String? oldItem;

  const UpdateItem({required this.item, this.oldItem});

  @override
  List<Object> get props => [item];
}
