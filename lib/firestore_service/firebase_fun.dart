import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyra_ecommerce/screen/cartpage.dart';
import 'package:cyra_ecommerce/constants/constants.dart';
import 'package:flutter/material.dart';

class FireStoreWishlist {
  var collRef = FirebaseFirestore.instance.collection("wishlist");

// add wishlisted item
  addWishlist(
      {required String docId,
      required int id,
      required String productName,
      required imageUrl,
      required double price,
      required context}) async {
    Map<String, dynamic> data = {
      "id": id,
      "productName": productName,
      "imageUrl": imageUrl,
      "price": price,
      "isAdded": true,
      "time": Timestamp.now()
    };
    try {
      var docRef = await collRef.doc(docId).get();
      log(docRef.toString());
      if (docRef.data() == null) {
        collRef.doc(docId).set(data);
        log("added");
        return docRef.data();
      } else {
        collRef.doc(docId).delete();
        log("del");
        return docRef.data();
      }
    } catch (e) {
      showSnackbar(
        context,
        e.toString(),
        Colors.greenAccent,
      );
      log("error is: $e");
    }
  }

  //delete wishlit form firebse
  deleteWishlist({required docId}) async {
    await collRef.doc(docId).delete();
  }

//delete wishlit form firebse
  Future<QuerySnapshot<Map<String, dynamic>>?> getAllWishlist() async {
    try {
      QuerySnapshot<Map<String, dynamic>> allDocs = await collRef.get();
      return allDocs;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}

class FirestoreCart {
  var collRef = FirebaseFirestore.instance.collection("cart");

// add to cart
  addToCart(
      {required String docId,
      required int id,
      required String productName,
      required imageUrl,
      required int qty,
      required double price,
      required bool isNavigate,
      required context}) async {
    Map<String, dynamic> data = {
      "id": id,
      "productName": productName,
      "imageUrl": imageUrl,
      "price": price,
      "qty": 1,
      "time": Timestamp.now()
    };
    try {
      var docRef = await collRef.doc(docId).get();
      log(docRef.toString());
      if (docRef.data() == null) {
        collRef.doc(docId).set(data);
        log("added");
        isNavigate
            ? Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const CartPage()))
            : showSnackbar(
                context,
                "Added to cart",
                Colors.green,
              );
        return docRef.data();
      } else {
        showSnackbar(
            context, "Item is already in the cart", Colors.greenAccent);
      }
    } catch (e) {
      showSnackbar(
        context,
        e.toString(),
        Colors.red,
      );
      log("error is: $e");
    }
  }

//get all cart item
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getAllCartItem() async {
    QuerySnapshot<Map<String, dynamic>> allCartItem = await collRef.get();
    log("item===${allCartItem.docs}");
    return allCartItem.docs;
  }

//update qty
  updateQty(String docId, int qty) async {
    Map<String, dynamic> data = {"qty": qty};
    await collRef.doc(docId).update(data);
  }

//delete one item
  deleteItem(
    String docId,
  ) async {
    await collRef.doc(docId).delete();
  }

//delete all items
  deleteAllItems() async {
    var allDocs = await collRef.get();
    for (var element in allDocs.docs) {
      element.reference.delete();
    }
  }
}
