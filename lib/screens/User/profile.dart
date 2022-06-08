import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maclemylinh_18dh110774/model/khach_hang.dart';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  KhachHang infoUser = KhachHang();
  String imgfake = 'assets/anhdaidien.jpg';
  File? _image;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    await FirebaseFirestore.instance
        .collection("KHACH_HANG")
        .doc(user!.uid)
        .get()
        .then((value) {
      infoUser = KhachHang.fromMap(value.data());
      nameEditingController.text = infoUser.hoten!;
      emailEditingController.text = infoUser.email!;
      phoneEditingController.text = infoUser.sdt!;
      avtEditingController.text = infoUser.avatar!;
    });
    return infoUser;
  }

  // string for displaying the error Message
  String? errorMessage;
  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final nameEditingController = TextEditingController();
  final birthEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  final avtEditingController = TextEditingController();
  //setState
  String _name = "";
  String _birth = "";
  final String _email = "";
  final String _phone = "";
  final String _confirmPassword = "";
  final String _password = "";
  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  void updateUser() {
    FirebaseFirestore.instance.collection("KHACH_HANG").doc(user!.uid).update({
      'hoten': nameEditingController.text,
      'ngaysinh': _birth,
      'email': emailEditingController.text,
      'sdt': phoneEditingController.text,
    }).then((value) => null);
    Fluttertoast.showToast(msg: "Cập nhật thành công");
  }

  Future uploadPic(BuildContext context) async {
    String fileName = basename(_image!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(_image!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String imgUrl = await (await uploadTask).ref.getDownloadURL();
    FirebaseFirestore.instance.collection("KHACH_HANG").doc(user!.uid).update({
      'avatar': imgUrl,
    }).then((value) => null);
    setState(() {
      print("Profile Picture uploaded");
      Fluttertoast.showToast(msg: "Thay avt thành công");
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchData();
    print(infoUser.ngaysinh);
    print(infoUser.avatar);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Thông tin cá nhân'),
          backgroundColor: const Color.fromARGB(255, 29, 86, 110),
          leading: IconButton(
            alignment: Alignment.center,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? Column(
                            children: [
                              Align(
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                      radius: 100,
                                      backgroundColor:
                                          const Color.fromARGB(255, 255, 255, 255),
                                      child: ClipOval(
                                        child: SizedBox(
                                            width: 180.0,
                                            height: 180.0,
                                            child: (_image != null)
                                                ? Image.file(
                                                    _image!,
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.network(
                                                    "${infoUser.avatar}",
                                                    fit: BoxFit.fill,
                                                    scale: 4.5,
                                                  )),
                                      ))),
                              Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    getImage();
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                keyboardType: TextInputType.name,
                                controller: nameEditingController,
                                validator: (value) {
                                  RegExp regex = RegExp(r'^.{3,}$');
                                  if (value!.isEmpty) {
                                    return ("Vui lòng nhập đầy đủ họ tên");
                                  }
                                  if (!regex.hasMatch(value)) {
                                    return ("Vui lòng nhập họ tên trên 3 kí tự");
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Họ tên",
                                    prefixIcon: Icon(Icons.account_circle)),
                                onChanged: (value) {
                                  setState(() {
                                    _name = value;
                                  });
                                },
                                onSaved: (value) {
                                  nameEditingController.text = value!;
                                },
                              ),
                              const SizedBox(height: 5),
                              DateTimePicker(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Ngày sinh",
                                    prefixIcon: Icon(Icons.cake_outlined)),
                                  type: DateTimePickerType.date,
                                  initialValue: infoUser.ngaysinh,
                                  // controller: birthEditingController,
                                  dateMask: 'dd/MM/yyyy',
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  dateLabelText: 'Ngày sinh',
                                  onChanged: (value) {
                                    _birth = value;
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailEditingController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Vui lòng nhập email của bạn");
                                  }
                                  if (!RegExp(
                                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                      .hasMatch(value)) {
                                    return ("Vui lòng nhập email hợp lệ");
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Email",
                                    prefixIcon: Icon(Icons.email)),
                                onSaved: (value) {
                                  emailEditingController.text = value!;
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                controller: phoneEditingController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Vui lòng nhập sdt của bạn");
                                  }
                                  if (!RegExp(r'(84|0[3|5|7|8|9])+([0-9]{8})\b')
                                      .hasMatch(value)) {
                                    return ("Vui lòng nhập sdt hợp lệ");
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Số điện thoại",
                                    prefixIcon: Icon(Icons.ad_units)),
                                onSaved: (value) {
                                  phoneEditingController.text = value!;
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    updateUser();
                                    uploadPic(context);
                                  },
                                  child: const Text(
                                    'Cập nhật',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color.fromARGB(255, 29, 86, 110)),
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(Size(
                                            MediaQuery.of(context).size.width,
                                            60)),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          )
                        : const Text('Đang tải');
                  }),
            ),
          ),
        ));
  }
}
