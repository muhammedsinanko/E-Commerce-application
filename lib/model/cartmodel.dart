class CartModel {
  int id;
  String productname;
  double price;
  String image;
  int qty = 1;

  CartModel(
      {required this.id,
      required this.productname,
      required this.price,
      required this.image,
      required this.qty});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        productname: json["productname"],
        price: json["price"],
        image: json["image"],
        qty: json["qty"],
      );

  void qtyIncrement() {
    if (qty >= 1) {
      qty = qty + 1;
    }
  }

  void qtyDecrement() {
    qty = qty - 1;
  }

  int get quantity {
    return qty;
  }

  Map<String, dynamic> toJson() => {
        "id": id.toString(),
        "productname": productname.toString(),
        "price": price.toString(),
        "qty": qty.toString()
      };
}
