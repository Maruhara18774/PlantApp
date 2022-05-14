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
              color: Colors.green,
              image: DecorationImage(image: NetworkImage('https://i.pinimg.com/originals/4d/39/96/4d39967cfaf52941188cd58860f990b4.jpg'),
              fit: BoxFit.fill)
            ),
            child: SizedBox(),
          ),
          ListTile(
            title: const Text('Đăng nhập'),
            onTap: () {
              Navigator.pushNamed(homeContext, LoginPage.routeName);
            },
          ),
          ListTile(
            title: const Text('Đăng ký'),
            onTap: () {
              Navigator.pushNamed(homeContext, RegisterPage.routeName);
            },
          ),
          ListTile(
            title: const Text('Liên hệ'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
