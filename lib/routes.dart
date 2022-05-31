import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/screens/Address/new-address.dart';
import 'package:maclemylinh_18dh110774/screens/News/NewsList.dart';
import 'package:maclemylinh_18dh110774/screens/Address/address.dart';
import 'package:maclemylinh_18dh110774/screens/User/detailHis.dart';
import 'package:maclemylinh_18dh110774/screens/cart.dart';
import 'package:maclemylinh_18dh110774/screens/checkout.dart';
import 'package:maclemylinh_18dh110774/screens/home.dart';
import 'package:maclemylinh_18dh110774/screens/login.dart';
import 'package:maclemylinh_18dh110774/screens/register.dart';

final Map<String, WidgetBuilder> routes = {
  HomePage.routeName: (context) => const HomePage(),
  LoginPage.routeName: (context) => const LoginPage(),
  RegisterPage.routeName: (context) => const RegisterPage(),
  NewsState.routeName: (context) => const NewsState(),
  CheckoutPage.routeName: (context) => const CheckoutPage(),
  AddressPage.routeName: (context) => const AddressPage(),
  CartPage.routeName: (context) => const CartPage(),
  NewAddressPage.routeName: (context) => const NewAddressPage(),
  DetailHis.routeName: (context) => const DetailHis()
};
