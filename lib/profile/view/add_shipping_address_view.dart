import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/cart/model/cart_item_model.dart';
import 'package:snapkart_admin/cart/provider/cart_provider.dart';
import 'package:snapkart_admin/order/model/order_item_model.dart';
import 'package:snapkart_admin/order/model/order_request_model.dart';
import 'package:snapkart_admin/order/model/shipping_address_model.dart';
import 'package:snapkart_admin/order/provider/order_api_provider.dart';

class AddShippingAddressView extends StatefulWidget {


  const AddShippingAddressView({super.key,});


  @override
  State<AddShippingAddressView> createState() => _AddShippingAddressState();
}

class _AddShippingAddressState extends State<AddShippingAddressView> {
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final postalCodeController = TextEditingController();
  final countryController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    postalCodeController.dispose();
    countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Shipping Address"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildShippingAddress("Street", streetController),
            buildShippingAddress("City", cityController),
            buildShippingAddress("State", stateController),
            buildShippingAddress("Postal Code", postalCodeController),
            buildShippingAddress("Country", countryController),
            const SizedBox(
              height: 10,
            ),
            buildPlaceOrderButton()
          ],
        ),
      ),
    );
  }

  Widget buildPlaceOrderButton() {
    return TextButton(
      onPressed: () async {
        ShippingAddress shippingAddress = ShippingAddress(
          street: streetController.text,
          city: cityController.text,
          state: stateController.text,
          postalCode: postalCodeController.text,
          country: countryController.text,
        );
      Navigator.pop(context,shippingAddress);

      },
      child: const Text(
        'Continues',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget buildShippingAddress(String hintText, var controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
