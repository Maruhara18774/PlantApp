import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/screens/Address/address.dart';

import '../../firebase/address.dart';

class NewAddressPage extends StatefulWidget {
  static String routeName = "/new-address";
  const NewAddressPage({Key? key}) : super(key: key);

  @override
  State<NewAddressPage> createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  String _name = "";
  String _phone = "";
  String _address = "";
  AddAddress(String name, String phoneNumber, String address) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    var result = await AddressFirebase().AddAddress(name,phoneNumber,address);
    Navigator.pushNamed(context, AddressPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 29, 86, 110),
        title: const Text("Thêm địa chỉ giao hàng"),
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Tên người nhận"),
                  onChanged: (value) {_name = value;},
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Số điện thoại"),
                  onChanged: (value) {_phone = value;},
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Địa chỉ"),
                  onChanged: (value) {_address = value;},
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      AddAddress(_name, _phone, _address);
                    },
                    child: const Text(
                      'Thêm địa chỉ',
                      style: TextStyle(fontSize: 15),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 33, 171, 165)),
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(MediaQuery.of(context).size.width, 60)),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
