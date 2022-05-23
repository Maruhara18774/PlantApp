import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maclemylinh_18dh110774/firebase/product.dart';
import 'package:maclemylinh_18dh110774/model/san_pham.dart';
import 'package:maclemylinh_18dh110774/screens/Home/detailPro.dart';

class SearchPro extends StatefulWidget {
  const SearchPro({Key? key}) : super(key: key);

  @override
  State<SearchPro> createState() => _SearchProState();
}

class _SearchProState extends State<SearchPro> {
  List<SanPham> listProAll = [];
  List<SanPham> listProFiller = [];
  FetchData() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic result = await ProductFirebase().getAll();
    if (result == null) {
      print('unable');
    } else {
      setState(() {
        listProAll = result;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchData();
  }

  final searchController = new TextEditingController();

  String search = '';
  Icon icon = Icon(Icons.search);
  Widget cus = Text('Tìm kiếm');
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var listProFiller = listProAll
        .where((pro) => pro.ten!.toLowerCase().contains(search.toLowerCase()))
        .toList();
    if (listProFiller.isNotEmpty) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 29, 86, 110),
            title: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Nhập tên sản phẩm',
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 239, 239, 239), fontSize: 17)),
              textInputAction: TextInputAction.go,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          body: Container(
              height: height,
              width: width,
              color: Colors.grey.shade200,
              child: Column(children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: listProFiller.length,
                        itemBuilder: (context, index) {
                          final item = listProFiller[index];

                          return Column(
                            children: [
                              Container(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => DetailPro(
                                                    sanPham:
                                                        listProFiller[index])));
                                      },
                                      child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                          leading: Image(
                                            image: NetworkImage(
                                                item.hinhAnh.toString()),
                                          ),
                                          title: Row(children: [
                                            Container(
                                              width: 190,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${item.ten}',
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                  ),
                                                  Text(
                                                    '${item.tinhtrang == 0 ? 'Hết hàng' : 'Còn hàng'}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: item.tinhtrang ==
                                                                1
                                                            ? Color.fromARGB(
                                                                255,
                                                                22,
                                                                138,
                                                                71)
                                                            : Color.fromARGB(
                                                                255,
                                                                203,
                                                                172,
                                                                168)),
                                                  ),
                                                  Text(
                                                      '${NumberFormat('###,###').format(int.parse(item.gia.toString()))}',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 174, 12, 0),
                                                          fontSize: 17))
                                                ],
                                              ),
                                            ),
                                          ])))),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          );
                        })),
              ])));
    } else {
      listProFiller = listProAll;
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 29, 86, 110),
            title: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Nhập tên sản phẩm',
                  hintStyle:
                      TextStyle(color: Colors.grey.shade400, fontSize: 17)),
              textInputAction: TextInputAction.go,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          body: Container(
              height: height,
              width: width,
              color: Colors.grey.shade200,
              child: Column(children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: listProFiller.length,
                        itemBuilder: (context, index) {
                          final item = listProFiller[index];

                          return Column(
                            children: [
                              Container(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => DetailPro(
                                                    sanPham:
                                                        listProFiller[index])));
                                      },
                                      child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                          leading: Image(
                                            image: NetworkImage(
                                                item.hinhAnh.toString()),
                                          ),
                                          title: Row(children: [
                                            Container(
                                              width: 190,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${item.ten}',
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                  ),
                                                  Text(
                                                    '${item.tinhtrang == 0 ? 'Hết hàng' : 'Còn hàng'}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: item.tinhtrang ==
                                                                1
                                                            ? Color.fromARGB(
                                                                255,
                                                                22,
                                                                138,
                                                                71)
                                                            : Color.fromARGB(
                                                                255,
                                                                203,
                                                                172,
                                                                168)),
                                                  ),
                                                  Text(
                                                      '${NumberFormat('###,###').format(int.parse(item.gia.toString()))}',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 174, 12, 0),
                                                          fontSize: 17))
                                                ],
                                              ),
                                            ),
                                          ])))),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          );
                        })),
              ])));
    }
  }
}
