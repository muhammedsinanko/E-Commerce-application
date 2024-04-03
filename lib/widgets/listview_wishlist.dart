// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyra_ecommerce/firestore_service/firebase_fun.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

class ListviewWishlist extends StatelessWidget {
  List<QueryDocumentSnapshot<dynamic>> productDetails;
  ListviewWishlist({required this.productDetails, super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: MasonryGridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              right: 10,
              bottom: 10,
            ),
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 13,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(productDetails[index]["imageUrl"]),
                          Text(
                            productDetails[index]["productName"],
                            style: GoogleFonts.manrope(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            productDetails[index]["price"].toString(),
                            style: GoogleFonts.manrope(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.red.shade600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  //add to cart

                                  FirestoreCart().addToCart(
                                      docId: productDetails[index].id,
                                      id: productDetails[index]["id"],
                                      productName: productDetails[index]
                                          ["productName"],
                                      imageUrl: productDetails[index]
                                          ["imageUrl"],
                                      qty: 1,
                                      price: productDetails[index]["price"],
                                      isNavigate: false,
                                      context: context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: const Text(
                                    "Add to bag",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              IconButton(
                                onPressed: () async {
                                  FireStoreWishlist().deleteWishlist(
                                      docId: productDetails[index].id);
                                },
                                icon: const Icon(Icons.close_outlined,
                                    size: 24,
                                    color: Color.fromARGB(221, 0, 0, 0)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: productDetails.length,
      ),
    );
  }
}
