import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maclemylinh_18dh110774/model/chi_tiet_gio_hang.dart';

class OrderDetailFirebase {
  CollectionReference orderdetails =
      FirebaseFirestore.instance.collection('CHI_TIET_GIO_HANG');

  Future<void> AddOrderDetail(
      String idOrder, int idProduct, int quantity, double total) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    DateTime now = DateTime.now();
    String currentDate = DateFormat('yyyyMMddhhmmss').format(now);
    orderdetails.doc(currentDate + uid).set({
      'id': currentDate + uid,
      'idGioHang': idOrder,
      'idSanPham': idProduct,
      'soLuong': quantity,
      'tongTien': total
    });
  }

  Future getListDetailOrder() async {
    List<ChiTietGioHang> itemList = [];
    final shoppingCartId =
        FirebaseFirestore.instance.collection('CHI_TIET_GIO_HANG');
    await shoppingCartId.get().then((value) => value.docs.forEach((element) {
          itemList.add(ChiTietGioHang.fromMap(element.data()));
        }));
    return itemList;
  }

  Future getDetailOrder(String? id) async {
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<ChiTietGioHang> itemList = [];
    var result = await orderdetails.where('id', isEqualTo: id).get();
    for (var i = 0; i < result.docs.length; i++) {
      itemList.add(ChiTietGioHang.fromJson(result.docs[i]));
    }
    return itemList;
  }
}
