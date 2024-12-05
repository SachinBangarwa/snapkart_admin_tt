import 'package:snapkart_admin/cart/model/cart_item_model.dart';

class CartResponse {
  String? user;
  int? subtotal;
  int? totalDiscount;

  List<CartItem>? items;

  CartResponse({this.user, this.subtotal, this.totalDiscount, this.items});

  CartResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    subtotal = json['subtotal'];
    totalDiscount = json['totalDiscount'];
    if (json['items'] != null) {
      items = <CartItem>[];
      json['items'].forEach((v) {
        items!.add( CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['user'] = user;
    data['subtotal'] = subtotal;
    data['totalDiscount'] = totalDiscount;
    if (items != null) {
      data['items'] =items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



