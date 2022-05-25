import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/model/khach_hang.dart';
import 'package:maclemylinh_18dh110774/screens/User/contact.dart';
import 'package:maclemylinh_18dh110774/screens/User/history.dart';
import 'package:maclemylinh_18dh110774/screens/User/love.dart';
import 'package:maclemylinh_18dh110774/screens/User/profile.dart';
import 'package:maclemylinh_18dh110774/screens/login.dart';

import '../News/NewsList.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({Key? key}) : super(key: key);
  @override
  _UserDrawerState createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  // final String currentUserId = currentUserId?.uid;
  User? user = FirebaseAuth.instance.currentUser;
  KhachHang loggedInuser = KhachHang();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    await FirebaseFirestore.instance
        .collection("KHACH_HANG")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInuser = KhachHang.fromMap(value.data());
      setState(() {});
    });
    return loggedInuser;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 29, 86, 110),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: SizedBox(
                      height: 90,
                      width: 90,
                      // child: CircleAvatar(
                      //     backgroundImage:
                      //         NetworkImage('${loggedInuser.avatar}')),

                      child: FutureBuilder(
                        future: fetchData(),
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? CircleAvatar(
                                  backgroundImage:
                                      NetworkImage('${loggedInuser.avatar}'))
                              : Image.asset('assets/anhdaidien.jpg');
                        },
                      )),
                ),
                Center(
                  child: Text("${loggedInuser.hoten}",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500,
                          fontSize: 16)),
                ),
                Center(
                  child: Text("${loggedInuser.email}",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              'Thông tin tài khoản',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text(
              'Lịch sử mua hàng',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.heart_broken),
            title: const Text(
              'Yêu thích',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LovePage()),
              );
            },
          ),
          ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text(
                'Tin tức',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewsState()),
                );
              }),
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
            // onTap: () async {
            //   await launch(
            //       'mailto:${loggedInuser.email}?subject=Thuc hanh mail&body=Quang Linh');
            // },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              'Đăng xuất',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onTap: () {
              logout(context);
            },
          ),
        ],
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
