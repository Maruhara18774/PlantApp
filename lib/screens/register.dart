import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maclemylinh_18dh110774/global.dart';
import 'package:maclemylinh_18dh110774/model/khach_hang.dart';
import 'package:maclemylinh_18dh110774/screens/home.dart';

class RegisterPage extends StatefulWidget {
  static String routeName = "/register";
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  // string for displaying the error Message
  String? errorMessage;
  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final nameEditingController = TextEditingController();
  final birthEditingController =
      TextEditingController(text: DateTime.now().toString());
  final emailEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  final avtEditingController = TextEditingController(
      text:
          "https://i.pinimg.com/474x/76/4d/59/764d59d32f61f0f91dec8c442ab052c5.jpg");
  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        birthEditingController.text = '2002-11-22';
      });
    });
  }

  //setState
  String _name = "";
  final String _birth = "";
  final String _email = "";
  final String _phone = "";
  final String _confirmPassword = "";
  final String _password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                    key: _formKey,
                    child: const Image(
                        image: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/449/449350.png',
                            scale: 4.5))),
                const Text('Plants',
                    style: TextStyle(
                        color: Color.fromARGB(255, 33, 171, 165),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
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
                  type: DateTimePickerType.date,
                  // controller: birthEditingController,
                  dateMask: 'dd/MM/yyyy',
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Ngày sinh',
                  onChanged: (value) =>
                      setState(() => birthEditingController.text = value),
                  // validator: (value) {
                  //   setState(() => _birth = value ?? '');
                  //   return null;
                  // },
                  // onSaved: (value) {
                  //   birthEditingController.text = value!;
                  // },
                ),
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
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
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
                TextFormField(
                  controller: passwordEditingController,
                  obscureText: true,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return ("Vui lòng nhập mật khẩu");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Vui lòng nhập mật khẩu trên 6 kí tự");
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Mật khẩu",
                      prefixIcon: Icon(Icons.lock_outline_rounded)),
                  onSaved: (value) {
                    passwordEditingController.text = value!;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: confirmPasswordEditingController,
                  obscureText: true,
                  validator: (value) {
                    if (confirmPasswordEditingController.text !=
                        passwordEditingController.text) {
                      return "Mật khẩu không khớp";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Xác nhận mật khẩu",
                      prefixIcon: Icon(Icons.lock_outline_rounded)),
                  onSaved: (value) {
                    confirmPasswordEditingController.text = value!;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      signUp(emailEditingController.text,
                          passwordEditingController.text);
                    },
                    child: const Text(
                      'Đăng kí',
                      style: TextStyle(fontSize: 15),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 33, 171, 165)),
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(MediaQuery.of(context).size.width, 60)),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Color(0xFFF5F6F9), shape: BoxShape.circle),
                        child: SvgPicture.network(
                            'https://res.cloudinary.com/dhi3bjn0s/image/upload/v1648739498/test/Flutter_THB1/facebook-2_jifbrg.svg')),
                    Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Color(0xFFF5F6F9), shape: BoxShape.circle),
                        child: SvgPicture.network(
                            'https://res.cloudinary.com/dhi3bjn0s/image/upload/v1648739498/test/Flutter_THB1/google-icon_vezhnw.svg')),
                    Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Color(0xFFF5F6F9), shape: BoxShape.circle),
                        child: SvgPicture.network(
                            'https://res.cloudinary.com/dhi3bjn0s/image/upload/v1648739498/test/Flutter_THB1/twitter_duwfvq.svg')),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                const SizedBox(height: 5),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  postDetailsToFirestore(),
                  currentUserGlb.uid = uid.toString(),
                  Fluttertoast.showToast(msg: "Đăng kí thành công"),
                })
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    KhachHang userModel = KhachHang();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.hoten = nameEditingController.text;
    userModel.ngaysinh = birthEditingController.text;
    userModel.sdt = phoneEditingController.text;
    userModel.avatar = avtEditingController.text;
    await firebaseFirestore
        .collection("KHACH_HANG")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Đăng kí thành công");
    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
  }
}
