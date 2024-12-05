import 'package:flutter/material.dart';
import 'package:snapkart_admin/cart/view/cart_screen.dart';
import 'package:snapkart_admin/category/view/category_screen.dart';
import 'package:snapkart_admin/product/view/product_screen.dart';
import 'package:snapkart_admin/profile/view/profile_view.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DeskBoardScreenState();
}

class _DeskBoardScreenState extends State<DashBoardScreen> {
  List<Widget> screens = [
    const ProductScreen(),
    const CategoryScreen(),
    const CartScreen(),
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
          icon: Icon(Icons.category_outlined),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: 'Cart',
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
