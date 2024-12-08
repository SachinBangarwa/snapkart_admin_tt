import 'package:flutter/widgets.dart';
import 'package:snapkart_admin/core/app_util.dart';
import 'package:snapkart_admin/order/model/order_item_model.dart';
import 'package:snapkart_admin/order/model/order_model.dart';
import 'package:snapkart_admin/order/model/order_request_model.dart';
import 'package:snapkart_admin/order/model/order_response_model.dart';
import 'package:snapkart_admin/order/service/order_api_service.dart';

class OrderApiProvider extends ChangeNotifier {
  OrderApiProvider(this.orderApiService);

  OrderApiService orderApiService;
  List<Orders>  orderItemList=[];
  String? errorMessage;
  bool isLoading = false;
  Future<void> placeOrder(OrderRequestModel orderRequestModel) async {
    try {
      conditionHandel();
      bool success = await orderApiService.placeOrder(orderRequestModel);
      if (success) {
        AppUtil.showToast('order successFull');
      }else{
        errorMessage = 'plz try again';
      }
    } catch (error) {
      AppUtil.showToast(error.toString());
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  } Future<void> orderResponse() async {
    try {
      conditionHandel();
      OrderResponseModel orderResponseModel = await orderApiService.orderResponse();
      orderItemList= orderResponseModel.orders??[];
    } catch (error) {
      AppUtil.showToast(error.toString());
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void conditionHandel() {
    errorMessage = null;
    isLoading = true;
    notifyListeners();
  }
}
