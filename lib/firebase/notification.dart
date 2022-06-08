import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maclemylinh_18dh110774/model/thong_bao.dart';
import 'package:maclemylinh_18dh110774/model/yeu_thich.dart';

class NotificationFirebase {
  CollectionReference notification =
  FirebaseFirestore.instance.collection('THONG_BAO');

  Future Add(String idOrd, String content) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    DateTime now = DateTime.now();
    String currentDate = DateFormat('yyyyMMddhhmmss').format(now);
    String currentDate2 = DateFormat('yyyy-MM-dd hh:mm:ss').format(now);
    notification.doc(currentDate + uid).set({
      'idGioHang': idOrd,
      'noidung': content,
      'uid': uid,
      'ngay': currentDate2
    });
  }

  GetNotis() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<ThongBao> itemList = [];
    var result = await notification.where('uid', isEqualTo: uid).get();
    for (var i = 0; i < result.docs.length; i++) {
      itemList.add(ThongBao.fromJson(result.docs[i]));
    }
    return itemList;
  }
}
