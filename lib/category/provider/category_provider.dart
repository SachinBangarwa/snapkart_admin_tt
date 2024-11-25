import 'package:flutter/material.dart';
import 'package:snapkart_admin/category/model/category_model.dart';
import 'package:snapkart_admin/category/service/category_service.dart';
import 'package:snapkart_admin/core/app_util.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryProvider(this.categoryService);

  CategoryService categoryService;
  List<CategoryModel> _category = [];
  bool _success = false;
  bool _isLoading=false;

  List<CategoryModel> get category => _category;

  bool get success => _success;

  bool get isLoading=>_isLoading;

  Future<void> fetchCategory() async {
    try {
      _category = await categoryService.fetchCategory();
      notifyListeners();
    } catch (e) {
      AppUtil.showToast(e.toString());
    }
  }

  Future addCategory(CategoryModel category) async {
    try {
      _success = await categoryService.addCategory(category);
      if (_success) {
        // AppUtil.showToast('Category Add successFull');
        notifyListeners();
      }
    } catch (e) {
      AppUtil.showToast(e.toString());
    }
  }

  Future updateCategory(CategoryModel category) async {
    try {
      _success = await categoryService.updateCategory(category);
      if (_success) {
        notifyListeners();
      }
    } catch (e) {
      AppUtil.showToast(e.toString());
    }
  }

  Future deleteCategory(String id) async {
    try {
      _isLoading=true;
      notifyListeners();
      _success = await categoryService.deleteCategory(id);
      print('delete');
    } catch (e) {
      AppUtil.showToast(e.toString());
    }
    _isLoading=false;
    notifyListeners();
  }
}
