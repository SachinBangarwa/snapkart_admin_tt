
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/core/app_util.dart';
import 'package:snapkart_admin/product/model/product_model.dart';
import 'package:snapkart_admin/product/provider/product_provider.dart';
import 'package:snapkart_admin/product/view/add_product_screen.dart';
import 'package:snapkart_admin/product/view/product_detail_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _GetProductScreenState();
}

class _GetProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  Future fetchProduct() async {
    ProductProvider provider =
        Provider.of<ProductProvider>(context, listen: false);
    await provider.fetchProduct();
    AppUtil.showToast(provider.errorMessage.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor:  const Color(0xFFE0F2F1),
        elevation: 0,
        title: const Text(
          ' Product',
          style: TextStyle(
  color: Colors.teal,
         fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: getBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0x546C4545),
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddProductScreen()));
        },
        heroTag: 'start',
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget getBody() {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        return Stack(
          children: [
            ListView.builder(
                itemCount: provider.productList.length,
                itemBuilder: (context, index) {
                  Product product = provider.productList[index];
                  return GestureDetector(
                      onHorizontalDragEnd: (detail) async {
                    if (detail.primaryVelocity! <= 0) {
                      final provider = Provider.of<ProductProvider>(context, listen: false);
                      await  provider.deleteProduct(product.id.toString());
                      await provider.fetchProduct();
                    }},
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          buildOnTabListTile(context, product);
                        },
                        leading:product.image != null && product.image!.isNotEmpty
                            ? Image.network(
                          product.image!,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image);
                          },
                        )
                            : const Icon(Icons.broken_image),
                        title: Text(
                          product.name.toString(),
                        ),
                        subtitle: Text('\$${product.price}'),
                        trailing: Text('${1 + index.toInt()}'),
                      ),
                    ),
                  );
                }),
            AppUtil.flutterSpinCit(provider),
          ],
        );
      },
    );
  }
}

void buildOnTabListTile(context, Product product) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailScreen(
                product: product,
              )));
}
