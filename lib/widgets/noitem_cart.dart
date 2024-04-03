// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constants.dart';
import 'bottomsheet_cart.dart';

class NoItemCart extends StatelessWidget {
  AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  NoItemCart({required this.snapshot, super.key});

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
            color: Colors.black,
          ),
        ),
        title: Text(
          'My Cart',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.w500),
        ),
        actions: [
          TextButton(
            onPressed: () {
              //clear cart items
            },
            child: Text(
              'Clear all',
              style: GoogleFonts.poppins(
                  color: const Color.fromARGB(231, 50, 50, 50)),
            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 12)),
        ],
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
      ),
      bottomSheet: BottomSheetCart(snapshot: snapshot),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your cart is empty',
                style: GoogleFonts.manrope(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
