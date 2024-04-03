// To parse this JSON data, do
//
//     final offerProducts = offerProductsFromJson(jsonString);

import 'dart:convert';

List<OfferProducts> offerProductsFromJson(String str) =>
    List<OfferProducts>.from(
        json.decode(str).map((x) => OfferProducts.fromJson(x)));

String offerProductsToJson(List<OfferProducts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OfferProducts {
  int id;
  int catid;
  String productname;
  double price;
  String image;
  String description;

  OfferProducts({
    required this.id,
    required this.catid,
    required this.productname,
    required this.price,
    required this.image,
    required this.description,
  });

  factory OfferProducts.fromJson(Map<String, dynamic> json) => OfferProducts(
        id: json["id"],
        catid: json["catid"],
        productname: json["productname"],
        price: json["price"]?.toDouble(),
        image: json["image"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "catid": catid,
        "productname": productname,
        "price": price,
        "image": image,
        "description": description,
      };
}
