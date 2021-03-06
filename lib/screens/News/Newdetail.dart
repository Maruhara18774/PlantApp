import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/model/News.dart';

class DetailNews extends StatefulWidget {
  //DeatilNews({Key? key}) : super(key: key);
  NewsXD? news;
  DetailNews({this.news});
  @override
  _DetailNewsState createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 29, 86, 110),
        title: const Text(
          'Thông tin cây cảnh',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
              child: Stack(
                children: [
                  Container(
                    height: size.height * (1 / 3) + 50,
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)))),
                    child: FadeInImage(
                      placeholder: const AssetImage('./assets/images/load.gif'),
                      image: NetworkImage('${widget.news!.hinhAnh}'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: size.width,
                    decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)))),
                    margin: EdgeInsets.only(top: size.height * (1 / 3)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.news!.ten}',
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lemonada',
                              color: Colors.teal.shade900),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${widget.news!.noidung}',

                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade800),
                        ),
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}
