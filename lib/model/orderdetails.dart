import 'package:cyra_ecommerce/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  String? prefsUsername = '';
  @override
  void initState() {
    super.initState();
    getprefsUsername();
  }

  //get username from sharedprf
  getprefsUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefsUsername = prefs.getString('username');
      debugPrint('usernameprfs=$prefsUsername');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      //appbar
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: InkWell(
          onTap: () {
            WebService().getOrderDetails(prefsUsername ?? '');
          },
          child: Text(
            'Order details',
            style: GoogleFonts.poppins(
              color: Colors.black,
            ),
          ),
        ),
      ),

      //body

      body: SafeArea(
        child: FutureBuilder(
            future: WebService().getOrderDetails(prefsUsername ?? ''),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      debugPrint(snapshot.data![index].date.toString());
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ExpansionTile(
                          title: Text(snapshot.data![index].date.toString()),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data![index].paymentmethod,
                                style: GoogleFonts.manrope(
                                    color:
                                        const Color.fromARGB(221, 33, 33, 33)),
                              ),
                              Text(
                                snapshot.data![index].totalamount.toString(),
                                style: GoogleFonts.manrope(color: Colors.white),
                              ),
                            ],
                          ),
                          collapsedIconColor: Colors.black,
                          collapsedTextColor: Colors.black,
                          textColor: Colors.black,
                          children: [
                            ListView.separated(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  //debugPrint(
                                  //    'image=${snapshot.data![index].products[index].image}');
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Card(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      color: Colors.grey.shade100,
                                      child: ListTile(
                                        leading: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            height: double.infinity,
                                            width: 50,
                                            child: Image.network(
                                              WebService().imgUrl +
                                                  snapshot.data![index]
                                                      .products[index].image,
                                              fit: BoxFit.fitHeight,
                                            )),
                                        title: Text(
                                          snapshot.data![index].products[index]
                                              .productname,
                                          style: GoogleFonts.manrope(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        subtitle: Text(
                                          snapshot.data![index].products[index]
                                              .price
                                              .toString(),
                                          style: GoogleFonts.manrope(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red),
                                        ),
                                        trailing: Text(
                                          //'',
                                          '${snapshot.data![index].products[index].quantity}x',
                                          style: GoogleFonts.manrope(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(),
                                itemCount:
                                    snapshot.data![index].products.length)
                          ],
                        ),
                      );
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
