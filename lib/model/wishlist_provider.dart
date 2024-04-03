import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  Color iconColor = Colors.black;
  changeWishlistColor(String docId) async {
    var docRef = await FirebaseFirestore.instance
        .collection("wishlist")
        .doc(docId)
        .get();
    log("docRf==${docRef.data()}");
    if (docRef.data() != null) {
      iconColor = Colors.red;
      log(iconColor.toString());
      notifyListeners();
    } else {
      log(iconColor.toString());
      iconColor = Colors.black;
      notifyListeners();
    }
  }
}
