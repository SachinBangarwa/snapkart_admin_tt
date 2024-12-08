import 'package:snapkart_admin/product/model/product_model.dart';

class CartItem {
  Product? product;
  num? quantity;
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
    data['updatedAt'] = updatedAt;
    return data;
  }
  //
  // CartItemOrder toCartItemOrder() {
  //   num price = product?.price ?? 0;
  //   int quantityValue = quantity ?? 0;
  //   num totalPrice = price * quantityValue;
  //   int discountAmount = 0;
  //
  //   return CartItemOrder(
  //     product: product?.id ?? '',
  //     name: product?.name ?? 'Unknown Product',
  //     quantity: quantityValue,
  //     price: price,
  //     discountAmount: discountAmount,
  //     totalPrice: totalPrice,
  //   );
  // }
}

// class CartItemOrder {
//   String product;
//   String name;
//   int quantity;
//   num price;
//   int discountAmount;
//   num totalPrice;
//
//   CartItemOrder({
//     required this.product,
//     required this.name,
//     required this.quantity,
//     required this.price,
//     required this.discountAmount,
//     required this.totalPrice,
//   });
//
//
//   OrderItem toOrderItem() {
//     return OrderItem(
//       product: product,
//       name: name,
//       quantity: quantity,
//       price: price,
//       discountAmount: discountAmount,
//       totalPrice: totalPrice,
//     );
//   }
// }
