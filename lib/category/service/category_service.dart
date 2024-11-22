import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:snapkart_admin/auth/service/auth_shared_preferences.dart';
import 'package:snapkart_admin/category/model/category_model.dart';
import 'package:snapkart_admin/core/api_endpoint.dart';

class CategoryService {
  String apiKey='aihfj--qwnkqwr--jlkqwnjqw--jnkqwjnqwy';
  Future<List<CategoryModel>> fetchCategory() async {
    String url = ApiEndpoint.fetchCategoriesUrl;
    final response = await http.get(Uri.parse(url),
        headers: {'x-api-key': apiKey});
    if (response.statusCode == 200) {
      final mapList = jsonDecode(response.body);
      List<CategoryModel> categoryList = [];
      for (int i = 0; i < mapList.length; i++) {
        final category = mapList[i];
        categoryList.add(CategoryModel.fromJson(category));
      }
      return categoryList;
    } else {
      throw ' category response =>${response.statusCode}';
    }
  }

  Future<bool> addCategory(CategoryModel category) async {
   String? token=await AuthSharedPreferences.getToken();
    final response = await http.post(Uri.parse(ApiEndpoint.addCategoriesUrl),
        body: jsonEncode(
          category.toJson(),
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
          'x-api-key': apiKey,
        });
    if (response.statusCode == 201) {
      return true;
    } else {
      throw 'not found${response.statusCode}';
    }
  }

  Future<bool> updateCategory(CategoryModel category) async {
    String? token=await AuthSharedPreferences.getToken();

    final response = await http
        .put(Uri.parse(ApiEndpoint.updateCategoriesUrl + category.sId.toString()),
            body: jsonEncode(
              category.toJson(),
            ),
            headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
          'x-api-key': apiKey,
        }
        );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'not found${response.statusCode}';
    }
  }
  Future<bool> deleteCategory(CategoryModel category) async {
    String? token=await AuthSharedPreferences.getToken();

    String url = ApiEndpoint.deleteCategoriesUrl +category.sId.toString();
    final response = await http.delete(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization':
      "Bearer $token",
      'x-api-key': apiKey,
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'response api ${response.statusCode}';
    }
  }
}
