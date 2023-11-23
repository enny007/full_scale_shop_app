// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String orderId;
  final String userId;
  final String productId;
  final String userName;
  final String price;
  final String imageUrl;
  final String quantity;
  final Timestamp orderDate;
  OrderModel({
    required this.orderId,
    required this.userId,
    required this.productId,
    required this.userName,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.orderDate,
  });

  OrderModel copyWith({
    String? orderId,
    String? userId,
    String? productId,
    String? userName,
    String? price,
    String? imageUrl,
    String? quantity,
    Timestamp? orderDate,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      userName: userName ?? this.userName,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      orderDate: orderDate ?? this.orderDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'userId': userId,
      'productId': productId,
      'userName': userName,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'orderDate': orderDate,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] as String,
      userId: map['userId'] as String,
      productId: map['productId'] as String,
      userName: map['userName'] as String,
      price: map['price'] as String,
      imageUrl: map['imageUrl'] as String,
      quantity: map['quantity'] as String,
      orderDate: map['orderDate'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(orderId: $orderId, userId: $userId, productId: $productId, userName: $userName, price: $price, imageUrl: $imageUrl, quantity: $quantity, orderDate: $orderDate)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.orderId == orderId &&
        other.userId == userId &&
        other.productId == productId &&
        other.userName == userName &&
        other.price == price &&
        other.imageUrl == imageUrl &&
        other.quantity == quantity &&
        other.orderDate == orderDate;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        userId.hashCode ^
        productId.hashCode ^
        userName.hashCode ^
        price.hashCode ^
        imageUrl.hashCode ^
        quantity.hashCode ^
        orderDate.hashCode;
  }
}
