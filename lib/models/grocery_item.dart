// lib/models/grocery_item.dart

class GroceryItem {
  String itemName;
  int quantity;

  GroceryItem({required String itemName, required int quantity})
      : itemName = itemName,
        quantity = quantity;

  int getQuantity() {
    return quantity;
  }

  String getItemName() {
    return itemName;
  }

  @override
  String toString() {
    return '$quantity: $itemName';
  }
}
