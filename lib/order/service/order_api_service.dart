import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:snapkart_admin/core/api_endpoint.dart';
import 'package:snapkart_admin/core/app_constant.dart';
import 'package:snapkart_admin/order/model/order_request_model.dart';
import 'package:snapkart_admin/order/model/order_response_model.dart';

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
  Future<OrderResponseModel> orderResponse() async {
    String url = ApiEndpoint.orderUrl;
    final header = await AppConstant.getHeader();
    http.Response response = await http.get(Uri.parse(url), headers: header);

    if (response.statusCode == 200) {
      String body = response.body;
      final json = jsonDecode(body);
      return OrderResponseModel.fromJson(json);
    }
    final json=jsonDecode(response.body);
    throw json['message']??'unable to response userOrders';
  }
}
