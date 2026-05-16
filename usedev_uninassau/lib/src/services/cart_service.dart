import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartService extends ChangeNotifier {
  
  static final CartService _instance = CartService._internal();
  
  factory CartService() {
    return _instance;
  }
  
  CartService._internal();
  

  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => _items;

  
  double get totalPrice {
    return _items.fold(0, (total, current) => total + (current.product.price * current.quantity));
  }

  
  void addItem(ProductModel product) {
    
    final index = _items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItemModel(product: product));
    }
    
    notifyListeners();
  }

  
  void removeItem(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  
  void incrementQuantity(int productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  
  void decrementQuantity(int productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}