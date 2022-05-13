import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/model/san_pham.dart';

class ProductFirebase{
  CollectionReference products = FirebaseFirestore.instance.collection('SAN_PHAM');

  Future getAll() async {
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<SanPham> itemList = [];
    await products
        .get()
        .then((value) => value.docs.forEach((element) {
      itemList.add(SanPham.fromJson(element.data()));
    }));
    return itemList;
  }
}