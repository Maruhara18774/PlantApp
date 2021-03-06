import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maclemylinh_18dh110774/model/gio_hang.dart';

class OrderFirebase {
  CollectionReference orders =
      FirebaseFirestore.instance.collection('GIO_HANG');

  Future AddOrder(String idAddress, double total, String idPromotion) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    DateTime now = DateTime.now();
    String currentDate = DateFormat('yyyyMMddhhmmss').format(now);
    String currentDate2 = DateFormat('yyyy-MM-dd hh:mm:ss').format(now);
    orders.doc(currentDate + uid).set({
      'idGioHang': currentDate + uid,
      'idGiaoHang': idAddress,
      'ngayDat': currentDate2,
      'tinhTrang': 'New',
      'idKhachHang': uid,
      'idKhuyenMai': idPromotion,
      'tong': total
    });
    return currentDate + uid;
  }

  Future getListOrder(String id) async {
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<GioHang> itemList = [];
    final shoppingCartId = FirebaseFirestore.instance
        .collection('GIO_HANG')
        .where('idKhachHang', isEqualTo: id);
    await shoppingCartId.get().then((value) => value.docs.forEach((element) {
          itemList.add(GioHang.fromMap(element.data()));
        }));
    return itemList;
  }

  Future updateOrder(String idPro) async {
    String? id;
    String tinhTrang = 'Đã hủy';
    final shoppingCartId = FirebaseFirestore.instance
        .collection('GIO_HANG')
        .where('idGioHang', isEqualTo: idPro);
    await shoppingCartId.get().then((value) => value.docs.forEach((element) {
          id = element.id;
        }));
    // print(shoppingCartId.id);
    FirebaseFirestore.instance
        .collection('GIO_HANG')
        .doc(id)
        .update({'tinhTrang': tinhTrang});
  }

  Future getOrder(String? id) async {
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<GioHang> itemList = [];
    var result = await orders.where('idGioHang', isEqualTo: id).get();
    for (var i = 0; i < result.docs.length; i++) {
      itemList.add(GioHang.fromJson(result.docs[i]));
    }
    GioHang item = itemList.firstWhere((element) => element.idGioHang == id);

    return item;
  }

  Future cancelOrder(String idOrder) async {
    String tinhTrang = 'Cancel';
    final shoppingCartId = FirebaseFirestore.instance
        .collection('GIO_HANG')
        .where('idGioHang', isEqualTo: idOrder);
    await shoppingCartId.get().then((value) => value.docs.forEach((element) {
      idOrder = element.id;
    }));
    // print(shoppingCartId.id);
    FirebaseFirestore.instance
        .collection('GIO_HANG')
        .doc(idOrder)
        .update({'tinhTrang': tinhTrang});
  }
}
