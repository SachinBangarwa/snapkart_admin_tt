import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateProductScreen(
                          product: product,
                        )));
              },
              icon: const Icon(Icons.auto_fix_normal_rounded ))
        ],
      ),
      body: Consumer<ProductProvider>(builder: (context, provider, child) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  buildRow('Name', product.name.toString()),
                  buildRow('Price', product.price.toString()),
               //   buildRow('Category', product.categoryId.toString()),
                  Text(product.description.toString()),
                ],
              ),
            ),
            Center(
              child: provider.isLoading
                  ? SpinKitThreeBounce(
                color: Colors.red,
                size: 15,
              )
                  : const SizedBox(),
            )
          ],
        );
      }),
    );
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
          Text(value),
        ],
      ),
    );
  }
}