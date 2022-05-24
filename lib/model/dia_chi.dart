import 'package:flutter/material.dart';

class DiaChi {
  String? id;
  String? ten;
  String? sdt;
  String? diaChi;
  String? idKhachHang;
  DiaChi(
      {this.id,
        this.ten,
        this.sdt,
        this.diaChi,
        this.idKhachHang});
  factory DiaChi.fromJson(dynamic json) {
    return DiaChi(
        id: json['id'] as String,
        ten: json['ten'] as String,
        sdt: json['sdt'] as String,
        diaChi: json['diaChi'] as String,
        idKhachHang: json['idKhachHang'] as String);
  }
}
