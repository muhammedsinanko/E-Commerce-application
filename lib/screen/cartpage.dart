import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyra_ecommerce/widgets/cartpage_safearea.dart';
import 'package:cyra_ecommerce/widgets/noitem_cart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("cart").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data != null) {
            if (snapshot.data!.docs.isNotEmpty) {
              return CartPageSafeArea(
                snapshot: snapshot,
              );
            } else {
              return NoItemCart(snapshot: snapshot);
            }
          } else {
            return Center(
                child: Text(
              'Your cart is empty',
              style: GoogleFonts.manrope(fontSize: 12, color: Colors.black54),
            ));
          }
        });
  }
}
