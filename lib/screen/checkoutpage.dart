//import 'dart:math';

//import 'package:cyra_ecommerce/webservice/webservice.dart';

//import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:provider/provider.dart';
//import 'package:razorpay_flutter/razorpay_flutter.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'model/cartprovider.dart';

//// ignore: must_be_immutable
//class CheckoutPage extends StatefulWidget { 
//  List<CartModel> cartList;
//  CheckoutPage({
//    super.key,
//    required this.cartList,
//  });

//  @override
//  State<CheckoutPage> createState() => _CheckoutPageState();
//}

//String? _phone;
//String? address;

//Razorpay razorpay = Razorpay();

//class _CheckoutPageState extends State<CheckoutPage> {
//  @override
//  void initState() {
//    super.initState();
//    loadUsername();

//    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handleSuccess);
//    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handleError);
//    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWaller);
//  }

//  //to handle success toast
//  handleSuccess(PaymentSuccessResponse response) {
//    Fluttertoast.showToast(
//      msg: 'Payment successfully done ${response.paymentId}',
//      textColor: Colors.green,
//      timeInSecForIosWeb: 4,
//      gravity: ToastGravity.BOTTOM,
//    );

//    //clear all the cart list
//  }

//  //to handle error toast
//  handleError(PaymentFailureResponse response) {
//    Fluttertoast.showToast(
//      msg: 'Payment failed ${response.message}',
//      timeInSecForIosWeb: 4,
//      gravity: ToastGravity.BOTTOM,
//    );
//  }

////to handle external walle
//  handleExternalWaller(ExternalWalletResponse response) {
//    Fluttertoast.showToast(
//      msg: 'External wallet is ${response.walletName}',
//      timeInSecForIosWeb: 4,
//      gravity: ToastGravity.BOTTOM,
//    );

//    //clear all the cart list
//  }

////to make the payment
//  void makePayment({required String name, required amount}) async {
//    var options = {
//      "key": "rzp_test_iM7kLEGe7QD0gc",
//      "amount": amount * 100,
//      "name": name,
//      "currency": "INR",
//      "description": " ",
//      "external": {
//        "wallets": ["paytm"]
//      }
//    };
//    try {
//      razorpay.open(options);
//    } catch (e) {
//      Exception();
//      debugPrint('something went wrong while paying');
//    }
//  }

//  String? username;
//  Future<void> loadUsername() async {
//    final sharedPref = await SharedPreferences.getInstance();
//    setState(() {
//      username = sharedPref.getString('username');
//    });
//  }

//  String _paymentType = 'Cash on delivery';
//  int selectedRadioValue = 1;
//  @override
//  Widget build(BuildContext context) {
//    return Consumer<CartProvider>(
//      builder: (context, value, child) => Scaffold(
//        bottomSheet: InkWell(
//          onTap: () {
//            if (_paymentType == 'Pay now') {
//              debugPrint('checkout pay type$_paymentType');
//              makePayment(
//                  name: username!,
//                  amount: context.read<CartProvider>().totalPrice());
//              WebService().orderPlace(
//                cartList: widget.cartList,
//                amount: context.read<CartProvider>().totalPriceCart.toString(),
//                paymentmethod: _paymentType,
//                date: DateTime.now().toString(),
//                name: username ?? '',
//                address: address!,
//                phone: _phone.toString(),
//              );
//            } else if (_paymentType == 'Cash on delivery') {
//              debugPrint('checkout pay type$_paymentType');
//              WebService().orderPlace(
//                cartList: widget.cartList,
//                amount: context.read<CartProvider>().totalPriceCart.toString(),
//                paymentmethod: _paymentType,
//                date: DateTime.now().toString(),
//                name: username ?? '',
//                address: address!,
//                phone: _phone.toString(),
//              );
//              value.clearAllList();
//              debugPrint(context.read<CartProvider>().cartList.toString());
//            }
//          },
//          child: Container(
//            alignment: Alignment.center,
//            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//            height: 45,
//            width: MediaQuery.of(context).size.width,
//            decoration: BoxDecoration(
//                color: Colors.black, borderRadius: BorderRadius.circular(15)),
//            child: Text(
//              'Checkout',
//              style: GoogleFonts.poppins(
//                  fontSize: 16,
//                  fontWeight: FontWeight.w400,
//                  color: Colors.white),
//            ),
//          ),
//        ),
//        backgroundColor: Colors.grey.shade100,
//        appBar: AppBar(
//          leading: IconButton(
//            onPressed: () {
//              Navigator.of(context).pop();
//            },
//            icon: const Icon(
//              Icons.arrow_back,
//              color: Colors.black,
//            ),
//          ),
//          title: Text(
//            'Checkout',
//            style: GoogleFonts.poppins(
//                color: Colors.black, fontWeight: FontWeight.w500),
//          ),
//          backgroundColor: Colors.grey.shade100,
//          elevation: 0,
//        ),
//        body: Column(
//          children: [
//            Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 20),
//              child: SizedBox(
//                width: MediaQuery.of(context).size.width,
//                child: FutureBuilder(
//                    future: WebService().getUserDetails(username ?? ''),
//                    builder: (context, snapshot) {
//                      if (snapshot.hasData) {
//                        _phone = snapshot.data!.phone;
//                        address = snapshot.data!.address;
//                        return Card(
//                          shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(15)),
//                          color: Colors.white,
//                          child: Padding(
//                            padding: const EdgeInsets.symmetric(
//                                horizontal: 12, vertical: 12),
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: [
//                                Row(
//                                  children: [
//                                    Text(
//                                      'Name : ',
//                                      style: GoogleFonts.firaSans(
//                                        fontSize: 14,
//                                        fontWeight: FontWeight.w700,
//                                      ),
//                                    ),
//                                    Text(
//                                      snapshot.data!.username,
//                                      style: GoogleFonts.firaSans(
//                                        fontSize: 14,
//                                        fontWeight: FontWeight.w500,
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                                const SizedBox(
//                                  height: 8,
//                                ),
//                                Row(
//                                  children: [
//                                    Text(
//                                      'Phone : ',
//                                      style: GoogleFonts.firaSans(
//                                        fontSize: 14,
//                                        fontWeight: FontWeight.w700,
//                                      ),
//                                    ),
//                                    Text(
//                                      snapshot.data!.phone.toString(),
//                                      style: GoogleFonts.firaSans(
//                                        fontSize: 14,
//                                        fontWeight: FontWeight.w500,
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                                const SizedBox(
//                                  height: 8,
//                                ),
//                                Row(
//                                  children: [
//                                    Text(
//                                      'Address : ',
//                                      style: GoogleFonts.firaSans(
//                                        fontSize: 14,
//                                        fontWeight: FontWeight.w700,
//                                      ),
//                                    ),
//                                    Text(
//                                      snapshot.data!.address,
//                                      style: GoogleFonts.firaSans(
//                                        fontSize: 14,
//                                        fontWeight: FontWeight.w500,
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ],
//                            ),
//                          ),
//                        );
//                      } else {
//                        return const Center(child: CircularProgressIndicator());
//                      }
//                    }),
//              ),
//            ),
//            const SizedBox(
//              height: 12,
//            ),
//            RadioListTile(
//              activeColor: Colors.black,
//              value: 1,
//              groupValue: selectedRadioValue,
//              onChanged: (int? value) {
//                setState(() {
//                  selectedRadioValue = value!;
//                  _paymentType = 'Cash on delivery';
//                  debugPrint(_paymentType);
//                  log(selectedRadioValue);
//                });
//              },
//              title: Text(
//                'Cash on delivery',
//                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//              ),
//            ),
//            RadioListTile(
//              activeColor: Colors.black,
//              value: 2,
//              groupValue: selectedRadioValue,
//              onChanged: (int? value) {
//                setState(
//                  () {
//                    selectedRadioValue = value!;
//                    _paymentType = 'Pay now';
//                    debugPrint(_paymentType);
//                    log(selectedRadioValue);
//                  },
//                );
//              },
//              title: Text(
//                'Pay now',
//                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}
