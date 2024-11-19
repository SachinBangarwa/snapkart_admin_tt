import 'dart:convert';

import 'package:snapkart_admin/core/api_endpoint.dart';
import 'package:snapkart_admin/product/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<Product>> fetchProduct() async {
    String url = ApiEndpoint.fetchProductUrl;
    final response = await http.get(Uri.parse(url),
        headers: {'x-api-key': 'aihfj--qwnkqwr--jlkqwnjqw--jnkqwjnqwy'});
    if (response.statusCode == 200) {
      final mapList = jsonDecode(response.body);
      List<Product> productList = [];
      for (int i = 0; i < mapList.length; i++) {
        final json = mapList[i];
        final product = Product.fromJson(json);
        productList.add(product);
      }
      return productList;
    }
    throw 'Unable found product';
  }
  Future<bool> addProduct(Product product) async {
    String url = ApiEndpoint.addProductUrl;
    String jsonProduct = jsonEncode(product.toJson());
    final response =
        await http.post(Uri.parse(url), body: jsonProduct, headers: {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${ApiEndpoint.token}',
      'x-api-key': 'aihfj--qwnkqwr--jlkqwnjqw--jnkqwjnqwy'
    });
    if (response.statusCode == 201) {
      return true;
    } else {
      throw 'Note Fount=>${response.statusCode}';
    }
  }

  Future<bool> updateProduct(Product product) async {
    String url = ApiEndpoint.updateProductUrl + product.sId.toString();
    final response = await http
        .put(Uri.parse(url), body: jsonEncode(product.toJson()), headers: {
      'Content-Type': 'application/json',
      'Authorization':
          "Bearer ${ApiEndpoint.token}",
      'x-api-key': 'aihfj--qwnkqwr--jlkqwnjqw--jnkqwjnqwy',
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'response api ${response.statusCode}';
    }
  }

  Future<bool> deleteProduct(Product product) async {
    String url = ApiEndpoint.deleteProductUrl + product.sId.toString();
    final response = await http.delete(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization':
          "Bearer ${ApiEndpoint.token}",
      'x-api-key': 'aihfj--qwnkqwr--jlkqwnjqw--jnkqwjnqwy',
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'response api ${response.statusCode}';
    }
  }
}
