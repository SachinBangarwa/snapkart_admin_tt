class Product {
  String? sId;
  String? name;
  String? description;
  int? price;
  String? category;
  int? iV;

  Product(
      {this.sId,
        this.name,
        this.description,
        this.price,
        this.category,
        this.iV});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    category = json['category'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =<String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['category'] = category;
    data['__v'] = iV;
    return data;
  }
}
