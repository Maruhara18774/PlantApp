import 'package:flutter/material.dart';

class DetailHis extends StatefulWidget {
  const DetailHis({Key? key}) : super(key: key);

  @override
  State<DetailHis> createState() => _DetailHisState();
}

class _DetailHisState extends State<DetailHis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiet don hang'),
        backgroundColor: const Color.fromARGB(255, 29, 86, 110),
      ),
    );
  }
}
