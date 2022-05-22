import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maclemylinh_18dh110774/model/dia_chi.dart';
import 'package:maclemylinh_18dh110774/model/khach_hang.dart';

class AddressFirebase{
  CollectionReference addresses =
  FirebaseFirestore.instance.collection('DIA_CHI');

  Future<void> AddAddress(String name, String phoneNumber, String address) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    DateTime now = DateTime.now();
    String id = DateFormat('yyyyMMddhhmmss').format(now);
    addresses.doc(id + uid).set({
      'id': id + uid,
      'ten': name,
      'sdt': phoneNumber,
      'diaChi': address,
      'idKhachHang': uid
    });
  }

  Future getAddresses(String? uid) async {
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<DiaChi> itemList = [];
    await addresses.get().then((value) => value.docs.forEach((element) {
          (element) {
        itemList.add(DiaChi.fromJson(element.data()));
      };
    }));
    List<DiaChi> itemList1 = itemList.where((element) => element.idKhachHang == uid).toList();
    return itemList1;
  }
  Future getAddress(String? id) async {
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<DiaChi> itemList = [];
    await addresses.get().then((value) => value.docs.forEach((element) {
          (element) {
        itemList.add(DiaChi.fromJson(element.data()));
      };
    }));
    DiaChi item = itemList.firstWhere((element) => element.id == id);
    return item;
  }
}