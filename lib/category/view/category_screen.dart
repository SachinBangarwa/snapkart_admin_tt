import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/category/model/category_model.dart';
import 'package:snapkart_admin/category/provider/category_provider.dart';
import 'package:snapkart_admin/category/view/add_category_screen.dart';
import 'package:snapkart_admin/category/view/category_detail_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
        backgroundColor:  const Color(0x546C4545),
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
    centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFE0F2F1),
        elevation: 0,
        title: const Text(
          ' Category',
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
    fontSize: 24
          ),
        ),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
              itemCount: provider.category.length,
              itemBuilder: (context, index) {
                CategoryModel category = provider.category[index];
                return Card(
                  child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CategoryDetailScreen(category: category)));
                      },
                      title: Text(
                        category.name.toString(),
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      trailing: Text("${1 + index}")),
                );
              });
        },
      ),
    );
  }
}
