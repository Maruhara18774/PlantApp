import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/screens/News/NewsList.dart';
import 'package:maclemylinh_18dh110774/screens/address.dart';
import 'package:maclemylinh_18dh110774/screens/cart.dart';
import 'package:maclemylinh_18dh110774/screens/checkout.dart';
import 'package:maclemylinh_18dh110774/screens/home.dart';
import 'package:maclemylinh_18dh110774/screens/login.dart';
import 'package:maclemylinh_18dh110774/screens/register.dart';

final Map<String, WidgetBuilder> routes = {
  HomePage.routeName: (context) => HomePage(),
  LoginPage.routeName: (context) => LoginPage(),
  RegisterPage.routeName: (context) => RegisterPage(),
  NewsState.routeName: (context) => NewsState(),
  CheckoutPage.routeName: (context) => CheckoutPage(),
  AddressPage.routeName: (context) => AddressPage(),
  CartPage.routeName: (context) => CartPage(),
};
