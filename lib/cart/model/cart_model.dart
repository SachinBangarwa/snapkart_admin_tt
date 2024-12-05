class CartModel {
  String id;
  num quantity;


  CartModel({
    required this.id,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': id,
      'quantity': quantity,

    };
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['productId'],
      quantity: json['quantity'],
    );
  }
}
