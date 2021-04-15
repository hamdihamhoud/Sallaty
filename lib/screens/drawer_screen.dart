import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/auth.dart';

import 'catergories_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen();

  @override
  Widget build(BuildContext context) {
    // final admin = Provider.of<AuthProvider>(context).admin;
    return Drawer(
      child: Column(children: [
        AppBar(
          title:Text('ecart'),
          automaticallyImplyLeading: false,
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            Navigator.of(context)
                .pushReplacementNamed('/');
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
            // Navigator.of(context).pushNamed(.routeName);
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.location_on_rounded),
          title: const Text('Adresses'),
          onTap: () {
            // Navigator.of(context).pushNamed(.routeName);
          },
        ),
        const Divider(),
        // if (admin)
          // ListTile(
          //   leading: const Icon(Icons.edit),
          //   title: const Text('Your products'),
          //   onTap: () {
          //     Navigator.of(context)
          //         .pushNamed(.routeName);
          //   },
          // ),
        ListTile(
          leading: const Icon(Icons.feedback_outlined),
          title: const Text('Feedback'),
          onTap: () {
            // Navigator.of(context).pushNamed(.routeName);
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
            // Navigator.of(context).pushNamed(.routeName);
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.exit_to_app_rounded),
          title: const Text('Logout'),
          onTap: () {
            // Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/');
            // Provider.of<AuthProvider>(context, listen: false).logout();
          },
        )
      ]),
    );
  }
}
