// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upi_india/upi_india.dart';

class UpiIndiaPaymenyPage extends StatefulWidget {
  double amount;
  UpiIndiaPaymenyPage({super.key, required this.amount});

  @override
  State<UpiIndiaPaymenyPage> createState() => _UpiIndiaPaymenyPageState();
}

class _UpiIndiaPaymenyPageState extends State<UpiIndiaPaymenyPage> {
  UpiIndia upiIndia = UpiIndia();

  //to fetch upi apps
  Future<void> fetchUpiApps() async {
    try {
      var value = await upiIndia.getAllUpiApps(mandatoryTransactionId: false);
      setState(() {
        apps = value;
      });
      log("apps==$apps");
    } catch (e) {
      apps = [];
      log('An error occurred: $e');
    }
  }

  //to lauch upi apps
  lauchApp(UpiApp app) {
    upiIndia.startTransaction(
        app: app,
        currency: "INR",
        amount: widget.amount,
        receiverUpiId: "9745725504@axl",
        receiverName: "Muhammed Sinan",
        transactionRefId: "");
  }

  List<UpiApp>? apps;
  @override
  void initState() {
    super.initState();
    fetchUpiApps();
  }

  @override
  Widget build(BuildContext context) {
    log("amount:${widget.amount}");
    return Scaffold(
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
          'Payment',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            displayUpiApps(),
          ],
        ),
      ),
    );
  }

  Widget displayUpiApps() {
    if (apps == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (apps!.isEmpty) {
      return const Center(
        child: Text("No app installed on this device"),
      );
    } else {
      return Wrap(
        children: apps!.map(
          (app) {
            lauchApp(app);
            return InkWell(
              onTap: () {
                lauchApp(app);
              },
              child: Column(
                children: [
                  Image.memory(app.icon),
                  Text(app.name),
                ],
              ),
            );
          },
        ).toList(),
      );
    }
  }
}
