import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/model/khach_hang.dart';

class UserFirebase {
  CollectionReference users =
      FirebaseFirestore.instance.collection('KHACH_HANG');

  Future getAll() async {
    await Firebase.initializeApp();

    List<KhachHang> itemList = [];
    await users.get().then((value) => value.docs.forEach((element) {
          itemList.add(KhachHang.fromMap(element.data()));
        }));
    return itemList;
  }

  Future getUser() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();

    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<KhachHang> itemList = [];
    var result = await users.where('uid', isEqualTo: uid).get();
    for (var i = 0; i < result.docs.length; i++) {
      itemList.add(KhachHang.fromJson(result.docs[i]));
    }
    KhachHang item = itemList.firstWhere((element) => element.uid == uid);

    return item;
  }
}
