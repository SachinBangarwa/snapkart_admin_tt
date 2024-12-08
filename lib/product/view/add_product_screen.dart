import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final discountAmountController = TextEditingController();
  final categoryIdController = TextEditingController();
  final stockController = TextEditingController();
  final imageController = TextEditingController();

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
            createTextField(discountAmountController, 'Enter discountAmount'),
            createTextField(stockController, 'Enter stock'),
            createTextField(imageController, 'Enter image url'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: IconButton.styleFrom(
                     backgroundColor: const Color(0x806C4545),
                    padding: const EdgeInsets.symmetric(horizontal: 15)
                  ),
                    onPressed: () async {
                      await onTabGallery();
                    },
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.image,color: Colors.white,),
                        SizedBox(width: 5,),
                        Text(
                          'Gallery',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    )),
                ElevatedButton(
                  onPressed: addProductButton,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x806C4545)),
                  child: const Text(
                    'Add Product',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onTabGallery() async {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
   await provider.getImagePath(image);
    imageController.text=provider.path.toString();
  }

  void addProductButton() async {
    ProductProvider provider =
    Provider.of<ProductProvider>(context, listen: false);
    String name = nameController.text;
    String description = descriptionController.text;
    double price = double.parse(priceController.text);
    String category = categoryController.text;
    String image = imageController.text;
    double  discountAmount= double.parse(discountAmountController.text);
    int stock =int.parse (stockController.text);
    Product product = Product(
      name: name,
      description: description,
      price: price,
      categoryId: category,
      stock: stock,
      image: image,
      discountAmount: discountAmount,

    );
    await provider.addProduct(product);

    if (provider.isSuccess) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: "Add Product",
              message: product.name.toString(),
              contentType: ContentType.success,
            )));
        await provider.fetchProduct();
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'On Snap!',
              message: 'Product add unSuccess',
              contentType: ContentType.warning,
            )));
      }
      nameController.clear();
      descriptionController.clear();
      priceController.clear();
      categoryController.clear();
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
