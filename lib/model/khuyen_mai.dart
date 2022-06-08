
import 'package:cloud_firestore/cloud_firestore.dart';
  class PromotionXD
{
  String? id;
  String? ten;
  int? giamgia;
  String? ngaybd;
  String? ngaykt;
  int? trangthai;
  PromotionXD(
      {this.id,
        this.ten,
        this.giamgia,
        this.ngaybd,
        this.ngaykt,
        this.trangthai});
  factory PromotionXD.fromJson(Map<String,dynamic>json){
    return PromotionXD(
      id: json['id'],
      ten: json['ten'],
      giamgia:json['giamgia'],
      ngaybd: json['ngaybd'],
      ngaykt: json['ngaykt'],
      trangthai : json['trangthai'],
    );
  }
  factory PromotionXD.fromJson1(dynamic json) {
    return PromotionXD(
      id: json['id'],
      ten: json['ten'],
      giamgia:json['giamgia'],
      ngaybd: json['ngaybd'],
      ngaykt: json['ngaykt'],
      trangthai : json['trangthai'],
    );
  }
}