import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/model/News.dart';

class FirNews{
  final newslist= FirebaseFirestore.instance.collection('TIN_TUC');

  Future getListNews()async {
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<NewsXD> itemList = [];

    await newslist.get().then((value) =>
        value.docs.forEach(
                (element) {
              itemList.add(NewsXD.fromJson(element.data()));
            }));

    return itemList;
  }

  }
