part of 'items_bloc.dart';

@immutable
class ItemsState extends Equatable {
  final List<GroceryItem> items;
  const ItemsState({required this.items});

  ItemsState copyWith({
    List<GroceryItem>? items,
  }) {
    return ItemsState(items: items ?? this.items);
  }

  @override
  List<Object> get props => [items];
}
