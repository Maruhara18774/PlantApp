import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
  class PromotionXD
{
  String? id;
  String? tenkhuyenmai;
  int? giamgia;
  Timestamp? ngaybatdau;
  Timestamp? ngayketthuc;
  String? trangthai;
  PromotionXD(
      {this.id,
        this.tenkhuyenmai,
        this.giamgia,
        this.ngaybatdau,
        this.ngayketthuc,
        this.trangthai});
  factory PromotionXD.fromJson(Map<String,dynamic>json){
    return PromotionXD(
      id: json['id'],
      tenkhuyenmai: json['tenkhuyenmai'],
      giamgia:json['giamgia'],
      ngaybatdau: json['ngaybatdau'],
      ngayketthuc: json['ngayketthuc'],
      trangthai : json['trangthai'],
    );
  }

}