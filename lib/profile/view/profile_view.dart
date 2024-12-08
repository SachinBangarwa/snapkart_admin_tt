import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapkart_admin/auth/provider/auth_provider.dart';
import 'package:snapkart_admin/auth/view/login_screen.dart';
import 'package:snapkart_admin/order/model/order_item_model.dart';
import 'package:snapkart_admin/order/model/order_model.dart';
import 'package:snapkart_admin/order/provider/order_api_provider.dart';
import 'package:snapkart_admin/order/view/order_screen.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState

    Future.microtask(() {
      fetchUserOrders();
    });
    super.initState();
  }

  Future fetchUserOrders() async {
    final provider = Provider.of<OrderApiProvider>(context, listen: false);
    await provider.orderResponse();
  }
int value=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFE0F2F1),
          elevation: 0,
          title: const Text(
            'Profile',
            style: TextStyle(
              fontSize: 24,
              color: Colors.teal,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  final provider =
                  Provider.of<AuthProvider>(context, listen: false);
                  await provider.loggedOut();
                  if (provider.errorMessage == null) {
                    if (context.mounted) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    }
                  }
                },
                icon: const Center(child: Icon(Icons.logout))),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return OrderScreen();
                  }));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'On Snap!',
                      message:
                      'This is an example error message that will be shown in the body of snack bar!',
                      contentType: ContentType.warning,
                    ),
                  ));
                },
                icon: const Icon(
                  Icons.add,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              buildCountingOrder(),
              const SizedBox(
                height: 15,
              ),
              Consumer<OrderApiProvider>(
                  builder: (context, userProvider, child) {
                    return Expanded(
                      child: ListView.separated(
                        itemCount: userProvider.orderItemList.length,
                        itemBuilder: (context, index) {
                          Orders userOrder =
                          userProvider.orderItemList[index];
                         value= userProvider.orderItemList.length;
                          if (userOrder.items != null) {
                            return Column(
                                children:
                                List.generate(userOrder.items!.length, (value) {
                                  OrderItem orderItem = userOrder.items![value];
                                  return Card(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Number",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                userOrder.orderNumber.toString(),
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Divider(),
                                        buildOrdersDetail('name', orderItem.name),
                                        buildOrdersDetail('Price', orderItem.price),
                                        buildOrdersDetail(
                                            'Discount', orderItem.discountAmount),
                                        buildOrdersDetail(
                                            'Quantity', orderItem.quantity),
                                        buildOrdersDetail(
                                            'TotalPrice', orderItem.totalPrice),
                                      ],
                                    ),
                                  );
                                }));
                          } else {
                            const Text(
                              'NOT FOUND',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 30,
                              ),
                            );
                          }
                          return null;
                        },
                        separatorBuilder: (context, index) => const Divider(),
                      ),
                    );
                  }),
            ],
          ),
        ));
  }

  Container buildCountingOrder() {
    final provider = Provider.of<OrderApiProvider>(context, listen: false);
    final order = provider.orderItemList.length;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.indigoAccent),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: 'TotalOrders =',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white)),
                  TextSpan(
                      text: order.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white)),
                ])),
            RichText(
                text: const TextSpan(children: [
                  TextSpan(
                      text: 'PendingOrders =',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white)),
                  TextSpan(
                      text: '1',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white)),
                ]))
          ],
        ),
      ),
    );
  }

  Widget buildOrdersDetail(String text, label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text.toString(),
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            label.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
