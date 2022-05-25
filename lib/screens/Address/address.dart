import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/model/dia_chi.dart';
import 'package:maclemylinh_18dh110774/screens/Address/new-address.dart';
import 'package:maclemylinh_18dh110774/screens/checkout.dart';

import '../../firebase/address.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);
  static String routeName = "/address";

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  List<DiaChi> _list = [];
  @override
  void initState() {
    super.initState();
    FetchData();
  }

  FetchData() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    var result = await AddressFirebase().getAddresses();
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
        backgroundColor: const Color.fromARGB(255, 29, 86, 110),
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, CheckoutPage.routeName,arguments: "");
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Địa chỉ giao hàng"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: width,
          child: Column(
            children: [
              _list.isEmpty ? const Text('Hiện chưa có địa chỉ'):
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                    itemCount: _list.length,
                      itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 5.0,bottom: 5.0),
                      child: TextButton(onPressed: (){
                        Navigator.pushNamed(context, CheckoutPage.routeName,arguments: _list[index].id);
                      },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(side: const BorderSide(
                                color: Color.fromARGB(255, 29, 86, 110),
                                width: 1,
                                style: BorderStyle.solid
                            ), borderRadius: BorderRadius.circular(10.0))),
                          ),
                          child: SizedBox(
                            width: width-100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Text('Tên người nhận: '+_list[index].ten.toString(),
                                  style: const TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 15.0),
                                ),
                                const SizedBox(height: 5),
                                Text('Số điện thoại: '+_list[index].sdt.toString(),
                                  style: const TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 15.0),
                                ),
                                const SizedBox(height: 5),
                                Text('Địa chỉ: '+_list[index].diaChi.toString(),
                                  style: const TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 15.0),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          )
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewAddressPage.routeName);
        },
        backgroundColor: const Color.fromARGB(255, 29, 86, 110),
        child: const Icon(Icons.add),
      ),
    );
  }
}
