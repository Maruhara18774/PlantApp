import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget {
  static String routeName = "/register";
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          SizedBox(height: 10),
          Text('Register Account',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(
              'Complete your details or continue \nwith social media',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green)),
          SizedBox(height: 20),
          TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your email",
                  suffixIcon: Icon(Icons.mail_outline))),
          SizedBox(height: 25),
          TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your password",
                  suffixIcon: Icon(Icons.lock_outline_rounded))),
          SizedBox(height: 25),
          TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Re-enter your password",
                  suffixIcon: Icon(Icons.lock_outline_rounded))),
          SizedBox(height: 25),
          ElevatedButton(
              onPressed: (){},
              child: Text('Continue',style: TextStyle(fontSize: 15),),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                minimumSize: MaterialStateProperty.all<Size>(Size(MediaQuery.of(context).size.width, 60)),)),
          SizedBox(height: 25,),
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
        ],
      )),
    );
  }
}
