import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/firebase/user.dart';
import 'package:maclemylinh_18dh110774/global.dart';
import 'package:maclemylinh_18dh110774/model/chi_tiet_gio_hang.dart';
import 'package:maclemylinh_18dh110774/model/khach_hang.dart';
import 'package:maclemylinh_18dh110774/model/san_pham.dart';
import 'package:maclemylinh_18dh110774/screens/User/contact.dart';
import 'package:maclemylinh_18dh110774/screens/User/history.dart';
import 'package:maclemylinh_18dh110774/screens/User/love.dart';
import 'package:maclemylinh_18dh110774/screens/User/profile.dart';
import 'package:maclemylinh_18dh110774/screens/home.dart';
import 'package:maclemylinh_18dh110774/screens/login.dart';

import '../News/NewsList.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({Key? key}) : super(key: key);
  @override
  _UserDrawerState createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  KhachHang? loggedInuser;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    var result = await UserFirebase().getUser();
    setState(() {
      this.loggedInuser = result;
    });
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
                      child: this.loggedInuser != null
                          ? Image.network(this.loggedInuser!.avatar!)
                          : SizedBox()),
                ),
                Center(
                  child: this.loggedInuser != null
                      ? Text("${this.loggedInuser!.hoten}",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w500,
                              fontSize: 16))
                      : Text(""),
                ),
                Center(
                  child: this.loggedInuser != null
                      ? Text("${this.loggedInuser!.email}",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 12))
                      : Text(""),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              'Th??ng tin t??i kho???n',
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
              'L???ch s??? mua h??ng',
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
              'Y??u th??ch',
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
              leading: const Icon(Icons.newspaper),
              title: const Text(
                'Tin t???c',
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
              'Li??n h???',
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
              '????ng xu???t',
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
    currentUserGlb.uid = '';
    cartSanPhamGlb = List<SanPham>.empty(growable: true);
    cartCTGioHang = List<ChiTietGioHang>.empty(growable: true);
    Navigator.pushNamed(context, HomePage.routeName);
  }
}
