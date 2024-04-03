import 'dart:convert';

import 'dart:math';

import 'package:cyra_ecommerce/model/offer_products/offer_products.dart';
import 'package:cyra_ecommerce/model/orderdetailsmodel.dart';
import 'package:flutter/material.dart';

import '../model/cartmodel.dart';
import '../model/category_model.dart';
import 'package:http/http.dart' as http;

import '../model/usermodel.dart';

//final dio = Dio();

class WebService {
  final imgUrl = 'http://bootcamp.cyralearnings.com/products/';
  final mainUrl = '';

  Future<List<CategoryModel>?> getAllCategoryTitile() async {
    try {
      final response = await http.get(
          Uri.parse('http://bootcamp.cyralearnings.com/getcategories.php'));
      if (response.statusCode == 200) {
        final resultAsJson =
            json.decode(response.body).cast<Map<String, dynamic>>();
        return resultAsJson
            .map<CategoryModel>((json) => CategoryModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load Category');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<OfferProducts>?> getOfferProducts() async {
    final response = await http.get(
        Uri.parse('http://bootcamp.cyralearnings.com/view_offerproducts.php'));
    if (response.statusCode == 200) {
      log(response.statusCode);
      final resultAsJson =
          json.decode(response.body).cast<Map<String, dynamic>>();
      return resultAsJson
          .map<OfferProducts>((json) => OfferProducts.fromJson(json))
          .toList();
    } else {
      return null;
    }
  }

  Future<List<OfferProducts>?> getCategoryProducts(int catid) async {
    final response = await http.post(
        Uri.parse(
            'http://bootcamp.cyralearnings.com/get_category_products.php'),
        body: {'catid': catid.toString()});

    print(response.body.toString());
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<OfferProducts>((json) => OfferProducts.fromJson(json))
          .toList();
    } else {
      return null;
    }
  }

  Future<UserModel?> getUserDetails(String usernameprfs) async {
    final response = await http.post(
        Uri.parse('http://bootcamp.cyralearnings.com/get_user.php'),
        body: {'username': usernameprfs});
    if (response.statusCode == 200) {
      final jsonDecoded = jsonDecode(response.body);
      debugPrint('json= $jsonDecoded');
      return UserModel.fromJson(jsonDecoded);
    } else {
      return null;
    }
  }

  Future orderPlace({
    required List<CartModel> cartList,
    required String amount,
    required String paymentmethod,
    required String date,
    required String name,
    required String address,
    required String phone,
  }) async {
    String listAsJson = jsonEncode(cartList);
    debugPrint('amount=$amount');
    debugPrint('paymentmethod=$paymentmethod');
    debugPrint('date=$date');
    debugPrint('name=$name');
    debugPrint('address=$address');
    debugPrint('phone=$phone');
    debugPrint('json encoded= $listAsJson');
    debugPrint('qty${cartList.length}');
    final response = await http
        .post(Uri.parse("https://bootcamp.cyralearnings.com/order.php"), body: {
      "username": name,
      "amount": amount,
      "paymentmethod": paymentmethod,
      "date": date,
      "quantity": cartList.length.toString(),
      "cart": listAsJson,
      "name": name,
      "address": address,
      "phone": phone,
    });

    if (response.statusCode == 200) {
      //debugPrint('response body: ${response.body}');
      if (response.body.contains("Success")) {
        debugPrint('response body: ${response.body}');
      } else {
        throw Exception();
      }
    }
  }

  Future<List<OrderdetaiLsModel>?> getOrderDetails(String username) async {
    try {
      debugPrint("usernaem===$username");
      final response = await http.post(
          Uri.parse("http://bootcamp.cyralearnings.com/get_orderdetails.php"),
          body: {"username": username.toString()});
      if (response.statusCode == 200) {
        if (response.body.contains("Success")) debugPrint(response.body);
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

        return parsed
            .map<OrderdetaiLsModel>((json) => OrderdetaiLsModel.fromJson(json))
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
