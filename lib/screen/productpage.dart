import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cyra_ecommerce/firestore_service/firebase_fun.dart';
import 'package:cyra_ecommerce/model/cartprovider.dart';
import 'package:cyra_ecommerce/model/wishlist_provider.dart';
import 'package:cyra_ecommerce/screen/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductPage extends StatefulWidget {
  int productId;
  String productimage;
  String productTitle;
  double productPrice;
  String productDes;
  ProductPage(
      {super.key,
      required this.productId,
      required this.productimage,
      required this.productTitle,
      required this.productPrice,
      required this.productDes});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  //@override
  checkWishlist() async {
    var docRef = await FirebaseFirestore.instance
        .collection("wishlist")
        .doc(widget.productId.toString() + widget.productTitle)
        .get();
    if (mounted) {
      setState(() {
        if (docRef.data() != null) {
          isWishlisted = true;
        } else {
          isWishlisted = false;
        }
      });
    }

    log("isInit:$isWishlisted");
  }

  //List<QueryDocumentSnapshot<Map<dynamic, dynamic>>> cartDocsList = [];
  getCartItem() async {
    //cartDocsList = await FirestoreCart().getAllCartItem();
  }

  bool isWishlisted = false;
  @override
  void initState() {
    checkWishlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String docId = widget.productId.toString() + widget.productTitle;
    log("id+++${widget.productId}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product details'),
        actions: [
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const WishlistPage()));
                  },
                  icon: const Icon(
                    Icons.favorite_outline_rounded,
                    size: 26,
                  )),
            ],
          ),
          const SizedBox(
            width: 7,
          )
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<CartProvider>(
          builder: (context, value, child) => Row(
            children: [
              Consumer<WishlistProvider>(
                builder: (context, wishlistProvider, child) => IconButton(
                  onPressed: () async {
                    addToWishlist(docId);
                  },
                  icon: Icon(Icons.favorite_outline_rounded,
                      size: 29,
                      color: isWishlisted == true ? Colors.red : Colors.black),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              InkWell(
                onTap: () {
                  addToCart(value, docId);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 45,
                  width: MediaQuery.of(context).size.width / 1.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black,
                  ),
                  child: Text(
                    'Add to cart',
                    style:
                        GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: Center(
                  child: Image.network(widget.productimage),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    left: 20,
                    right: 20,
                    bottom: 0,
                  ),
                  child: Column(
                    //mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productTitle,
                        style: GoogleFonts.manrope(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: const Color.fromARGB(255, 78, 78, 78),
                        ),
                      ),
                      Text(
                        'Rs ${widget.productPrice}',
                        style: GoogleFonts.manrope(
                            color: Colors.red, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.productDes,
                        style: GoogleFonts.manrope(
                          color: Colors.black,
                          letterSpacing: 0.7,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //add to wishlist
  addToWishlist(
    String docId,
  ) async {
    FireStoreWishlist().addWishlist(
        id: widget.productId,
        docId: docId,
        productName: widget.productTitle,
        price: widget.productPrice,
        imageUrl: widget.productimage,
        context: context);
    await FirebaseFirestore.instance.collection("wishlist").doc(docId).get();
    setState(() {
      isWishlisted = !isWishlisted;
    });
    log("isFu$isWishlisted");
    WishlistProvider().changeWishlistColor(docId);
  }

//add to Cart
  addToCart(CartProvider value, String docId) {
    FirestoreCart().addToCart(
      docId: docId,
      id: widget.productId,
      productName: widget.productTitle,
      imageUrl: widget.productimage,
      qty: 1,
      price: widget.productPrice,
      isNavigate: true,
      context: context,
    );
  }
}
