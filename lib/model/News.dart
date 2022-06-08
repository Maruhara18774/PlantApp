
class NewsXD {
  int? id;
  String? ten;
  String? hinhAnh;
  String? noidung;
  NewsXD({this.id, this.ten, this.hinhAnh, this.noidung});
  factory NewsXD.fromJson(Map<String,dynamic>json){
    return NewsXD(
      id: json['id'],
      ten: json['ten'],
      hinhAnh:json['hinhAnh'],
      noidung: json['noidung'],

    );
  }
}
