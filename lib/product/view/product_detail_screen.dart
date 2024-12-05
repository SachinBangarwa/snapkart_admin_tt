import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/cart/model/cart_model.dart';
import 'package:snapkart_admin/cart/provider/cart_provider.dart';
import 'package:snapkart_admin/cart/view/cart_screen.dart';
import 'package:snapkart_admin/core/app_util.dart';
import 'package:snapkart_admin/product/model/product_model.dart';
import 'package:snapkart_admin/product/provider/product_provider.dart';
import 'package:snapkart_admin/product/view/update_product_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Detail"),
        actions: [
          IconButton(
              onPressed: () async {
                await buildDeleteButton(context);
              },
              icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                buildUpdateButton(context);
              },
              icon: const Icon(Icons.auto_fix_normal_rounded)),
          IconButton(
              onPressed: () async {
               await buildAddCartButton(context);
              },
              icon: const Icon(Icons.add_shopping_cart))
        ],
      ),
      body: Consumer<ProductProvider>(builder: (context, provider, child) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:Column(
                children: [
                  buildRow('Name', product.name.toString()),
                  buildRow('Price', product.price.toString()),
                  buildRow('Category', product.categoryId.toString()),
                  buildRow('Stock', product.stock.toString()),
                  buildRow('DiscountAmount', product.discountAmount?.toString() ?? ''),
                  buildImageRow('Image', product.image),
                  Text(product.description.toString()),
                ],
              ),
            ),
            AppUtil.flutterSpinCit(provider),
          ],
        );
      }),
    );
  }

  Future<void> buildAddCartButton(BuildContext context) async {
    final provider = Provider.of<CartProvider>(context, listen: false);
    CartModel cartModel = CartModel(id: product.id.toString(), quantity: 1);
    await provider.cartAddItem(cartModel);
    if(provider.errorMessage==null){
      if(context.mounted){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const CartScreen()));
      await provider.cartFetchItem();
    }}
  }

  void buildUpdateButton(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UpdateProductScreen(
        product: product,
      );
    }));
  }

  Future<void> buildDeleteButton(BuildContext context) async {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    await provider.deleteProduct(product.id.toString());
    if (context.mounted) {
      if (provider.errorMessage == null) {
        Navigator.pop(context);
        AppUtil.showToast(
            ' ${product.name.toString()}, delete product SuccessFull');
        await provider.fetchProduct();
      }
    }
  }

  Padding buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Text(value,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
                textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }
  Padding buildImageRow(String label, String? imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          if (imageUrl != null && imageUrl.isNotEmpty)
            Flexible(
              child: Image.network(
                imageUrl,
                height: 100,
                width: 100,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image);
                },
              ),
            )
          else
            const Icon(Icons.image_not_supported),
        ],
      ),
    );
  }

}
