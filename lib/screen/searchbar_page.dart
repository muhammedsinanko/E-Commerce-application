// ignore_for_file: must_be_immutable
import 'dart:developer';
import 'package:cyra_ecommerce/constants/constants.dart';
import 'package:cyra_ecommerce/widgets/search_gridview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/offer_products/offer_products.dart';

class SearchBarPage extends StatefulWidget {
  List<OfferProducts> allProducts;
  SearchBarPage({super.key, required this.allProducts});

  @override
  State<SearchBarPage> createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  List<OfferProducts> productList = [];
  @override
  void initState() {
    productList = widget.allProducts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backroundColor,
      appBar: AppBar(
        leading: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios)),
          ],
        ),
        backgroundColor: backroundColor,
        title: SizedBox(
          height: 30,
          child: TextFormField(
            onChanged: (value) {
              onSearch(
                value,
              );
            },
            decoration: InputDecoration(
              hintText: "Search for products",
              hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SearchPageGridview(
              productList: productList,
            )),
      ),
    );
  }

  onSearch(
    String? value,
  ) {
    if (value != null && value.isNotEmpty) {
      log(value);
      log("value is= $value");
      var filteredProductList = widget.allProducts
          .where((element) => element.productname!.contains(value));
      if (filteredProductList.isEmpty) {
        log("no filtered");
      }
      setState(() {
        productList = filteredProductList.toList();
      });
      log("productList$productList");
    } else {
      log("empty value");
      log("full list$productList");
      setState(() {
        productList = widget.allProducts;
      });
    }
  }
}
