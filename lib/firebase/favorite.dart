import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maclemylinh_18dh110774/model/dia_chi.dart';
import 'package:maclemylinh_18dh110774/model/yeu_thich.dart';

class FavoriteFirebase {
  CollectionReference favorites =
  FirebaseFirestore.instance.collection('YEU_THICH');

  Future<void> Add(int idPro) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    DateTime now = DateTime.now();
    String id = DateFormat('yyyyMMddhhmmss').format(now);
    favorites.doc(id + uid).set({
      'id': id + uid,
      'idKhachHang': uid,
      'idSanPham': idPro
    });
  }
  Future<YeuThich> GetStatus(int idPro) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<YeuThich> itemList = [];
    var result = await favorites.where('idKhachHang', isEqualTo: uid).get();
    for (var i = 0; i < result.docs.length; i++) {
      itemList.add(YeuThich.fromJson(result.docs[i]));
    }
    YeuThich item = itemList.firstWhere((element) => element.idSanPham == idPro, orElse: () => new YeuThich(id: 'NULL'));
    return item;
  }

  Future<void> Remove(String id) async{
    FirebaseFirestore.instance.collection('YEU_THICH').doc(id).delete();
  }

  GetFavorites() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<YeuThich> itemList = [];
    var result = await favorites.where('idKhachHang', isEqualTo: uid).get();
    for (var i = 0; i < result.docs.length; i++) {
      itemList.add(YeuThich.fromJson(result.docs[i]));
    }
    return itemList;
  }
}
