import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  final String imagePath;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price': price,
        'imagePath': imagePath,
        'quantity': quantity,
      };
}

class CartProvider with ChangeNotifier {
  static const String _cartKey = 'cart';
  Map<String, CartItem> _items = {};
  late SharedPreferences _prefs;

  CartProvider() {
    _loadCart();
  }

  Future<void> _loadCart() async {
    _prefs = await SharedPreferences.getInstance();
    final cartData = _prefs.getString(_cartKey);
    if (cartData != null) {
      final Map<String, dynamic> decodedData = json.decode(cartData);
      _items = decodedData.map((key, value) => MapEntry(
            key,
            CartItem(
              id: value['id'],
              name: value['name'],
              price: value['price'],
              imagePath: value['imagePath'],
              quantity: value['quantity'],
            ),
          ));
      notifyListeners();
    }
  }

  Future<void> _saveCart() async {
    final cartData = json.encode(
      _items.map((key, item) => MapEntry(key, item.toMap())),
    );
    await _prefs.setString(_cartKey, cartData);
  }

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  Future<void> addItem(String productId, String name, double price, String imagePath) async {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          imagePath: existingCartItem.imagePath,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          name: name,
          price: price,
          imagePath: imagePath,
        ),
      );
    }
    await _saveCart();
    notifyListeners();
  }

  Future<void> removeItem(String productId) async {
    _items.remove(productId);
    await _saveCart();
    notifyListeners();
  }

  Future<void> removeSingleItem(String productId) async {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          imagePath: existingCartItem.imagePath,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    await _saveCart();
    notifyListeners();
  }

  Future<void> clear() async {
    _items.clear();
    await _saveCart();
    notifyListeners();
  }
}
