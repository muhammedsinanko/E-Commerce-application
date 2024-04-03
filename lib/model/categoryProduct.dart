import 'package:cyra_ecommerce/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screen/productpage.dart';

// ignore: must_be_immutable
class CategoryProductPage extends StatelessWidget {
  String catName;
  int catid;
  CategoryProductPage({super.key, required this.catName, required this.catid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          catName,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: FutureBuilder(
          future: WebService().getCategoryProducts(catid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MasonryGridView.builder(
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final data = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      bottom: 10,
                    ),
                    child: InkWell(
                      onTap: () {
                        debugPrint("clicked");
                        final data = snapshot.data![index];
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => ProductPage(
                                  productId: data.id!,
                                  productDes: data.description!,
                                  productTitle: data.productname!,
                                  productPrice: data.price!,
                                  productimage:
                                      WebService().imgUrl + data.image!,
                                ))));
                      },
                      child: Container(
                        width: double.infinity,
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
                                WebService().imgUrl + data.image!,
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
                                    snapshot.data![index].productname!,
                                    style: GoogleFonts.manrope(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data![index].price!.toString(),
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
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
