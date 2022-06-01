class KhachHang {
  String? uid;
  String? hoten;
  String? ngaysinh;
  String? email;
  String? sdt;
  String? avatar;

  KhachHang({
    this.uid,
    this.hoten,
    this.ngaysinh,
    this.email,
    this.sdt,
    this.avatar,
  });

  factory KhachHang.fromMap(map) {
    return KhachHang(
        uid: map['uid'],
        hoten: map['hoten'],
        ngaysinh: map['ngaysinh'],
        email: map['email'],
        sdt: map['sdt'],
        avatar: map['avatar']);
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'hoten': hoten,
      'ngaysinh': ngaysinh,
      'email': email,
      'sdt': sdt,
      'avatar': avatar,
    };
  }
  factory KhachHang.fromJson(dynamic json) {
    return KhachHang(
        uid: json['uid'] as String,
        hoten: json['hoten'] as String,
        ngaysinh: json['ngaysinh'] as String,
        email: json['email'] as String,
        sdt: json['sdt'] as String,
        avatar: json['avatar'] as String,
    );
  }
}
