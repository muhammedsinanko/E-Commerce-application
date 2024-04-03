// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyra_ecommerce/firestore_service/firebase_fun.dart';
import 'package:cyra_ecommerce/widgets/bottomsheet_cart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPageSafeArea extends StatelessWidget {
  AsyncSnapshot<QuerySnapshot> snapshot;
  CartPageSafeArea({required this.snapshot, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: BottomSheetCart(
          snapshot: snapshot,
        ),
        backgroundColor: Colors.grey.shade100,
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
                FirestoreCart().deleteAllItems();
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
        body: SafeArea(
            child: Column(
          children: [
            //!listview tems
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                    snapshot.data!.docs[index]["imageUrl"],
                                  ))),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Wrap(
                              direction: Axis.vertical,
                              children: [
                                Text(
                                  snapshot.data!.docs[index]["productName"],
                                  style: GoogleFonts.manrope(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  snapshot.data!.docs[index]["price"]
                                      .toString(),
                                  style: GoogleFonts.manrope(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          height: 40,
                          width: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                //decrement qty
                                onTap: () {
                                  if (snapshot.data!.docs[index]["qty"] != 1) {
                                    FirestoreCart().updateQty(
                                        snapshot.data!.docs[index].id,
                                        snapshot.data!.docs[index]["qty"] - 1);
                                  } else {
                                    //delete item
                                    FirestoreCart().deleteItem(
                                        snapshot.data!.docs[index].id);
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: double.infinity,
                                  width: 20,
                                  //color: Colors.amber,
                                  child: snapshot.data!.docs[index]["qty"] == 1
                                      ? const Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                          size: 19,
                                        )
                                      : Text(
                                          '- ',
                                          style: GoogleFonts.poppins(),
                                        ),
                                ),
                              ),
                              Text(
                                snapshot.data!.docs[index]["qty"].toString(),
                                style: GoogleFonts.manrope(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green),
                              ),
                              InkWell(
                                onTap: () {
                                  FirestoreCart().updateQty(
                                      snapshot.data!.docs[index].id,
                                      snapshot.data!.docs[index]["qty"] + 1);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: double.infinity,
                                  width: 20,
                                  child: Text(
                                    '+',
                                    style: GoogleFonts.poppins(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: snapshot.data!.docs.length,
              ),
            ),
          ],
        )));
  }
}
