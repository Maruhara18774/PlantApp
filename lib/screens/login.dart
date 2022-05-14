import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  static String routeName = "/login";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    Text('Food Now',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(
                        'Sign in with your email and password  \nor continue with social media',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green)),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Username",
                          prefixIcon: Icon(Icons.mail_outline)),
                      onChanged: (value){ _username = value; },
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock_outline_rounded)),
                      onChanged: (value){ _password = value; },
                    ),
                    SizedBox(height: 5,),
                    ElevatedButton(
                        onPressed: (){},
                        child: Text('Continue',style: TextStyle(fontSize: 15),),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                          minimumSize: MaterialStateProperty.all<Size>(Size(MediaQuery.of(context).size.width, 60)),)),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Container(
                            height: 40,
                            width: 40,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xFFF5F6F9),
                                shape: BoxShape.circle
                            ),
                            child: SvgPicture.network('https://res.cloudinary.com/dhi3bjn0s/image/upload/v1648739498/test/Flutter_THB1/facebook-2_jifbrg.svg')
                        ),
                        Container(
                            height: 40,
                            width: 40,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xFFF5F6F9),
                                shape: BoxShape.circle
                            ),
                            child: SvgPicture.network('https://res.cloudinary.com/dhi3bjn0s/image/upload/v1648739498/test/Flutter_THB1/google-icon_vezhnw.svg')
                        ),
                        Container(
                            height: 40,
                            width: 40,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xFFF5F6F9),
                                shape: BoxShape.circle
                            ),
                            child: SvgPicture.network('https://res.cloudinary.com/dhi3bjn0s/image/upload/v1648739498/test/Flutter_THB1/twitter_duwfvq.svg')
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.green)),
                        Text(
                            "Sign Up ",
                            style: TextStyle(color: Colors.deepOrangeAccent)),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage('https://res.cloudinary.com/dhi3bjn0s/image/upload/v1648739497/test/Flutter_THB1/dish_g6nopg.png'),
                      alignment: Alignment.topRight,
                      scale: 1.5
                  ),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('https://res.cloudinary.com/dhi3bjn0s/image/upload/v1648739497/test/Flutter_THB1/dish_2_b4x0cy.png'),
                    alignment: Alignment.bottomLeft,
                    scale: 1.5
                ),
              )
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
