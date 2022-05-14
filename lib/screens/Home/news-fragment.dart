import 'package:flutter/material.dart';

class NewsFragment extends StatefulWidget {
  const NewsFragment({Key? key}) : super(key: key);

  @override
  State<NewsFragment> createState() => _NewsFragmentState();
}

class _NewsFragmentState extends State<NewsFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('New Page'),
    );
  }
}
