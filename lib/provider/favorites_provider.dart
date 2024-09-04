import 'dart:convert';
import 'package:asyltas/models/product.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider with ChangeNotifier {
  List<ProductModel> _items = [];

  List<ProductModel> get items => _items;

  FavoritesProvider() {
    _loadCart();
  }

  void addItem(ProductModel product) {
    _items.add(product);
    _saveCart();
    notifyListeners();
  }

  void removeItem(ProductModel product) {
    _items.removeWhere((item) => item.id == product.id);
    _saveCart();
    notifyListeners();
  }

  void incrementCount(ProductModel product) {
    final existingProduct = _items.firstWhere(
      (item) => item.id == product.id,
      orElse: () => ProductModel(
        product.id,
        product.name,
        product.images,
        product.category_id,
        product.category_name,
        product.description,
        product.numberLeft,
        product.price,
        1, // Default count to 1 if creating a new item
      ),
    );

    if (existingProduct.id != null) {
      existingProduct.count = (existingProduct.count ?? 1) + 1;
      _saveCart();
      notifyListeners();
    }
  }

  void decrementCount(ProductModel product) {
    final existingProduct = _items.firstWhere(
      (item) => item.id == product.id,
      orElse: () => ProductModel(
        product.id,
        product.name,
        product.images,
        product.category_id,
        product.category_name,
        product.description,
        product.numberLeft,
        product.price,
        1, // Default count to 1 if creating a new item
      ),
    );

    if (existingProduct.id != null) {
      if ((existingProduct.count ?? 1) > 1) {
        existingProduct.count = (existingProduct.count ?? 1) - 1;
      } else {
        _items.removeWhere((item) => item.id == product.id);
      }
      _saveCart();
      notifyListeners();
    }
  }

  int get totalItems => _items.length;

  int get totalPrice {
    return _items.fold(
        0, (sum, item) => sum + (item.price ?? 0) * (item.count ?? 1));
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('favorites');
    if (cartData != null) {
      final List<dynamic> jsonList = json.decode(cartData);
      _items = jsonList.map((json) => ProductModel.fromJson(json)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _items.map((item) => item.toJson()).toList();
    final cartData = json.encode(jsonList);
    prefs.setString('favorites', cartData);
  }
}
