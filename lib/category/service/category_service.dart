import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:snapkart_admin/category/model/category_model.dart';
import 'package:snapkart_admin/core/api_endpoint.dart';
import 'package:snapkart_admin/core/app_constant.dart';

class CategoryService {
  Future<List<CategoryModel>> fetchCategory() async {
    String url = ApiEndpoint.categoriesUrl;
    final response = await http
        .get(Uri.parse(url), headers: {'x-api-key': AppConstant.apiKey});
    if (response.statusCode == 200) {
      final mapList = jsonDecode(response.body);
      List<CategoryModel> categoryList = [];
      for (int i = 0; i < mapList.length; i++) {
        final category = mapList[i];
        categoryList.add(CategoryModel.fromJson(category));
      }
      return categoryList;
    } else {
      throw 'Not found response status invalid';
    }
  }

  Future<bool> addCategory(CategoryModel category) async {
    final header = await AppConstant.getHeader();
    final response = await http.post(Uri.parse(ApiEndpoint.categoriesUrl),
        body: AppConstant.jsonCategoryBody(category),
        headers: header);
    if (response.statusCode == 201) {
      return true;
    } else {
      throw 'Not found response status invalid';
    }
  }

  Future<bool> updateCategory(CategoryModel category) async {
    final header = await AppConstant.getHeader();
    String url = ApiEndpoint.categoryId(category.sId.toString());
    final response = await http.put(Uri.parse(url),
        body:AppConstant.jsonCategoryBody(category),
        headers: header);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'Not found response status invalid';
    }
  }

  Future<bool> deleteCategory(String id) async {
    String url = ApiEndpoint.categoryId(id.toString());
    final header = await AppConstant.getHeader();
    final response = await http.delete(Uri.parse(url), headers: header);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'Not found response status invalid';
    }
  }
}
