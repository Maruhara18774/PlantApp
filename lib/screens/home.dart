import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maclemylinh_18dh110774/global.dart';
import 'package:maclemylinh_18dh110774/screens/Home/guest-drawer.dart';
import 'package:maclemylinh_18dh110774/screens/Home/home-fragment.dart';
import 'package:maclemylinh_18dh110774/screens/Home/notification-fragment.dart';
import 'package:maclemylinh_18dh110774/screens/Home/products-fragment.dart';
import 'package:maclemylinh_18dh110774/screens/Home/sale-fragment.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:maclemylinh_18dh110774/screens/Home/user-drawer.dart';
import 'package:maclemylinh_18dh110774/screens/cart.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  bool isLogin = false;
  List<Widget> screens = [
    HomeFragment(),
    ProductsFragment(),
    NotificationFragment(),
    Promotion()
  ];

  @override
  void initState() {
    super.initState();
    if (currentUserGlb.uid != '') {
      this.isLogin = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search_sharp)),
              IconButton(onPressed: () {
                if (currentUserGlb.uid != '') {
                  Navigator.pushNamed(context, CartPage.routeName);
                }
                else{
                  Fluttertoast.showToast(msg: "Vui lòng đăng nhập");
                }
              }, icon: Icon(Icons.shopping_basket))
            ],
            backgroundColor: Color.fromARGB(255, 29, 86, 110),
            title: const Center(
              child: Text(
                'Plants',
              ),
            )),
        body: screens[selectedIndex],
        bottomNavigationBar: GNav(
          rippleColor: Colors.white, // tab button ripple color when pressed
          hoverColor: Colors.white, // tab button hover color
          tabBorderRadius: 0,
          tabActiveBorder: Border.all(
              color: Color.fromARGB(255, 29, 86, 110),
              width: 1), // tab button border
          curve: Curves.decelerate,
          duration: Duration(milliseconds: 100), // tab animation duration
          gap: 8, // the tab button gap between icon and text
          color: Color.fromARGB(255, 255, 255, 255), // unselected icon color
          activeColor:
              Color.fromARGB(255, 22, 58, 95), // selected icon and text color
          iconSize: 30, // tab button icon size
          tabBackgroundColor: Colors.white, // selected tab background color
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: 10), // navigation bar padding,
          backgroundColor: Color.fromARGB(255, 29, 86, 110),
          tabs: [
            const GButton(
              icon: Icons.home,
              text: 'Trang chủ',
            ),
            GButton(
              icon: Icons.list,
              text: 'Sản phẩm',
            ),
            GButton(
              icon: Icons.notifications,
              text: 'Thông báo',
            ),
            GButton(
              icon: Icons.discount,
              text: 'Ưu đãi',
            )
          ],
          onTabChange: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        drawer:
            this.isLogin ? UserDrawer() : GuestDrawer(homeContext: context));
  }
}
