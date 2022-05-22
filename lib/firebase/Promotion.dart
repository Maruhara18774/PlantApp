import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/model/khuyen_mai.dart';
class DataPromotion{
  final promotionList= FirebaseFirestore.instance.collection("KHUYEN_MAI").where('trangthai',isEqualTo: "HOAT_DONG");
  Future getPromotionList()async{
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<PromotionXD> itemList=[];

    await promotionList.get().then((value) => value.docs.forEach(
            (element) {itemList.add(PromotionXD.fromJson(element.data()));}));

    return itemList;


  }
  Future getIDPromotion(String id)async{
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<PromotionXD> itemList=[];
    List<PromotionXD> itemList1=[];
    await promotionList.get().then((value) => value.docs.forEach(
            (element) {itemList.add(PromotionXD.fromJson(element.data()));}));
    itemList1=itemList.where((element) => element.id==id).toList();
    return itemList1;


  }
}