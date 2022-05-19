class LoaiSP {
  int? idCate;
  String? tenCate;
  String? imgCate;

  LoaiSP({this.idCate, this.tenCate, this.imgCate});
  factory LoaiSP.fromJson(dynamic json) {
    return LoaiSP(
        idCate: json['idCate'] as int,
        tenCate: json['tenCate'] as String,
        imgCate: json['imgCate'] as String);
  }
}
