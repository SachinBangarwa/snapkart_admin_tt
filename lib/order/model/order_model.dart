import 'package:snapkart_admin/order/model/order_item_model.dart';
import 'package:snapkart_admin/order/model/shipping_address_model.dart';

class Orders {
  ShippingAddress? shippingAddress;
  String? sId;
  String? orderNumber;
  String? user;
  List<OrderItem>? items;
  String? orderStatus;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Orders(
      {this.shippingAddress,
        this.sId,
        this.orderNumber,
        this.user,
        this.items,
        this.orderStatus,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Orders.fromJson(Map<String, dynamic> json) {
    shippingAddress = json['shippingAddress'] != null
        ?  ShippingAddress.fromJson(json['shippingAddress'])
        : null;
    sId = json['_id'];
    orderNumber = json['orderNumber'];
    user = json['user'];
    if (json['items'] != null) {
      items = <OrderItem>[];
      json['items'].forEach((v) {
        items!.add( OrderItem.fromJson(v));
      });
    }
    orderStatus = json['orderStatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shippingAddress != null) {
      data['shippingAddress'] = shippingAddress!.toJson();
    }
    data['_id'] = sId;
    data['orderNumber'] = orderNumber;
    data['user'] = user;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['orderStatus'] = orderStatus;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}