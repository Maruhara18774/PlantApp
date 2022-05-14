import 'package:flutter/material.dart';

class SaleFragment extends StatefulWidget {
  const SaleFragment({Key? key}) : super(key: key);

  @override
  State<SaleFragment> createState() => _SaleFragmentState();
}

class _SaleFragmentState extends State<SaleFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Sale Page'),
    );
  }
}
