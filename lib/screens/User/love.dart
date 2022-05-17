import 'package:flutter/material.dart';

class LovePage extends StatefulWidget {
  const LovePage({Key? key}) : super(key: key);

  @override
  State<LovePage> createState() => _LovePageState();
}

class _LovePageState extends State<LovePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yêu thích'),
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
    );
  }
}
