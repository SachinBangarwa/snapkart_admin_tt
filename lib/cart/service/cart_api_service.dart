import 'dart:convert';

import 'package:snapkart_admin/cart/model/cart_model.dart';
import 'package:snapkart_admin/cart/model/cart_response_model.dart';
import 'package:snapkart_admin/core/api_endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:snapkart_admin/core/app_constant.dart';
import 'package:snapkart_admin/product/model/product_model.dart';

class CartApiService {
  Future<CartResponse> fetchCartItem() async {
    final header = await AppConstant.getHeader();
    String url = ApiEndpoint.cartUrl;
    http.Response response = await http.get(Uri.parse(url), headers: header);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return CartResponse.fromJson(json);
    } else {
      final json = jsonDecode(response.body);
      throw json['message'] ?? 'unable to fetch';
    }
  }

  Future<bool> cartUpdateQuantity(
    CartModel cartModel,
  ) async {
    final header = await AppConstant.getHeader();
    String url = ApiEndpoint.cartUrl;
    final json = cartModel.toJson();
    http.Response response = await http.put(
      Uri.parse(url),
      headers: header,
      body: jsonEncode(json),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      final json = jsonDecode(response.body);
      throw json['message'] ?? 'Unable to Update cart in item';
    }
  }

  Future<bool> addCartItem(CartModel cartModel) async {
    String url = ApiEndpoint.cartUrl;
    final header = await AppConstant.getHeader();
    http.Response response = await http.post(Uri.parse(url),
        body: jsonEncode(cartModel.toJson()), headers: header);
    if (response.statusCode == 201) {
      return true;
    }
    final json = jsonDecode(response.body);
    throw json['message'] ?? 'Unable to add cart in item';
  }

  Future<bool> deleteCartItem(String id) async {
    String url = ApiEndpoint.cartId(id);
    final header = await AppConstant.getHeader();
    http.Response response = await http.delete(Uri.parse(url), headers: header);
    if (response.statusCode == 200) {
      return true;
    }
    final json = jsonDecode(response.body);
    throw json['message'] ?? 'unable to delete';
  }

  Future<bool> clearCartItem() async {
    String url = ApiEndpoint.cartUrl;
    final header = await AppConstant.getHeader();
    http.Response response = await http.delete(Uri.parse(url), headers: header);
    if (response.statusCode == 200) {
      return true;
    }
    final json = jsonDecode(response.body);
    throw json['message'] ?? 'plz try again cart response check';
  }
}
