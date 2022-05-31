class GioHang {
  String? idGioHang;
  String? idGiaoHang;
  String? idKhachHang;
  String? ngayDat;
  String? tinhTrang;
  String? idKhuyenMai;
  double? tong;

  GioHang(
      {this.idGioHang,
      this.idGiaoHang,
      this.idKhachHang,
      this.ngayDat,
      this.tinhTrang,
      this.idKhuyenMai,
      this.tong});

  factory GioHang.fromMap(map) {
    return GioHang(
        idGioHang: map['idGioHang'] as String,
        idGiaoHang: map['idGiaoHang'] as String,
        idKhachHang: map['idKhachHang'] as String,
        ngayDat: map['ngayDat'] as String,
        tinhTrang: map['tinhTrang'] as String,
        idKhuyenMai: map['idKhuyenMai'],
        tong: map['tong'] as double);
  }
  Map<String, dynamic> toMap() {
    return {
      'idGioHang': idGioHang,
      'idGiaoHang': idGiaoHang,
      'idKhachHang': idKhachHang,
      'ngayDat': ngayDat,
      'tinhTrang': tinhTrang,
      'idKhuyenMai': idKhuyenMai,
      'tong': tong,
    };
  }
  factory GioHang.fromJson(dynamic json) {
    return GioHang(
        idGioHang: json['idGioHang'] as String,
        idGiaoHang: json['idGiaoHang'] as String,
        idKhachHang: json['idKhachHang'] as String,
        ngayDat: json['ngayDat'] as String,
        tinhTrang: json['tinhTrang'] as String,
        idKhuyenMai: json['idKhuyenMai'] as String,
        tong: json['tong'] as double,
    );
  }
}
