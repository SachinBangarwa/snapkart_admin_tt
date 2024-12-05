import 'package:flutter/material.dart';
import 'package:snapkart_admin/category/view/category_screen.dart';
import 'package:snapkart_admin/profile/view/profile_view.dart';
import 'package:snapkart_admin/windowSports/adaptiveUI/product_home_screen.dart';

class HomeAdaptiveUi extends StatefulWidget {
  const HomeAdaptiveUi({super.key});

  @override
  State<HomeAdaptiveUi> createState() => _HomeAdaptiveUiState();
}

class _HomeAdaptiveUiState extends State<HomeAdaptiveUi> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: getBody(),
      ),
    );
  }

  Widget getBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children:[
              Expanded(flex: 2, child: buildHeader()),
              Expanded(flex: 2, child: buildTabBar()),
              const SizedBox(width: 20),
              const Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 2),
                    Icon(Icons.add_shopping_cart),
                    SizedBox(width: 2),
                    Icon(Icons.person),
                    SizedBox(width: 2),
                  ],
                ),
              )
            ],
          ),
        ),
        // Tab Content
        const Expanded(
          child: TabBarView(
            children: [
              ProductScreen(),
              CategoryScreen(),
              ProfileScreen(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildHeader() {
    return const Text(
      'Spick_Android',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildTabBar() {
    return const TabBar(
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.blue,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      tabs: [
        Tab(
          child: Text(
            "Product",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Tab(
          child: Text(
            "Category",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Tab(
          child: Text(
            "Profile",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}




