class SanPham{
  int? id;
  int? idLoadSP;
  String? ten;
  int? gia;
  String? mota;
  String? hinhAnh;
  int? tinhtrang;

  SanPham({this.id, this.idLoadSP, this.ten, this.gia, this.mota, this.hinhAnh, this.tinhtrang});
  factory SanPham.fromJson(dynamic json) {
    return SanPham(
        id: json['id'] as int,
        idLoadSP: json['idLoaiSP'] as int,
        ten: json['ten'] as String,
        gia: json['gia'] as int,
        mota: json['mota'] as String,
        hinhAnh: json['hinhAnh'] as String,
        tinhtrang: json['tinhtrang'] as int);
  }
}