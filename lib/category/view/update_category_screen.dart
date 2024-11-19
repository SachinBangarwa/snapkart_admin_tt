import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/category/model/category_model.dart';
import 'package:snapkart_admin/category/provider/category_provider.dart';
import 'package:snapkart_admin/product/provider/product_provider.dart';

class UpdateCategoryScreen extends StatefulWidget {
  const UpdateCategoryScreen({super.key});

  @override
  State<UpdateCategoryScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateCategoryScreen> {
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
      CategoryModel category = CategoryModel(
        name: nameController.text,
        sId: sIdController.text,
      );

      CategoryProvider provider =
      Provider.of<CategoryProvider>(context, listen: false);

      await provider.updateCategory(category);
      if(provider.success){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Category updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
  }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Category not update error !'),
            backgroundColor: Colors.green,
          ),
        );
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
