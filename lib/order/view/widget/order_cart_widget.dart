import 'package:flutter/material.dart';
import 'package:snapkart_admin/order/model/order_model.dart';
import 'package:snapkart_admin/order/view/order_detail_screen.dart';

class OrderCartWidget extends StatelessWidget {
  const OrderCartWidget({required this.order, super.key});

  final Orders order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRichText('Order #', "${order.orderNumber}",
                  Colors.black, 16.0, FontWeight.w500),
              const SizedBox(
                height: 5,
              ),
              buildRichText('Status: ', "${order.orderStatus}",
                  Colors.orange, 14.0, FontWeight.w400),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildRichText('Items: ', "${order.items?.length ?? 0}",
                      Colors.black, 14.0, FontWeight.w400),
                  TextButton(
                    onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context){
                       return OrderDetailScreen(orderItemList: order.items??[],);
                     }));
                    },
                    child: const Text('View Detail'),
                  ),
                ],
              ),
              buildRichText('Place on: ', "${order.updatedAt}",
                  Colors.black, 12.0, FontWeight.w300),
            ],
          ),
        ),
      ),
    );
  }

  RichText buildRichText(
      String text, String label, Color color, double size, FontWeight weight) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              style:
                  TextStyle(fontWeight: weight, color: color, fontSize: size),
              text: text,
              children: [TextSpan(text: label)]),
        ],
      ),
    );
  }
}
