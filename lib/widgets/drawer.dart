import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen/cartpage.dart';
import '../screen/login_page.dart';
import '../model/orderdetails.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({super.key});

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> cartDocList = [];
  getCartItem() async {
    FirebaseFirestore.instance
        .collection("cart")
        .get()
        .then((value) => setState(() {
              cartDocList = value.docs;
            }));
  }

  @override
  void initState() {
    getCartItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("cartitem:$cartDocList");
    return SafeArea(
      child: Drawer(
          surfaceTintColor: Colors.white,
          shadowColor: Colors.white,
          backgroundColor: Colors.grey.shade100,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(children: [
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: Text('Home',
                        style: GoogleFonts.manrope(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Badge(
                      alignment: Alignment.topRight,
                      smallSize: 12,
                      isLabelVisible: cartDocList.isEmpty ? false : true,
                      label: Text(cartDocList.length.toString()),
                      child: const Icon(Icons.badge),
                    ),
                    title: Text('Cart',
                        style: GoogleFonts.manrope(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const CartPage();
                      }));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: Text('Order details',
                        style: GoogleFonts.manrope(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const OrderDetailsPage())));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: Text('Log out',
                        style: GoogleFonts.manrope(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: ((context) => AlertDialog(
                                title: Text(
                                  'Log out',
                                  style: GoogleFonts.poppins(),
                                ),
                                actions: [
                                  IconButton(
                                      onPressed: () async {
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        prefs.setBool('isLoggedin', false);
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginPage()),
                                                (route) => false);
                                        //context
                                        //    .read<CartProvider>()
                                        //    .cartList
                                        //    .clear();
                                      },
                                      icon: const Icon(
                                        Icons.logout,
                                        color: Colors.redAccent,
                                      ))
                                ],
                              )));
                    },
                  ),
                ]),
              )
            ],
          )),
    );
  }
}
