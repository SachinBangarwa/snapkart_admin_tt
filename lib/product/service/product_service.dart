import 'dart:convert';

import 'package:snapkart_admin/auth/service/auth_shared_preferences.dart';
import 'package:snapkart_admin/core/api_endpoint.dart';
import 'package:snapkart_admin/product/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService  {
  String apiKey='aihfj--qwnkqwr--jlkqwnjqw--jnkqwjnqwy';
  Future<List<Product>> fetchProduct() async {
    String url = ApiEndpoint.fetchProductUrl;
    Uri uri=Uri.parse(url);
    final response = await http.get(uri,
        headers: {'x-api-key': apiKey});
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
    String? token = await AuthSharedPreferences.getToken();
    final header={
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'x-api-key': apiKey
    };
    String url = ApiEndpoint.addProductUrl;
   Uri uri= Uri.parse(url);
   final map=product.toJson();
    String jsonProduct = jsonEncode(map);
    final response =
        await http.post(uri, body: jsonProduct, headers: header);
    if (response.statusCode == 201) {
      return true;
    } else {
      print(token);
      throw 'Note Fount=>${response.statusCode}';
    }
  }

  Future<bool> updateProduct(Product product) async {
    String? token = await AuthSharedPreferences.getToken();
    String url = ApiEndpoint.updateProductUrl + product.sId.toString();
    Uri uri= Uri.parse(url);
    final header={
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'x-api-key': apiKey
    };
    final map=product.toJson();
    final response =
    await http.put(uri, body: jsonEncode(map), headers: header);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'response api ${response.statusCode}';
    }
  }

  Future<bool> deleteProduct(Product product) async {
    String? token = await AuthSharedPreferences.getToken();
    String url = ApiEndpoint.deleteProductUrl + product.sId.toString();
    Uri uri= Uri.parse(url);
    final header={
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'x-api-key': apiKey
    };
    final response = await http.delete(uri, headers:header);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'response api ${response.statusCode}';
    }
  }
}
