import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:snapkart_admin/core/api_endpoint.dart';
import 'package:snapkart_admin/core/app_constant.dart';
import 'package:snapkart_admin/product/model/product_model.dart';

class ProductService {
  Future<List<Product>> fetchProduct() async {
    final header = await AppConstant.getHeader();
    String url = ApiEndpoint.productUrl;
    final response = await http.get(Uri.parse(url), headers: header);
    if (response.statusCode == 200) {
      String jsonStr = response.body;
      List<Product> productList = [];
      final mapList = jsonDecode(jsonStr);
      for (int i = 0; i < mapList.length; i++) {
        final json = mapList[i];
        Product product = Product.fromJson(json);

        productList.add(product);
      }
      return productList;
    }
    return [];
  }

  Future<bool> addProduct(Product product) async {
    final header = await AppConstant.getHeader();
    String url = ApiEndpoint.productUrl;
    Uri uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: AppConstant.jsonProductBody(product),
      headers: header,
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      throw 'not found response status invalid';
    }
  }

  Future<bool> updateProduct(Product product) async {
    print('${product.id}hhhhh');
    String url = ApiEndpoint.productId(product.id.toString());
    Uri uri = Uri.parse(url);
    final header = await AppConstant.getHeader();
    final response = await http.put(uri,
        body: AppConstant.jsonProductBody(product), headers: header);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'not found response status invalid';
    }
  }

  Future<bool> deleteProduct(String id) async {
    String url = ApiEndpoint.productId(id);
    Uri uri = Uri.parse(url);
    final header = await AppConstant.getHeader();
    final response = await http.delete(uri, headers: header);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'not found response status invalid';
    }
  }
}
