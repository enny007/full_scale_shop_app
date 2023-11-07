// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  final String id;
  final String title;
  final String imageUrl;
  final String productCategoryName;
  final double price;
  final double salePrice;
  final bool isOnSale;
  final bool isPiece;
  ProductModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.productCategoryName,
    required this.price,
    required this.salePrice,
    required this.isOnSale,
    required this.isPiece,
  });

  factory ProductModel.initial() {
    return ProductModel(
      id: '',
      title: '',
      imageUrl: '',
      productCategoryName: '',
      price: 0,
      salePrice: 0,
      isOnSale: false,
      isPiece: false,
    );
  }
  
  ProductModel copyWith({
    String? id,
    String? title,
    String? imageUrl,
    String? productCategoryName,
    double? price,
    double? salePrice,
    bool? isOnSale,
    bool? isPiece,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      productCategoryName: productCategoryName ?? this.productCategoryName,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      isOnSale: isOnSale ?? this.isOnSale,
      isPiece: isPiece ?? this.isPiece,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'productCategoryName': productCategoryName,
      'price': price,
      'salePrice': salePrice,
      'isOnSale': isOnSale,
      'isPiece': isPiece,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
      productCategoryName: map['productCategoryName'] as String,
      price: map['price'] as double,
      salePrice: map['salePrice'] as double,
      isOnSale: map['isOnSale'] as bool,
      isPiece: map['isPiece'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, imageUrl: $imageUrl, productCategoryName: $productCategoryName, price: $price, salePrice: $salePrice, isOnSale: $isOnSale, isPiece: $isPiece)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.imageUrl == imageUrl &&
        other.productCategoryName == productCategoryName &&
        other.price == price &&
        other.salePrice == salePrice &&
        other.isOnSale == isOnSale &&
        other.isPiece == isPiece;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        imageUrl.hashCode ^
        productCategoryName.hashCode ^
        price.hashCode ^
        salePrice.hashCode ^
        isOnSale.hashCode ^
        isPiece.hashCode;
  }
}
