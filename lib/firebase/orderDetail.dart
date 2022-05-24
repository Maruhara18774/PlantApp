import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class OrderDetailFirebase{
  CollectionReference orderdetails = FirebaseFirestore.instance.collection('CHI_TIET_GIO_HANG');

  Future<void> AddOrderDetail(String idOrder, int idProduct, int quantity, double total) async {
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
}