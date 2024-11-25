import 'package:flutter/material.dart';
import 'package:snapkart_admin/core/app_util.dart';
import 'package:snapkart_admin/product/model/product_model.dart';
import 'package:snapkart_admin/product/service/product_service.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider(this.productService);
  ProductService productService;
  String? _errorMessage;
  List<Product> _productList = [];
   bool _isSuccess = false;
   bool _isLoading=false;

  String? get errorMessage => _errorMessage;

  bool get isSuccess {return _isSuccess;}

  List<Product> get productList=>_productList;

  bool get isLoading=>_isLoading;

  Future<void> fetchProduct() async {
    try {
      _errorMessage = null;
      _isLoading=true;
     // notifyListeners();
      _productList = await productService.fetchProduct();
    } catch (msg) {
      _errorMessage = msg.toString();
    }
    _isLoading=false;
    notifyListeners();
  }

  Future addProduct(Product product) async {
    try {
      _isSuccess = await productService.addProduct(product);
      notifyListeners();
    } catch (e) {
      notifyListeners();
      AppUtil.showToast(e.toString());
    }
  }

  Future updateProduct(Product product) async {
    try {
      _isSuccess = await productService.updateProduct(product);
      if (_isSuccess) {
        notifyListeners();
      }
    } catch (error) {
      AppUtil.showToast(error.toString());
    }
  }

  Future deleteProduct(String id) async {
    try {
      _isLoading=true;
      notifyListeners();
      _errorMessage=null;
      await productService.deleteProduct(id);
      _isLoading=false;
        notifyListeners();
    } catch (error) {
      _isLoading=false;
      _errorMessage=error.toString();
      AppUtil.showToast(error.toString());
      notifyListeners();
    }
  }
}
