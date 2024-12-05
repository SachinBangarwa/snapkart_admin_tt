import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/core/app_util.dart';
import 'package:snapkart_admin/product/model/product_model.dart';
import 'package:snapkart_admin/product/provider/product_provider.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});
  final Product product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final discountAmountController = TextEditingController();
  final categoryIdController = TextEditingController();
  final stockController = TextEditingController();
  final imageController = TextEditingController();
@override
  void initState() {
   textAsianController();
    super.initState();
  }

void textAsianController() {
   nameController.text=widget.product.name.toString();
  descriptionController.text=widget.product.description.toString();
  priceController.text=widget.product.price.toString();
  //categoryController.text=widget.product.categoryId.toString();
  discountAmountController.text=widget.product.discountAmount.toString();
  //categoryIdController.text=widget.product.categoryId.toString();
  stockController.text=widget.product.stock.toString();
  imageController.text=widget.product.image.toString();

}
@override
  void dispose() {
    // TODO: implement dispose
  nameController.dispose();
  discountAmountController.dispose();
  descriptionController.dispose();
  stockController.dispose();
  imageController.dispose();
  categoryController.dispose();
  priceController.dispose();
  categoryIdController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Product',
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
            createTextField(imageController, 'Enter image'),
            createTextField(categoryIdController, 'Enter categoryId'),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: updateProductButton,
                style:ElevatedButton.styleFrom(
                  backgroundColor:  const Color(0x806C4545),
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
    categoryId: categoryController.text,
      price: double.parse(priceController.text),
      stock: int.parse(stockController.text),
      discountAmount: double.parse(discountAmountController.text),
      image: imageController.text,
      id: widget.product.id,
    );

    ProductProvider provider =
    Provider.of<ProductProvider>(context, listen: false);
    await provider.updateProduct(product);
    if(mounted){
      if(provider.isSuccess){
        Navigator.pop(context);
        AppUtil.showToast('Product update');
       await provider.fetchProduct();
      }
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
