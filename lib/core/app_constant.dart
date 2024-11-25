import 'dart:convert';

import 'package:snapkart_admin/category/model/category_model.dart';
import 'package:snapkart_admin/core/service/storage_helper.dart';
import 'package:snapkart_admin/product/model/product_model.dart';

class AppConstant{
  static String apiKey='aihfj--qwnkqwr--jlkqwnjqw--jnkqwjnqwy';

 static Future< Map<String, String>> getHeader()async {
    String? token = await StorageHelper.getToken();
    return {
      'x-api-key': AppConstant.apiKey,
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }
  static String jsonProductBody(Product product) {
    Map<String, dynamic> json = product.toJson();
    String jsonCategory = jsonEncode(json);
    return jsonCategory;
  }
  
  static String jsonCategoryBody(CategoryModel category) {
    Map<String, dynamic> json = category.toJson();
    String jsonCategory = jsonEncode(json);
    return jsonCategory;
  }
}