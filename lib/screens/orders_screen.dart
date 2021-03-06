import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show OrdersProvider;
import '../providers/auth.dart';
import '../widgets/order_item.dart';
import '../screens/drawer_screen.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      drawer: DrawerScreen(),
      body: FutureBuilder(
        future: auth.admin
            ? Provider.of<OrdersProvider>(context, listen: false).fetchOrders()
            : Provider.of<OrdersProvider>(context, listen: false)
                .fetchOrdersByUserId(auth.userId),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              return const Center(
                child: const Text('An error occurred!'),
              );
            } else {
              return Consumer<OrdersProvider>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
