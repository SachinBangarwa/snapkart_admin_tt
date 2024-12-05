import 'package:snapkart_admin/order/model/ordel_item_model.dart';
import 'package:snapkart_admin/order/model/shipping_address_model.dart';

class OrderRequestModel {
  List<OrderItem> items;
  ShippingAddress shippingAddress;

  OrderRequestModel({required this.items, required this.shippingAddress});

  factory OrderRequestModel.fromJson(Map<String, dynamic> json) {
    return OrderRequestModel(
      items: List<OrderItem>.from(
        json['items'].map((x) => OrderItem.fromJson(x)),
      ),
      shippingAddress: ShippingAddress.fromJson(json['shippingAddress']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((x) => x.toJson()).toList(),
      'shippingAddress': shippingAddress.toJson(),
    };
  }
}




