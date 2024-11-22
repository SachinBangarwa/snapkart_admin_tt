import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/category/model/category_model.dart';
import 'package:snapkart_admin/category/provider/category_provider.dart';
import 'package:snapkart_admin/category/view/add_category_screen.dart';

class GetCategoryScreen extends StatefulWidget {
  const GetCategoryScreen({super.key});

  @override
  State<GetCategoryScreen> createState() => _GetCategoryScreenState();
}

class _GetCategoryScreenState extends State<GetCategoryScreen> {
  @override
  void initState() {
    fetchCategory();
    super.initState();
  }

  Future fetchCategory() async {
    CategoryProvider provider =
        Provider.of<CategoryProvider>(context, listen: false);
    await provider.fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddCategoryScreen()));
          await fetchCategory();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        title: const Text(
          ' Category',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
              itemCount: provider.category.length,
              itemBuilder: (context, index) {
                CategoryModel value = provider.category[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      value.name.toString(),
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        await provider.deleteCategory(value);
                        await provider.fetchCategory();
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
