import 'package:snapkart_admin/product/model/product_model.dart';

class CartItem {
  Product? product;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  CartItem({this.product, this.quantity, this.createdAt, this.updatedAt});

  CartItem.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['quantity'] = quantity;
    data['createdAt'] = createdAt;
    data['updatedAt'] =updatedAt;
    return data;
  }
}