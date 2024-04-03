import 'package:cyra_ecommerce/screen/cartpage.dart';
import 'package:cyra_ecommerce/model/categoryProduct.dart';
import 'package:cyra_ecommerce/screen/productpage.dart';
import 'package:cyra_ecommerce/screen/searchbar_page.dart';
import 'package:cyra_ecommerce/screen/wishlist_page.dart';
import 'package:cyra_ecommerce/webservice/webservice.dart';
import 'package:cyra_ecommerce/widgets/drawer.dart';
import 'package:cyra_ecommerce/widgets/search_bar_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/offer_products/offer_products.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<OfferProducts> allProducts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 60,
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'E Commerce',
          style: GoogleFonts.manrope(
            color: Colors.white,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const WishlistPage()));
            },
            child: const Icon(
              Icons.favorite_border_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CartPage()));
            },
            child: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      drawer: const DrawerHome(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SearchBarPage(allProducts: allProducts)));
                },
                child: const SearchBarHome(),
              ),
              Text(
                'Category',
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              FutureBuilder(
                  future: WebService().getAllCategoryTitile(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: 90,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                right: 15,
                                top: 18,
                                bottom: 18,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CategoryProductPage(
                                            catName:
                                                snapshot.data![index].category,
                                            catid: snapshot.data![index].id,
                                          )));

                                  //WebService().getCategoryProducts(
                                  //    snapshot.data![index].id);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  height: 60,
                                  //width: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Center(
                                    child: Text(
                                      snapshot.data![index].category,
                                      style: GoogleFonts.manrope(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
              Text(
                'All products',
                style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: FutureBuilder(
                  future: WebService().getOfferProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      allProducts = snapshot.data!;
                      return MasonryGridView.builder(
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
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
                                      WebService().imgUrl +
                                          snapshot.data![index].image!,
                                      //color: Colors.amber,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 13,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![index].productname!,
                                          style: GoogleFonts.manrope(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data![index].price!
                                              .toString(),
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
                        itemCount: snapshot.data!.length,
                      );
                    } else {
                      return const Align(
                          alignment: Alignment.topCenter,
                          child: CircularProgressIndicator());
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
