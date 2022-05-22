import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/global.dart';
import 'package:maclemylinh_18dh110774/model/dia_chi.dart';

import '../firebase/address.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);
  static String routeName = "/address";

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  List<DiaChi> _list = [];
  // Create new Address fields
  String diaChi = "";
  String sdt = "";
  String ten = "";

  FetchData() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    var result = await AddressFirebase().getAddresses(currentUserGlb.uid);
    if (result == null) {
      print('unable');
    } else {
      setState(() {
        _list = result;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 29, 86, 110),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Địa chỉ giao hàng"),
      ),
      body: SafeArea(
        child: Container(
          width: width,
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
