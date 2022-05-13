class KhachHang {
  int? id;
  String? hoten;
  String? email;
  String? sdt;
  String? diachi;
  String? matkhau;
  int? diem;

  KhachHang(
      {this.id, this.hoten, this.email, this.sdt, this.diachi, this.matkhau,this.diem});

  factory KhachHang.fromJson(dynamic json) {
    return KhachHang(
        id: int.parse(json['id']),
        hoten: json['hoten'],
        email: json['email'],
        sdt: json['sdt'],
        diachi: json['diachi'],
        matkhau: json['matkhau'],
        diem: int.parse(json['diem']));
  }
}
