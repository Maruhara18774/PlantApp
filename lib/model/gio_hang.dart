class GioHang {
  int? id;
  int? idGiaoHang;
  String? idKhachHang;
  String? ngayDat;
  String? tinhTrang;
  double? tong;

  GioHang(
      {this.id,
      this.idGiaoHang,
      this.idKhachHang,
      this.ngayDat,
      this.tinhTrang,
      this.tong});

  factory GioHang.fromMap(map) {
    return GioHang(
        id: map['id'] as int,
        idGiaoHang: map['idGiaoHang'] as int,
        idKhachHang: map['idKhachHang'] as String,
        ngayDat: map['ngayDat'] as String,
        tinhTrang: map['tinhTrang'] as String,
        tong: map['tong'] as double);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idGiaoHang': idGiaoHang,
      'idKhachHang': idKhachHang,
      'ngayDat': ngayDat,
      'tinhTrang': tinhTrang,
      'tong': tong,
    };
  }
}
