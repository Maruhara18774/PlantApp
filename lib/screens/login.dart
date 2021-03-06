import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maclemylinh_18dh110774/global.dart';
import 'package:maclemylinh_18dh110774/screens/home.dart';
import 'package:maclemylinh_18dh110774/screens/register.dart';
import 'package:maclemylinh_18dh110774/screens/reset_password.dart';

class LoginPage extends StatefulWidget {
  static String routeName = "/login";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // form key
  final _formKey = GlobalKey<FormState>();
  //edit controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //setState
  String _email = "";
  String _password = "";
  //firebase
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                      child: const Image(
                          image: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/449/449350.png',
                              scale: 3.5))),
                  const Text('Plants',
                      style: TextStyle(
                          color: Color.fromARGB(255, 33, 171, 165),
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Vui l??ng nh???p email c???a b???n");
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Vui l??ng nh???p email h???p l???");
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        prefixIcon: Icon(Icons.mail_outline)),
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      RegExp regex = RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return ("Vui l??ng nh???p m???t kh???u");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Vui l??ng nh???p m???t kh???u tr??n 6 k?? t???");
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "M???t kh???u",
                        prefixIcon: Icon(Icons.lock_outline_rounded)),
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        signIn(emailController.text, passwordController.text);
                      },
                      child: const Text(
                        '????ng nh???p',
                        style: TextStyle(fontSize: 15),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 33, 171, 165)),
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size(MediaQuery.of(context).size.width, 60)),
                      )),
                  // SizedBox(
                  //   height: 1,
                  // ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const ResetPassword())));
                    },
                    child: const Text(
                      'Qu??n m???t kh???u ?',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text("B???n ch??a c?? t??i kho???n ? ",
                          style: TextStyle(color: Colors.green)),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => const RegisterPage())));
                        },
                        child: const Text("????ng k?? "),
                        // style: ButtonStyle(backgroundColor: Colors.black),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  //login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) {
        Fluttertoast.showToast(msg: "????ng nh???p th??nh c??ng");
        currentUserGlb.uid = uid.toString();
        Navigator.pushNamed(context, HomePage.routeName);
      }).catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
