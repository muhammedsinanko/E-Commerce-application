import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyra_ecommerce/screen/cartpage.dart';
import 'package:cyra_ecommerce/widgets/listview_wishlist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/constants.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        toolbarHeight: 60,
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Wishlist',
          style: GoogleFonts.manrope(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("wishlist").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data != null) {
              if (snapshot.data!.docs.isNotEmpty) {
                List<QueryDocumentSnapshot<dynamic>> productDetails =
                    snapshot.data!.docs;
                return ListviewWishlist(
                  productDetails: productDetails,
                );
              } else {
                return Center(
                  child: Text(
                    'Your wishlist is empty',
                    style: GoogleFonts.manrope(
                        fontSize: 12, color: Colors.black54),
                  ),
                );
              }
            } else {
              return Center(
                child: Text(
                  'Your wishlist is empty',
                  style:
                      GoogleFonts.manrope(fontSize: 12, color: Colors.black54),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
