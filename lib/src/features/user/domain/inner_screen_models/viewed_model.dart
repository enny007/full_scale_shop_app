// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ViewedProductModel {
  final String id;
  final String productId;
  ViewedProductModel({
    required this.id,
    required this.productId,
  });


  ViewedProductModel copyWith({
    String? id,
    String? productId,
  }) {
    return ViewedProductModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
    };
  }

  factory ViewedProductModel.fromMap(Map<String, dynamic> map) {
    return ViewedProductModel(
      id: map['id'] as String,
      productId: map['productId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ViewedProductModel.fromJson(String source) => ViewedProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ViewedProductModel(id: $id, productId: $productId)';

  @override
  bool operator ==(covariant ViewedProductModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.productId == productId;
  }

  @override
  int get hashCode => id.hashCode ^ productId.hashCode;
}
