import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/category/model/category_model.dart';
import 'package:snapkart_admin/category/provider/category_provider.dart';

class UpdateCategoryScreen extends StatefulWidget {
  const UpdateCategoryScreen({super.key, required this.category});
final CategoryModel category;
  @override
  State<UpdateCategoryScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateCategoryScreen> {
  final nameController = TextEditingController();
  final ivController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textAsianController();
  }
  void textAsianController(){
    nameController.text=widget.category.name.toString();
    ivController.text=widget.category.iV.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Category',
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
            createTextField(nameController, 'Enter category name'),
            createTextField(ivController, 'Enter category iv'),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: updateProductButton,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0x806C4545),
                ),
                child: const Text(
                  'Update Category',
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
      sId: widget.category.sId,
      iV: int.parse(ivController.text)
    );
    CategoryProvider provider =
        Provider.of<CategoryProvider>(context, listen: false);

    await provider.updateCategory(category);
    if (mounted) {
      if (provider.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Category updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
        await provider.fetchCategory();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Category not update error '),
            backgroundColor: Colors.green,
          ),
        );
      }
      nameController.clear();
      ivController.clear();
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
