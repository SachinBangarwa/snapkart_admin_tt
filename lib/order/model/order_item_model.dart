class OrderItem {
  String product;
  String name;
  num quantity;
  num price;
  num discountAmount;
  num totalPrice;

  OrderItem({
    required this.product,
    required this.name,
    required this.quantity,
    required this.price,
    required this.discountAmount,
    required this.totalPrice,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      product: json['product']??'',
      name: json['name']??'',
      quantity: json['quantity'],
      price: json['price'],
      discountAmount: json['discountAmount'],
      totalPrice: json['totalPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'name': name,
      'quantity': quantity,
      'price': price,
      'discountAmount': discountAmount,
      'totalPrice': totalPrice,
    };
  }
}
