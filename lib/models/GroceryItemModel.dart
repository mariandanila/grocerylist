class GroceryItem {
  final String name;
  final double price;

  GroceryItem({
    this.name = '',
    this.price = 0.00,
  });

  GroceryItem.fromJson(Map<String, dynamic> json)
      : name = json['n'] as String,
        price = json['p'];

  Map<String, dynamic> toJson() {
    return {
      'n': name,
      'p': price,
    };
  }
}
