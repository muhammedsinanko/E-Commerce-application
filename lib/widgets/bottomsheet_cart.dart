import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../model/cartprovider.dart';
import '../screen/upiindia.dart';

// ignore: must_be_immutable
class BottomSheetCart extends StatelessWidget {
  AsyncSnapshot<QuerySnapshot> snapshot;
  BottomSheetCart({required this.snapshot, super.key});

  @override
  Widget build(BuildContext context) {
    double total = 0;
    for (var element in snapshot.data!.docs) {
      total = total + element["price"] * element["qty"];
    }
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total:',
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Text(
                total.toString(),
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              if (snapshot.data!.docs.isNotEmpty) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return UpiIndiaPaymenyPage(
                    amount: context.read<CartProvider>().totalPriceCart,
                  );

                  //return SharedP();
                }));
              } else {
                showSnackbar(context, "Add items & continue", Colors.red);
              }
            },
            child: Container(
              height: 45,
              width: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  'Checkout',
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
