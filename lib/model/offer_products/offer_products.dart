import 'package:json_annotation/json_annotation.dart';

part 'offer_products.g.dart';

@JsonSerializable()
class OfferProducts {
	int? id;
	int? catid;
	String? productname;
	double? price;
	String? image;
	String? description;

	OfferProducts({
		this.id, 
		this.catid, 
		this.productname, 
		this.price, 
		this.image, 
		this.description, 
	});

	factory OfferProducts.fromJson(Map<String, dynamic> json) {
		return _$OfferProductsFromJson(json);
	}

	Map<String, dynamic> toJson() => _$OfferProductsToJson(this);
}
