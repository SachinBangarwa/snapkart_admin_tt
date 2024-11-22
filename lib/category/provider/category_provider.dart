import 'package:flutter/material.dart';
import 'package:snapkart_admin/category/model/category_model.dart';
import 'package:snapkart_admin/category/service/category_service.dart';
import 'package:snapkart_admin/core/app_util.dart';

class CategoryProvider extends ChangeNotifier{
  CategoryProvider(this.categoryService);
  CategoryService categoryService;
  List<CategoryModel> _category=[];
  List<CategoryModel> get category=>_category;
  bool success=false;

  Future<void> fetchCategory()async{
    try {
      _category = await categoryService.fetchCategory();
      notifyListeners();
      AppUtil.showToast('success');
    }catch(e){
      AppUtil.showToast(e.toString());
    }
  }

  Future addCategory(CategoryModel category)async{

  try{
     success=await categoryService.addCategory(category);
    if(success){
      // AppUtil.showToast('Category Add successFull');
      notifyListeners();
    }
  }catch(e){
    AppUtil.showToast(e.toString());
  }
  }
  Future updateCategory(CategoryModel category)async{
    try{
      success=await categoryService.updateCategory(category);
      if(success){
        notifyListeners();
      }
    }catch(e){
      AppUtil.showToast(e.toString());
    }
  }
  Future deleteCategory(CategoryModel category)async{
    try{
      success=await categoryService.deleteCategory(category);
      if(success){
        // AppUtil.showToast('Category delete successFull');
        notifyListeners();
      }
    }catch(e){
      AppUtil.showToast(e.toString());
    }
  }

}