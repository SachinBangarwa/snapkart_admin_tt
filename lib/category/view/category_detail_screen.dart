import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/category/model/category_model.dart';
import 'package:snapkart_admin/category/provider/category_provider.dart';
import 'package:snapkart_admin/category/view/update_category_screen.dart';
import 'package:snapkart_admin/core/app_util.dart';

class CategoryDetailScreen extends StatelessWidget {
  const CategoryDetailScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category Detail"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.name.toString(),
                            ),
                            Text(
                              "delete",
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsets.zero,
                        actions: [
                          TextButton(onPressed: () async {
                            await deleteCategoryButton(context);
                          }, child: Consumer<CategoryProvider>(
                              builder: (context, provider, child) {
                            return provider.isLoading
                                ? const SpinKitThreeBounce(
                                    color: Colors.red,
                                    size: 13,
                                  )
                                : Text('yes');
                          })),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'no',
                              )),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateCategoryScreen(
                              category: category,
                            )));
              },
              icon: const Icon(Icons.auto_fix_normal_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(category.name.toString()),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Sid",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(category.iV.toString()),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> deleteCategoryButton(BuildContext context) async {
    final provider = Provider.of<CategoryProvider>(context, listen: false);
    await provider.deleteCategory(category.sId.toString());
    if (context.mounted) {
      if (provider.success) {
        AppUtil.showToast(' ${category.name}, Category Delete');
        Navigator.pop(context);
        await provider.fetchCategory();
      }
    }
  }
}
