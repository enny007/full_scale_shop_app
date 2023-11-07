// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WishListModel {
  final String id;
  final String productId;
  WishListModel({
    required this.id,
    required this.productId,
  });

  WishListModel copyWith({
    String? id,
    String? productId,
  }) {
    return WishListModel(
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

  factory WishListModel.fromMap(Map<String, dynamic> map) {
    return WishListModel(
      id: map['id'] as String,
      productId: map['productId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WishListModel.fromJson(String source) =>
      WishListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WishListModel(id: $id, productId: $productId)';

  @override
  bool operator ==(covariant WishListModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.productId == productId;
  }

  @override
  int get hashCode => id.hashCode ^ productId.hashCode;
}
