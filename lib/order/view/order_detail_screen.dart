import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/order/model/order_item_model.dart';
import 'package:snapkart_admin/order/provider/order_api_provider.dart';
import 'package:snapkart_admin/order/view/widget/order_detail_widget.dart';

class OrderDetailScreen extends StatefulWidget {
  OrderDetailScreen({required this.orderItemList, super.key});

  List<OrderItem> orderItemList = [];

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return Consumer<OrderApiProvider>(builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(
                child: SpinKitFadingGrid(
                  color: Colors.black,
                  size: 22,
                ),
              );
            }
            if (provider.errorMessage != null) {
              return Center(
                child: Text('Error ${provider.errorMessage}'),
              );
            } if (widget.orderItemList.isEmpty) {
              return const Center(
                child: Text('Product List Is Empty'),
              );
            }
            return ListView.builder(
                itemCount: widget.orderItemList.length,
                itemBuilder: (context, index) {
                  final orderItem=widget.orderItemList[index];
                 return OrderDetailWidget(orderItem: orderItem,);
          });
    });
  }
}
