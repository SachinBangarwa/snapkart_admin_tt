import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/category/model/category_model.dart';
import 'package:snapkart_admin/category/provider/category_provider.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final nameController = TextEditingController();
  final vController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        title: const Text(
          'Add Category',
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
            createTextField(vController, 'Enter vCategory'),
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
                  'Add Category',
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
    int v = int.parse(vController.text);

    CategoryProvider provider =
    Provider.of<CategoryProvider>(context, listen: false);

   CategoryModel category=CategoryModel(
     name: name,
     iV: v,
   );

    await provider.addCategory(category);
    if(mounted) {
      provider.success ?
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Category added successfully!'),
          backgroundColor: Colors.green,
        ),
      ) : ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Category added unsuccessfulFully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
      nameController.clear();
      vController.clear();

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
