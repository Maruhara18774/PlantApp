import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/firebase/address.dart';
import 'package:maclemylinh_18dh110774/firebase/user.dart';
import 'package:maclemylinh_18dh110774/model/chi_tiet_gio_hang.dart';
import 'package:maclemylinh_18dh110774/model/dia_chi.dart';
import 'package:maclemylinh_18dh110774/model/khach_hang.dart';
import 'package:maclemylinh_18dh110774/model/san_pham.dart';
import 'package:maclemylinh_18dh110774/screens/address.dart';
import 'package:maclemylinh_18dh110774/screens/cart.dart';

import '../global.dart';

class CheckoutPage extends StatefulWidget {
  static String routeName = "/checkout";
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<ChiTietGioHang> _listCTGH = [];
  List<SanPham> _listSP = [];
  DiaChi? _diaChi;
  double sum = 0;
  KhachHang? currentCus;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    _listCTGH = cartCTGioHang;
    _listSP = cartSanPhamGlb;
    _listCTGH.forEach((detail) {
      sum = sum + detail.tongTien!;
    });
  }
  FetchData(String idDiaChi) async {
    if(idDiaChi!= null && idDiaChi != ""){
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      var result = await AddressFirebase().getAddress(idDiaChi);
      if (result == null) {
        print('unable');
      } else {
        setState(() {
          _diaChi = result;
        });
      }
    }
    else{
      FirebaseFirestore.instance
          .collection("KHACH_HANG")
          .doc(user!.uid)
          .get()
          .then((value) {
        this.currentCus = KhachHang.fromMap(value.data());
        currentUserGlb = KhachHang.fromMap(value.data());
      });
      setState(() {
        _diaChi = null;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final args = ModalRoute.of(context)!.settings.arguments as String;
    FetchData(args);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 29, 86, 110),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Thanh toán"),
      ),
      bottomNavigationBar: Row(
        children: [
          Container(
            width: (width*30)/100,
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, CartPage.routeName);
              },
              child: Text("Hủy"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      )
                  )
              ),
            ),
          ),
          Container(
            width: (width*70)/100,
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {

              },
              child: Text("Xác nhận thanh toán"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 29, 86, 110)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      )
                  )
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              TextButton(onPressed: (){
                Navigator.pushNamed(context, AddressPage.routeName);
              },
                  child: _diaChi == null ?
                      Row(
                        children: [
                          Text(currentCus!.hoten.toString()),
                          Text(currentCus!.sdt.toString()),
                        ],
                      ): Row()
              ),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _listSP.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        SizedBox(height: 5),
                        SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.network(this._listSP[index].hinhAnh!)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          height: 100,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                this._listSP[index].ten!,
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                  this._listSP[index].gia.toString() +
                                      " VND",
                                  maxLines: 5,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal)),
                              Padding(
                                padding: const EdgeInsets.only(left: 60.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ElevatedButton(onPressed: (){
                                      this.setState(() {
                                        if((_listCTGH[index].soLuong! - 1)!= 0){
                                          _listCTGH[index].soLuong = _listCTGH[index].soLuong! - 1;
                                          _listCTGH[index].tongTien = _listCTGH[index].soLuong!*_listSP[index].gia!.toDouble();
                                          sum = sum - _listSP[index].gia!.toDouble();
                                        }
                                        else{
                                          sum = sum - _listSP[index].gia!.toDouble();
                                          _listSP.removeAt(index);
                                          _listCTGH.removeAt(index);
                                        }
                                      });
                                    },
                                      child: Icon(Icons.remove,color: Colors.black,),
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white),
                                          elevation: MaterialStateProperty.all(0)),),
                                    const SizedBox(width: 10,),
                                    Text(_listCTGH[index].soLuong.toString()),
                                    const SizedBox(width: 10,),
                                    ElevatedButton(onPressed: (){
                                      this.setState(() {
                                        _listCTGH[index].soLuong = _listCTGH[index].soLuong! + 1;
                                        _listCTGH[index].tongTien = _listCTGH[index].tongTien! + _listSP[index].gia!.toDouble();
                                        sum = sum + _listSP[index].gia!.toDouble();
                                      });

                                    },
                                      child: Icon(Icons.add,color: Colors.black,),
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white),
                                          elevation: MaterialStateProperty.all(0)),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }),

            ])),
      ),
    );
  }
}
