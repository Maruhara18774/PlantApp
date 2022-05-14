import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/global.dart';
import 'package:maclemylinh_18dh110774/screens/Home/guest-drawer.dart';
import 'package:maclemylinh_18dh110774/screens/Home/home-fragment.dart';
import 'package:maclemylinh_18dh110774/screens/Home/news-fragment.dart';
import 'package:maclemylinh_18dh110774/screens/Home/products-fragment.dart';
import 'package:maclemylinh_18dh110774/screens/Home/sale-fragment.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:maclemylinh_18dh110774/screens/Home/user-drawer.dart';

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
    NewsFragment(),
    SaleFragment()
  ];

  @override
  void initState() {
    super.initState();
    if(currentUserGlb.id != -1){
      this.isLogin = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: screens[selectedIndex],
      bottomNavigationBar: GNav(
          rippleColor: Colors.white, // tab button ripple color when pressed
          hoverColor: Colors.white, // tab button hover color
          tabBorderRadius: 0,
          tabActiveBorder: Border.all(color: Colors.green, width: 1), // tab button border
          curve: Curves.decelerate,
          duration: Duration(milliseconds: 100), // tab animation duration
          gap: 8, // the tab button gap between icon and text
          color: Colors.grey[800], // unselected icon color
          activeColor: Colors.green, // selected icon and text color
          iconSize: 30, // tab button icon size
          tabBackgroundColor: Colors.white, // selected tab background color
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // navigation bar padding,
          backgroundColor: Colors.green,
          tabs: [
            const GButton(
              icon: Icons.apps_sharp,
              text: 'Trang chủ',
            ),
            GButton(
              icon: Icons.clean_hands,
              text: 'Sản phẩm',
            ),
            GButton(
              icon: Icons.announcement,
              text: 'Tin tức',
            ),
            GButton(
              icon: Icons.whatshot,
              text: 'Ưu đãi',
            )
          ],
        onTabChange: (index){
            setState(() {
              selectedIndex = index;
            });
        },
      ),
      drawer: this.isLogin ? UserDrawer() : GuestDrawer(homeContext: context,)
    );
  }
}
