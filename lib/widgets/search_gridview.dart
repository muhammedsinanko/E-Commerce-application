// ignore_for_file: must_be_immutable

import 'package:cyra_ecommerce/model/offer_products/offer_products.dart';
import 'package:cyra_ecommerce/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screen/productpage.dart';

class SearchPageGridview extends StatelessWidget {
  List<OfferProducts> productList;
  SearchPageGridview({required this.productList, super.key});
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            final data = productList[index];
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => ProductPage(
                      productId: data.id!,
                      productDes: data.description!,
                      productTitle: data.productname!,
                      productPrice: data.price!,
                      productimage: WebService().imgUrl + data.image!,
                    ))));
          },
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
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.network(
                    WebService().imgUrl + productList[index].image!,
                    //color: Colors.amber,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 13,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productList[index].productname!,
                        style: GoogleFonts.manrope(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        productList[index].price!.toString(),
                        style: GoogleFonts.manrope(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.red.shade600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: productList.length,
    );
  }
}
