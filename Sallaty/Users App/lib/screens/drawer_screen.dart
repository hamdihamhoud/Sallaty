import 'package:ecart/providers/cart.dart';
import 'package:ecart/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/auth.dart';
import 'orders_history_screen.dart';
import 'catergories_screen.dart';
import 'feedback.dart';
import 'adresses_screen.dart';
import 'settings_screen.dart';
import 'main_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
      width: MediaQuery.of(context).size.width * 0.77,
        child: Column(
          children: [
            AppBar(
              title: Text('Sallaty'),
              automaticallyImplyLeading: false,
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.store),
                    title: const Text('Store'),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(
                          AppBottomNavigationBarController.routeName);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.category_outlined),
                    title: const Text('Categories'),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(CategoriesScreen.routeName);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.receipt_long_rounded),
                    title: const Text('Orders History'),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(OrdersHistoryScreen.routeName);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.location_on_rounded),
                    title: const Text('Adresses'),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AddressesScreen.routeName);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.feedback_outlined),
                    title: const Text('Feedback'),
                    onTap: () {
                      Navigator.of(context).pushNamed(FeedbackScreen.routeName);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('About'),
                    onTap: () {
                      // Navigator.of(context).pushNamed(.routeName);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.of(context).pushNamed(SettingsScreen.routeName);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app_rounded),
                    title: const Text('Logout'),
                    onTap: () {
                      Provider.of<Cart>(context,listen: false).clearCart();
                      Provider.of<ProductsProvider>(context,listen: false).clearProducts();
                      Provider.of<AuthProvider>(context, listen: false)
                          .logout();
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
