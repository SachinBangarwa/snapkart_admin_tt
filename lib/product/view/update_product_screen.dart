import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/product/model/product_model.dart';
import 'package:snapkart_admin/product/provider/product_provider.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final sIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        title: Text(
          'Update Product',
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            createTextField(nameController, 'Enter product name'),
            createTextField(descriptionController, 'Enter description'),
            createTextField(priceController, 'Enter price'),
            createTextField(categoryController, 'Enter category'),
            createTextField(sIdController, 'Enter Product ID (S_ID)'),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: updateProductButton,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff851717),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15),
                ),
                child: const Text(
                  'Update Product',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateProductButton() async {
    Product product = Product(
      name: nameController.text,
      description: descriptionController.text,
      category: categoryController.text,
      price: int.parse(priceController.text),
      sId: sIdController.text,
    );

    ProductProvider provider =
    Provider.of<ProductProvider>(context, listen: false);

    await provider.updateProduct(product);
    if (mounted) {
      provider.updateSuccess ?
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product updated successfully!'),
          backgroundColor: Colors.green,
        ),
      ) :
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update product: '),
          backgroundColor: Colors.red,
        ),
      );
      await provider.fetchProduct();
    }
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    sIdController.clear();
    categoryController.clear();
  }

  Widget createTextField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

}
