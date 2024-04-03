import 'dart:math';

import 'package:flutter/material.dart';

import 'cartmodel.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> cartList = [];

  List<CartModel> get getCartList {
    return cartList;
  }

  //we need to add list to cartpage from details page

  void addToCartList(
      {required int id,
      required String title,
      required double price,
      required int qty,
      required String imageUrl}) {
    final cartModel = CartModel(
        id: id, productname: title, price: price, image: imageUrl, qty: 1);

//add product to cart
    cartList.add(cartModel);
    notifyListeners();
  }

//Increment quantity
  void qtyIncrement(CartModel product) {
    log(cartList[0].qty);
    product.qtyIncrement();
    log(cartList[0].qty);
    notifyListeners();
  }

  //Decrement quantity
  void qtyDecrement(CartModel product) {
    log(cartList[0].qty);
    product.qtyDecrement();
    log(cartList[0].qty);
    notifyListeners();
  }

//delete product
  void deleteProduct(CartModel product) {
    cartList.remove(product);
    notifyListeners();
  }

//clear all product
  void clearAllList() {
    cartList.clear();
    notifyListeners();
  }

  //double? cartTotal;
  double get totalPriceCart {
    return totalPrice();
  }

  double totalPrice() {
    double cartTotal = 00.0;
    for (var item in cartList) {
      cartTotal = cartTotal + (item.price * item.qty);
    }
    return cartTotal;
  }
}
