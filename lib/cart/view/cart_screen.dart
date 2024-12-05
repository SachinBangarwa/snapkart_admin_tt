import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/cart/model/cart_item_model.dart';
import 'package:snapkart_admin/cart/model/cart_model.dart';
import 'package:snapkart_admin/cart/provider/cart_provider.dart';
import 'package:snapkart_admin/profile/view/add_shipping_address_view.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CartProvider>(context, listen: false).cartFetchItem();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE0F2F1), // Light teal background
        elevation: 0,
        title: const Text(
          'Cart',
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<CartProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              buildSummaryContainer(provider),
              buildCartItemsList(provider),
              buildPlaceOrderButton(),
            ],
          );
        },
      ),
    );
  }

  Widget buildSummaryContainer(CartProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffa35555),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            buildSummaryRow('SubTotal', provider.cartResponse?.subtotal ?? 0),
            const SizedBox(height: 6),
            buildSummaryRow('Discount', provider.cartResponse?.totalDiscount ?? 0),
          ],
        ),
      ),
    );
  }

  Widget buildSummaryRow(String label, dynamic value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          value.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget buildCartItemsList(CartProvider provider) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: provider.cartResponse?.items?.length ?? 0,
        itemBuilder: (context, index) {
          CartItem item = provider.cartResponse!.items![index];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDetailRow('Product', item.product?.name ?? ''),
                const SizedBox(height: 8),
                buildDetailRow('Price', item.product?.price.toString() ?? '0'),
                const SizedBox(height: 8),
                buildQuantityChange('Quantity', item),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.grey.shade800,
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget buildQuantityChange(String label, CartItem cartItem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                int quantity = cartItem.quantity ?? 0;
                quantity--;
                if (quantity >= 1) {
                      cartItem.quantity = quantity;
                  Provider.of<CartProvider>(context, listen: false)
                      .cartUpdateItem(CartModel(
                      id: cartItem.product!.id.toString(),
                      quantity: quantity));
                }
              },
              icon: const Icon(Icons.remove, color: Colors.redAccent),
            ),
            Text(
              '${cartItem.quantity}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {
                int quantity = cartItem.quantity ?? 0;
                quantity++;
                if (quantity >= 1) {
                      cartItem.quantity = quantity;
                  Provider.of<CartProvider>(context, listen: false)
                      .cartUpdateItem(CartModel(
                      id: cartItem.product!.id.toString(),
                      quantity: quantity));
                }
              },
              icon: const Icon(Icons.add, color: Colors.redAccent),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildPlaceOrderButton() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xffa35555),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Place Order',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddShippingAddressView(),
                  ),
                );
              },
              icon: const Icon(Icons.payment, color: Colors.white),
              label: const Text(
                'Proceed',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
