class ChiTietGioHang {
  int? id;
  int? idGioHang;
  int? idSanPham;
  int? soLuong;
  double? tongTien;

  ChiTietGioHang(
      {this.id,
        this.idGioHang,
        this.idSanPham,
        this.soLuong,
        this.tongTien
      });

  factory ChiTietGioHang.fromMap(map) {
    return ChiTietGioHang(
        id: map['id'] as int,
        idGioHang: map['idGioHang'] as int,
        idSanPham: map['idSanPham'] as int,
        soLuong: map['soLuong'] as int,
        tongTien: map['tong'] as double);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idGioHang': idGioHang,
      'idSanPham': idSanPham,
      'soLuong': soLuong,
      'tongTien': tongTien,
    };
  }
}
