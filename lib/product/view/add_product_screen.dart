import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/product/model/product_model.dart';
import 'package:snapkart_admin/product/provider/product_provider.dart';
class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        title: const Text(
          'Add Product',
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
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: addProductButton,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff851717),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15),
                ),
                child: const Text(
                  'Add Product',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addProductButton() async {
    String name = nameController.text;
    String description = descriptionController.text;
    int price = int.parse(priceController.text);
    String category = categoryController.text;

    ProductProvider provider =
    Provider.of<ProductProvider>(context, listen: false);

    Product product = Product(
      name: name,
      description: description,
      price: price,
      category: category,
    );
    await provider.addProduct(product);
   if(mounted){
    provider.addSuccess?
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Product added successfully!'),
        backgroundColor: Colors.green,
      ),
    ):ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Product added unsuccessfulFully!'),
        backgroundColor: Colors.green,
      ),
    );

   nameController.clear();
   descriptionController.clear();
   priceController.clear();
   categoryController.clear();
   Navigator.pop(context);
  }
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
