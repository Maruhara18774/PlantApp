import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
class NewsXD {
  int? id;
  String? nameNews;
  String? imageNews;
  String? detailNews;
  NewsXD({this.id, this.nameNews, this.imageNews, this.detailNews});
  factory NewsXD.fromJson(Map<String,dynamic>json){
    return NewsXD(
      id: json['id'],
      nameNews: json['ten'],
      imageNews:json['hinhAnh'],
      detailNews: json['noidung'],

    );
  }
}
