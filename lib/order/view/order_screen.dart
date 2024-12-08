import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/order/model/order_model.dart';
import 'package:snapkart_admin/order/provider/order_api_provider.dart';
import 'package:snapkart_admin/order/view/widget/order_cart_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
      ),
      body: Consumer<OrderApiProvider>(
        builder: (context, orderProvider, child) {
          if (orderProvider.isLoading) {
            return const SpinKitFadingGrid(
              color: Colors.black,
              size: 20,
            );
          }
          if (orderProvider.errorMessage != null) {
            return Center(
              child: Text('Error ${orderProvider.errorMessage}'),
            );
          }
          if (orderProvider.orderItemList.isEmpty) {
            return const Text('Order List Is Empty');
          }
            return ListView.builder(
                itemCount: orderProvider.orderItemList.length,
                itemBuilder: (context, index) {
                  final order = orderProvider.orderItemList[index];
                  return OrderCartWidget(
                    order: order,
                  );
                });

        },
      ),
    );
  }
}
