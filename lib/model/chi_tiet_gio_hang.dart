class ChiTietGioHang {
  String? id;
  String? idGioHang;
  int? idSanPham;
  int? soLuong;
  double? tongTien;

  ChiTietGioHang(
      {this.id, this.idGioHang, this.idSanPham, this.soLuong, this.tongTien});

  factory ChiTietGioHang.fromMap(map) {
    return ChiTietGioHang(
        id: map['id'] as String,
        idGioHang: map['idGioHang'] as String,
        idSanPham: map['idSanPham'] as int,
        soLuong: map['soLuong'] as int,
        tongTien: map['tong'] as double?);
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
  factory ChiTietGioHang.fromJson(dynamic json) {
    return ChiTietGioHang(
        id: json['id'] as String,
        idGioHang: json['idGioHang'] as String,
        idSanPham: json['idSanPham'] as int,
        soLuong: json['soLuong'] as int,
        tongTien: json['tongTien'] as double);
  }
}
