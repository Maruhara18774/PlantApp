class YeuThich {
  String? id;
  String? idKhachHang;
  int? idSanPham;

  YeuThich(
      {this.id,
        this.idSanPham, this.idKhachHang});
  factory YeuThich.fromJson(dynamic json) {
    return YeuThich(
        id: json['id'] as String,
        idKhachHang: json['idKhachHang'] as String,
        idSanPham: json['idSanPham'] as int);
  }
}
