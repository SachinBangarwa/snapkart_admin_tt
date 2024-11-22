import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/product/model/product_model.dart';
import 'package:snapkart_admin/product/provider/product_provider.dart';
import 'package:snapkart_admin/product/view/add_product_screen.dart';

class GetProductScreen extends StatefulWidget {
  const GetProductScreen({super.key});

  @override
  State<GetProductScreen> createState() => _GetProductScreenState();
}

class _GetProductScreenState extends State<GetProductScreen> {
  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  Future fetchProduct()async {
    ProductProvider provider =
        Provider.of<ProductProvider>(context, listen: false);
   await provider.fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     floatingActionButton: FloatingActionButton(
           onPressed: ()async {
           await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddProductScreen()));
         await  fetchProduct();
          },
         heroTag: "uniqueFABHeroTag",
          child: const Icon(Icons.add)),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        title: const Text(
          ' Product',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
            itemCount: provider.product.length,
            itemBuilder: (context, index) {
              Product product = provider.product[index];
              print(product.sId);
              return Card(
                child: ListTile(
                  title: Text(
                    product.name.toString(),
                  ),
                  subtitle: Text('\$${product.price}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(product.description.toString()),
                      const SizedBox(
                        width: 5,
                      ),
                      IconButton(
                          onPressed: () async {
                            await provider.deleteProduct(product);
                            await provider.fetchProduct();
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
