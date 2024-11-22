import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/auth/provider/auth_provider.dart';
import 'package:snapkart_admin/auth/service/auth_shared_preferences.dart';
import 'package:snapkart_admin/category/view/add_category_screen.dart';
import 'package:snapkart_admin/category/view/get_category_screen.dart';
import 'package:snapkart_admin/category/view/update_category_screen.dart';
import 'package:snapkart_admin/product/view/add_product_screen.dart';
import 'package:snapkart_admin/product/view/get_product_screen.dart';
import 'package:snapkart_admin/product/view/update_product_screen.dart';
import 'package:snapkart_admin/profile/profile_screen.dart';

class DeskBoardScreen extends StatefulWidget {
  const DeskBoardScreen({super.key});

  @override
  State<DeskBoardScreen> createState() => _DeskBoardScreenState();
}

class _DeskBoardScreenState extends State<DeskBoardScreen> {
  List<Widget> screens = [
    const GetProductScreen(),
    const UpdateProductScreen(),
    const GetCategoryScreen(),
    const UpdateCategoryScreen(),
    const ProfileScreen()
  ];

  int currentIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: bottomBar(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: currentIndex,
      children: screens,
    );
  }

  Widget bottomBar() {
    return BottomNavigationBar(
      elevation: 0,
      backgroundColor: Colors.grey.shade300,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_outlined),
          label: 'Products',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_outlined),
          label: 'Update Product',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.update_outlined),
          label: 'Update Category',
        ),BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xff851717),
      unselectedItemColor: Colors.grey.shade900,
      onTap: onItemTapped,
    );
  }
}
