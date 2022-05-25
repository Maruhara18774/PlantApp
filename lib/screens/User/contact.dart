import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

final nameEditingController = TextEditingController();
final subjectEditingController = TextEditingController();
final emailEditingController = TextEditingController();
final contentEditingController = TextEditingController();

Future sendEmail() async {
  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  const serviceId = "service_jwt3ymg";
  const templateId = "template_47028g9";
  const userId = "YWJFmAQ7dW7rLgbe8";
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "service_id": serviceId,
        "template_id": templateId,
        "user_id": userId,
        "template_params": {
          "name": nameEditingController.text,
          "subject": subjectEditingController.text,
          "message": contentEditingController.text,
          "user_email": emailEditingController.text,
        }
      }));

  // return response.statusCode;
  print(response.body);
  Fluttertoast.showToast(msg: 'Đã gửi');
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liên hệ'),
        backgroundColor: const Color.fromARGB(255, 29, 86, 110),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  const Text(
                    'Hotline: 0785462513',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Email: truli15839@gmail.com',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: nameEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Tên người gửi",
                        prefixIcon: Icon(Icons.account_box)),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: subjectEditingController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Chủ đề",
                        prefixIcon: Icon(Icons.subject)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: emailEditingController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: contentEditingController,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Nội dung",
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        sendEmail();
                      },
                      child: const Text(
                        'Gửi mail',
                        style: TextStyle(fontSize: 15),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 33, 171, 165)),
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size(MediaQuery.of(context).size.width, 60)),
                      )),
                ],
                // mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          )),
        ),
      ),
    );
  }
}
