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
}
