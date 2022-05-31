// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/model/loai_san_pham.dart';
import 'package:maclemylinh_18dh110774/model/san_pham.dart';

class ProductFirebase {
  CollectionReference products =
      FirebaseFirestore.instance.collection('SAN_PHAM');
  CollectionReference categories =
      FirebaseFirestore.instance.collection('LOAI_SAN_PHAM');

  //lấy sản phẩm list
  Future getAll() async {
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<SanPham> itemList = [];
    await products.get().then((value) => value.docs.forEach((element) {
          itemList.add(SanPham.fromJson(element.data()));
        }));
    return itemList;
  }

  //lấy loại sản phẩm list
  Future getAllCate() async {
    await Firebase.initializeApp();
    List<LoaiSP> listCategory = [];
    await categories.get().then((value) => value.docs.forEach((element) {
          listCategory.add(LoaiSP.fromJson(element.data()));
        }));

    return listCategory;
  }

  //lấy id sản phẩm
  Future getProductId(String? id) async {
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<SanPham> itemList = [];
    SanPham? item;
    await products.get().then((value) => value.docs.forEach((element) {
          (element) {
            itemList.add(SanPham.fromJson(element.data()));
          };
        }));
    List<SanPham> itemList1 =
        itemList.where((element) => element.id == id).toList();
    item = itemList1[0];
    return itemList1[0];
  }

  Future getCateProductList(String category) async {
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<SanPham> itemList = [];
    await products
        .where('idLoaiSP', isEqualTo: category)
        .get()
        .then((value) => value.docs.forEach((element) {
              itemList.add(SanPham.fromJson(element.data()));
            }));

    return itemList;
  }
  Future getProduct(int? id) async {
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<SanPham> itemList = [];
    var result = await products.where('id', isEqualTo:  id).get();
    for (var i = 0; i < result.docs.length; i++) {
      itemList.add(SanPham.fromJson(result.docs[i]));
    }
    SanPham item = itemList.firstWhere((element) => element.id == id);

    return item;
  }
}
