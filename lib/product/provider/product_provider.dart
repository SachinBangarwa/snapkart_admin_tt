import 'package:flutter/material.dart';
import 'package:snapkart_admin/core/app_util.dart';
import 'package:snapkart_admin/product/model/product_model.dart';
import 'package:snapkart_admin/product/service/product_service.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider(this.productService);

  ProductService productService;
  List<Product> product = [];
  String? errorMessage;

  Future<void> fetchProduct() async {
    try {
      product = await productService.fetchProduct();
      AppUtil.showToast('achieve product');
      notifyListeners();
    } catch (msg) {
      errorMessage = msg.toString();
      notifyListeners();
    }
  }

  Future addProduct(Product product) async {
    try {
      bool addSuccess = await productService.addProduct(product);
      if (addSuccess) {
        notifyListeners();
        AppUtil.showToast('Product Add SuccessFull');
      }
    } catch (e) {
      notifyListeners();
      AppUtil.showToast(e.toString());
    }
  }

  Future updateProduct(Product product) async {
    try {
      bool updateSuccess = await productService.updateProduct(product);
      if (updateSuccess) {
        notifyListeners();
        AppUtil.showToast('Update product SuccessFull');
      }
    } catch (error) {
      AppUtil.showToast(error.toString());
    }
  }

  Future deleteProduct(Product product) async {
    try {
      bool updateSuccess = await productService.deleteProduct(product);
      if (updateSuccess) {
        notifyListeners();
        AppUtil.showToast('delete product SuccessFull');
      }
    } catch (error) {
      AppUtil.showToast(error.toString());
    }
  }
}
