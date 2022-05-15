import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/screens/login.dart';
import 'package:maclemylinh_18dh110774/screens/register.dart';

class GuestDrawer extends StatelessWidget {
  final BuildContext homeContext;
  const GuestDrawer({Key? key, required this.homeContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 29, 86, 110),
                image: DecorationImage(
                    image: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png'),
                    fit: BoxFit.fitHeight)),
            child: SizedBox(),
          ),
          ListTile(
            leading: const Icon(Icons.login),
            textColor: Color.fromARGB(255, 1, 1, 1),
            title: const Text(
              'Đăng nhập',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onTap: () {
              Navigator.pushNamed(homeContext, LoginPage.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.app_registration_rounded),
            title: const Text(
              'Đăng ký',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onTap: () {
              Navigator.pushNamed(homeContext, RegisterPage.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text(
              'Liên hệ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
