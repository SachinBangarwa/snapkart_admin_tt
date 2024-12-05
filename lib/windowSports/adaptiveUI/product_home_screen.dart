import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/core/app_util.dart';
import 'package:snapkart_admin/product/model/product_model.dart';
import 'package:snapkart_admin/product/provider/product_provider.dart';
import 'package:snapkart_admin/product/view/add_product_screen.dart';
import 'package:snapkart_admin/product/view/update_product_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Product? selectedProduct;
  bool isLoadingProduct = false;

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  Future fetchProduct() async {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    setState(() {
     isLoadingProduct = true;}); // Start loading
    await provider.fetchProduct(); // Stop loading
    AppUtil.showToast(provider.errorMessage ?? 'Products loaded');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: isLoadingProduct
                ? const Center(
              child: SpinKitThreeBounce(
                color: Colors.red,
                size: 15,
              ),
            )
                : buildProductDetail(),
          ),
          // Right: Product List Section
          Expanded(
            flex: 3,
            child: getProductList(),
          ),
        ],
      ),
    );
  }

  Widget getProductList() {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
          itemCount: provider.productList.length,
          itemBuilder: (context, index) {
            final product = provider.productList[index];
            return Card(
              child: ListTile(
                onTap: () async {
                  setState(() {
                    isLoadingProduct = true;
                    selectedProduct = null;
                  });
                  await Future.delayed(const Duration(milliseconds: 1000)); // Simulate loading
                  setState(() {
                    selectedProduct = product;
                    isLoadingProduct = false;
                  });
                },
                title: Text(product.name ?? ''),
                subtitle: Text('\$${product.price}'),
                trailing: Text('#${index + 1}'),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildProductDetail() {
    if (selectedProduct == null) {
      return const Center(child: Text('Select a product to view details.'));
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name: ${selectedProduct!.name}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text('Price: \$${selectedProduct!.price}'),
          const SizedBox(height: 8),
         // Text('Category: ${selectedProduct!.categoryId ?? 'no id'}'),
          const SizedBox(height: 8),
          Text('Description: ${selectedProduct!.description ?? 'no dis'}'),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => buildDeleteProduct(),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateProductScreen(product: selectedProduct!),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void buildDeleteProduct() async {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    await provider.deleteProduct(selectedProduct!.id.toString());
    if (provider.errorMessage == null) {
      AppUtil.showToast('${selectedProduct!.name} deleted successfully');
      setState(() => selectedProduct = null);
      provider.fetchProduct();
    }
  }
}
