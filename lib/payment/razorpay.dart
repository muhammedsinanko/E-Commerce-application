//import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:razorpay_flutter/razorpay_flutter.dart';
//import 'package:shared_preferences/shared_preferences.dart';

//class RazorpayPage extends StatefulWidget {
//  const RazorpayPage({super.key});

//  @override
//  State<RazorpayPage> createState() => _RazorpayPageState();
//}

//Razorpay razorpay = Razorpay();

//class _RazorpayPageState extends State<RazorpayPage> {
//  void initState() {
//    super.initState();
//    loadUsername();

//    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handleSuccess);
//    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handleError);
//    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWaller);
//    makePayment(amount: 1, name: username ?? '');
//  }

////to handle success toast
//  handleSuccess(PaymentSuccessResponse response) {
//    Fluttertoast.showToast(
//      msg: 'Payment successfully done ${response.paymentId}',
//      textColor: Colors.green,
//      timeInSecForIosWeb: 4,
//      gravity: ToastGravity.BOTTOM,
//    );

//    //clear all the cart list
//  }

////to make payments
//  void makePayment({required String name, required amount}) {
//    @override
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

////to handle error toast
//  handleError(PaymentFailureResponse response) {
//    Fluttertoast.showToast(
//      msg: 'Payment failed ${response.message}',
//      timeInSecForIosWeb: 4,
//      gravity: ToastGravity.BOTTOM,
//    );
//  }

////to handle external wallet
//  handleExternalWaller(ExternalWalletResponse response) {
//    Fluttertoast.showToast(
//      msg: 'External wallet is ${response.walletName}',
//      timeInSecForIosWeb: 4,
//      gravity: ToastGravity.BOTTOM,
//    );

//    //clear all the cart list
//  }

//  String? username;
//  Future<void> loadUsername() async {
//    final sharedPref = await SharedPreferences.getInstance();
//    setState(() {
//      username = sharedPref.getString('username');
//    });
//  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold();
//  }
//}
