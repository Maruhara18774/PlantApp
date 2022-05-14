import 'package:flutter/material.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage('https://i.pinimg.com/originals/4d/39/96/4d39967cfaf52941188cd58860f990b4.jpg'),
                  fit: BoxFit.fitWidth
              ),

            ),
            child: CircleAvatar(
                backgroundImage: NetworkImage('https://media.istockphoto.com/photos/be-so-good-you-become-your-own-source-of-inspiration-picture-id1290528178?b=1&k=20&m=1290528178&s=170667a&w=0&h=ILOZEnHzV2WGCGHWzOl-nIgKsk_-GiysByzZ3ZGIFpk=')
            ),
          ),
          ListTile(
            title: const Text('Thông tin tài khoản'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Lịch sử mua hàng'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Yêu thích'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Liên hệ'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Đăng xuất'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
