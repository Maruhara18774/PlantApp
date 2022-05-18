import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maclemylinh_18dh110774/model/khach_hang.dart';
import 'package:maclemylinh_18dh110774/screens/home.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  KhachHang infoUser = KhachHang();
  File? _image;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("KHACH_HANG")
        .doc(user!.uid)
        .get()
        .then((value) {
      infoUser = KhachHang.fromMap(value.data());
      nameEditingController.text = infoUser.hoten!;
      birthEditingController.text = infoUser.ngaysinh!;
      emailEditingController.text = infoUser.email!;
      phoneEditingController.text = infoUser.sdt!;
      avtEditingController.text = infoUser.avatar!;
    });
  }

  // string for displaying the error Message
  String? errorMessage;
  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final nameEditingController = new TextEditingController();
  final birthEditingController =
      new TextEditingController(text: DateTime.now().toString());
  final emailEditingController = new TextEditingController();
  final phoneEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  final avtEditingController = new TextEditingController();
  //setState
  String _name = "";
  String _birth = "";
  String _email = "";
  String _phone = "";
  String _confirmPassword = "";
  String _password = "";
  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        _image = File(image!.path);
      });
    }

    void updateUser() {
      FirebaseFirestore.instance
          .collection("KHACH_HANG")
          .doc(user!.uid)
          .update({
        'hoten': nameEditingController.text,
        'ngaysinh': birthEditingController.text,
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
      FirebaseFirestore.instance
          .collection("KHACH_HANG")
          .doc(user!.uid)
          .update({
        'avatar': imgUrl,
      }).then((value) => null);
      setState(() {
        print("Profile Picture uploaded");
        Fluttertoast.showToast(msg: "Thay avt thành công");
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
        backgroundColor: Color.fromARGB(255, 29, 86, 110),
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
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    child: ClipOval(
                      child: new SizedBox(
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
                              ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      size: 30.0,
                    ),
                    onPressed: () {
                      getImage();
                    },
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: nameEditingController,
                  validator: (value) {
                    RegExp regex = new RegExp(r'^.{3,}$');
                    if (value!.isEmpty) {
                      return ("Vui lòng nhập đầy đủ họ tên");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Vui lòng nhập họ tên trên 3 kí tự");
                    }
                    return null;
                  },
                  decoration: InputDecoration(
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
                SizedBox(height: 5),
                DateTimePicker(
                    type: DateTimePickerType.date,
                    controller: birthEditingController,
                    dateMask: 'dd/MM/yyyy',
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    dateLabelText: 'Ngày sinh',
                    onChanged: (value) {
                      birthEditingController.text = value;
                    }),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailEditingController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Vui lòng nhập email của bạn");
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Vui lòng nhập email hợp lệ");
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email)),
                  onSaved: (value) {
                    emailEditingController.text = value!;
                  },
                ),
                SizedBox(
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
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Số điện thoại",
                      prefixIcon: Icon(Icons.ad_units)),
                  onSaved: (value) {
                    phoneEditingController.text = value!;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      updateUser();
                      uploadPic(context);
                    },
                    child: Text(
                      'Cập nhật',
                      style: TextStyle(fontSize: 15),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 4, 20, 250)),
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(MediaQuery.of(context).size.width, 60)),
                    )),
                SizedBox(
                  height: 10,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
      ),
    );
  }
}
