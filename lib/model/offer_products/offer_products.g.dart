// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferProducts _$OfferProductsFromJson(Map<String, dynamic> json) =>
    OfferProducts(
      id: json['id'] as int?,
      catid: json['catid'] as int?,
      productname: json['productname'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      image: json['image'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$OfferProductsToJson(OfferProducts instance) =>
    <String, dynamic>{
      'id': instance.id,
      'catid': instance.catid,
      'productname': instance.productname,
      'price': instance.price,
      'image': instance.image,
      'description': instance.description,
    };
