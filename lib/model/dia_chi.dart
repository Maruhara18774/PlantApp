class DiaChi {
  String? id;
  String? ten;
  String? sdt;
  String? diaChi;
  String? idKhachHang;
  DiaChi(
      {this.id,
        this.ten,
        this.sdt,
        this.diaChi,
        this.idKhachHang});
  factory DiaChi.fromJson(dynamic json) {
    return DiaChi(
        id: json['id'],
        ten: json['ten'],
        sdt: json['sdt'],
        diaChi: json['diaChi'],
        idKhachHang: json['idKhachHang']);
  }
}
