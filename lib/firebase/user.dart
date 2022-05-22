import 'package:cloud_firestore/cloud_firestore.dart';
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

}
