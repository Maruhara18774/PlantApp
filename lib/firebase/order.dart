import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class OrderFirebase{
  CollectionReference orders = FirebaseFirestore.instance.collection('GIO_HANG');

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
}