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
import 'package:maclemylinh_18dh110774/screens/Address/address.dart';
import 'package:maclemylinh_18dh110774/screens/cart.dart';

import '../global.dart';
import '../model/khuyen_mai.dart';

class CheckoutPage extends StatefulWidget {
  static String routeName = "/checkout";
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<ChiTietGioHang> _listCTGH = [];
  List<SanPham> _listSP = [];
  DiaChi? _diaChi = null;
  double sum = 0;
  String? _voucher = null;
  PromotionXD? promotion = null;
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
    if(idDiaChi!= null && idDiaChi != "" && _diaChi == null){
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
            Navigator.pushNamed(context, CartPage.routeName);
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
                          Text('Vui lòng chọn địa chỉ'),
                        ],
                      ): Row(
                    children: [
                      Container(
                        width: width-20,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color.fromARGB(255, 29, 86, 110)),
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 5, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Text('Tên người nhận: '+_diaChi!.ten.toString(),
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 15.0),
                              ),
                              SizedBox(height: 5),
                              Text('Số điện thoại: '+_diaChi!.sdt.toString(),
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 15.0),
                              ),
                              SizedBox(height: 5),
                              Text('Địa chỉ: '+_diaChi!.diaChi.toString(),
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 15.0),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                this._listSP[index].ten!,
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(height: 5),
                              Text(
                                  this._listSP[index].gia.toString() +
                                      " VND x "+this._listCTGH[index].soLuong.toString(),
                                  maxLines: 5,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal)),
                              SizedBox(height: 5),
                              Text('Tổng: ' + this._listCTGH[index].tongTien.toString())
                            ],
                          ),
                        )
                      ],
                    );
                  }),
              Text('Giảm giá: -'+(promotion == null ? '0 VND':((promotion!.giamgia!.toDouble()*sum)/100).toString())),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Text('Mã giảm giá: ',style: TextStyle(fontSize: 15.0),),
                    Container(
                      width: width - 200,
                      height: 60,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Mã giảm giá"),
                        onChanged: (value) {_voucher = value;},
                      ),
                    ),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.add_circle_outline))
                  ],
                ),
              ),
            ])),
      ),
    );
  }
}
