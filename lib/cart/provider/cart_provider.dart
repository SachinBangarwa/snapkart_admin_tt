import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:snapkart_admin/cart/model/cart_model.dart';
import 'package:snapkart_admin/cart/model/cart_response_model.dart';
import 'package:snapkart_admin/cart/service/cart_api_service.dart';
import 'package:snapkart_admin/core/app_util.dart';

class CartProvider extends ChangeNotifier {
  CartProvider(this.cartApiService);

  CartApiService cartApiService;
  CartResponse? _cartResponse;
  String? _errorMessage;
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  String? get errorMessage {
    return _errorMessage;
  }

  CartResponse? get cartResponse {
    return _cartResponse;
  }

  Future<void> cartAddItem(CartModel cartModel) async {
    try {
      conditionHandle();
      bool success = await cartApiService.addCartItem(cartModel);
      if (success) {
        AppUtil.showToast('cart add successFull');
      }
    } catch (error) {
      socketException(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cartFetchItem() async {
    try {
      conditionHandle();
      notifyListeners();
      _cartResponse = await cartApiService.fetchCartItem();
    } catch (error) {
      socketException(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future cartUpdateItem(CartModel cartModel) async {
    try {
      conditionHandle();
      notifyListeners();
      bool success = await cartApiService.cartUpdateQuantity(cartModel);
      success ? AppUtil.showToast('update cart successFull') : '';
      success ? cartFetchItem() : '';
    } catch (error) {
      socketException(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> deleteCartItem(String id)async{
    try{
      conditionHandle();
      notifyListeners();
      bool success = await cartApiService.deleteCartItem(id);
      if (success) {
        AppUtil.showToast('cart remove successFull');
      }
    }catch(error){
      socketException(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void socketException(Object error) {
    if (error == SocketException) {
      AppUtil.showToast('Internet connection fail');
    } else {
      AppUtil.showToast(error.toString());
      _errorMessage = error.toString();
    }
  }

  void conditionHandle() {
    _errorMessage = null;
    _isLoading = true;
  }
}
