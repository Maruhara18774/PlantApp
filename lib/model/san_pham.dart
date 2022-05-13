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
        id: int.parse(json['id']),
        idLoadSP: int.parse(json['idLoaiSP']),
        ten: json['ten'],
        gia: int.parse(json['gia']),
        mota: json['mota'],
        hinhAnh: json['hinhAnh'],
        tinhtrang: int.parse(json['tinhtrang']));
  }
}