import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget {
  static String routeName = "/register";
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _username = "";
  String _password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Container(
              child: Column(
                children: [
                  Text('Plants',
                      style: TextStyle(
                          color: Color.fromARGB(255, 33, 171, 165),
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Họ tên",
                        prefixIcon: Icon(Icons.account_circle)),
                    onChanged: (value) {
                      _username = value;
                    },
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Giới tính",
                        prefixIcon: Icon(Icons.male)),
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Năm sinh",
                        prefixIcon: Icon(Icons.celebration)),
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email)),
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Số điện thoại",
                        prefixIcon: Icon(Icons.ad_units)),
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Mật khẩu",
                        prefixIcon: Icon(Icons.lock_outline_rounded)),
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Đăng kí',
                        style: TextStyle(fontSize: 15),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 33, 171, 165)),
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size(MediaQuery.of(context).size.width, 60)),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 40,
                          width: 40,
                          margin: EdgeInsets.only(left: 5, right: 5),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xFFF5F6F9), shape: BoxShape.circle),
                          child: SvgPicture.network(
                              'https://res.cloudinary.com/dhi3bjn0s/image/upload/v1648739498/test/Flutter_THB1/facebook-2_jifbrg.svg')),
                      Container(
                          height: 40,
                          width: 40,
                          margin: EdgeInsets.only(left: 5, right: 5),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xFFF5F6F9), shape: BoxShape.circle),
                          child: SvgPicture.network(
                              'https://res.cloudinary.com/dhi3bjn0s/image/upload/v1648739498/test/Flutter_THB1/google-icon_vezhnw.svg')),
                      Container(
                          height: 40,
                          width: 40,
                          margin: EdgeInsets.only(left: 5, right: 5),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xFFF5F6F9), shape: BoxShape.circle),
                          child: SvgPicture.network(
                              'https://res.cloudinary.com/dhi3bjn0s/image/upload/v1648739498/test/Flutter_THB1/twitter_duwfvq.svg')),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  SizedBox(height: 5),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/449/449350.png'),
                    alignment: Alignment.topCenter,
                    // fit: BoxFit.scaleDown,
                    scale: 6.2),
              ),
            ),
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //       image: NetworkImage(
            //           'https://res.cloudinary.com/dhi3bjn0s/image/upload/v1648739497/test/Flutter_THB1/dish_2_b4x0cy.png'),
            //       alignment: Alignment.bottomLeft,
            //       scale: 1.5),
            // )
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
