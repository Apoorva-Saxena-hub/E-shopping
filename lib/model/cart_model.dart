import 'package:flutter/material.dart';

class CartModel with ChangeNotifier {
  List<Map> _items = [];
  List<Map> _favorites = [];

  List<Map> get items => _items;
  List<Map> get favorites => _favorites;

  void addItem(Map product, int quantity) {
    _items.add({...product, 'quantity': quantity});
    notifyListeners();
  }

  void removeItem(Map product) {
    _items.remove(product);
    notifyListeners();
  }

  void updateItemQuantity(Map product, int quantity) {
    final index = _items.indexWhere((item) => item['id'] == product['id']);
    if (index != -1) {
      _items[index]['quantity'] = quantity;
      notifyListeners();
    }
  }

  void addFavorite(Map product) {
    if (!_favorites.contains(product)) {
      _favorites.add(product);
      notifyListeners();
    }
  }

  void removeFavorite(Map product) {
    _favorites.remove(product);
    notifyListeners();
  }
}
