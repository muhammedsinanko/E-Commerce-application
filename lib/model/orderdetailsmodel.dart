class OrderdetaiLsModel {
  int id;
  String username;
  dynamic totalamount;
  dynamic paymentmethod;
  DateTime date;
  List<Product> products;

  OrderdetaiLsModel({
    required this.id,
    required this.username,
    required this.totalamount,
    required this.paymentmethod,
    required this.date,
    required this.products,
  });

  factory OrderdetaiLsModel.fromJson(Map<String, dynamic> json) =>
      OrderdetaiLsModel(
        id: json["id"],
        username: json["username"],
        totalamount: json["totalamount"],
        paymentmethod: json["paymentmethod"],
        date: DateTime.parse(json["date"]),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "totalamount": totalamount,
        "paymentmethod": paymentmethod,
        "date": date.toIso8601String(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  String productname;
  dynamic price;
  String image;
  dynamic quantity;

  Product({
    required this.productname,
    required this.price,
    required this.image,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productname: json["productname"],
        price: json["price"],
        image: json["image"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productname": productname,
        "price": price,
        "image": image,
        "quantity": quantity,
      };
}
