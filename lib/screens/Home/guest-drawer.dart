import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/screens/User/contact.dart';
import 'package:maclemylinh_18dh110774/screens/login.dart';
import 'package:maclemylinh_18dh110774/screens/register.dart';

import '../News/NewsList.dart';

class GuestDrawer extends StatelessWidget {
  final BuildContext homeContext;
  const GuestDrawer({Key? key, required this.homeContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 29, 86, 110),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://icon-library.com/images/icon-user/icon-user-19.jpg')),
                  ),
                ),
              ],
            ),
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
              'Tin tức',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onTap: () {
              Navigator.pushNamed(homeContext, NewsState.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text(
              'Liên hệ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
