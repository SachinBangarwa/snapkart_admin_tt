import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:snapkart_admin/core/api_endpoint.dart';
import 'package:snapkart_admin/core/app_constant.dart';
import 'package:snapkart_admin/order/model/order_request_model.dart';

class OrderApiService {
  Future<bool> placeOrder(OrderRequestModel orderRequestModel) async {
    final header = await AppConstant.getHeader();
    String url = ApiEndpoint.orderUrl;
    final response = await http.post(Uri.parse(url),
        body: jsonEncode(orderRequestModel.toJson()), headers: header);
    if(response.statusCode==201){
      return true;
    }
    throw 'unable to place order';
  }
}
