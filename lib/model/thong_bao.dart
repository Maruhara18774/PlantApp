class ThongBao{
  String? idGioHang;
  String? noidung;
  String? uid;
  String? ngay;

  ThongBao(
      {this.idGioHang,
        this.noidung, this.uid, this.ngay});
  factory ThongBao.fromJson(dynamic json) {
    return ThongBao(
        idGioHang: json['idGioHang'] as String,
        noidung: json['noidung'] as String,
        uid: json['uid'] as String,
        ngay: json['ngay'] as String
    );
  }
}
