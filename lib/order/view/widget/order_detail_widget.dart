import 'package:flutter/material.dart';
import 'package:snapkart_admin/order/model/order_item_model.dart';

class OrderDetailWidget extends StatefulWidget {
  const OrderDetailWidget({super.key, required this.orderItem});

  final OrderItem orderItem;

  @override
  State<OrderDetailWidget> createState() => _OrderDetailWidgetState();
}

class _OrderDetailWidgetState extends State<OrderDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.orderItem.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              buildRow('Product ID:', widget.orderItem.product),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Quantity: ',
                        style: TextStyle(fontSize: 13),
                      ),
                      Text("₹${widget.orderItem.price}",
                          style: const TextStyle(fontSize: 13))
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Price: ',
                          style: TextStyle(fontSize: 13, color: Colors.teal)),
                      Text("₹${widget.orderItem.price}",
                          style: const TextStyle(fontSize: 13, color: Colors.teal))
                    ],
                  )
                ],
              ),
              buildRow(
                  'Discount: ', "₹${widget.orderItem.discountAmount}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    '₹${widget.orderItem.price.toString()}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRow(String name, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Text(
            name,
            style: const TextStyle(),
            overflow: TextOverflow.ellipsis,
          )),
          Text(
            value,
          ),
        ],
      ),
    );
  }
}
