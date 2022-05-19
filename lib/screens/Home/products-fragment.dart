import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:maclemylinh_18dh110774/firebase/product.dart';
import 'package:maclemylinh_18dh110774/model/loai_san_pham.dart';
import 'package:maclemylinh_18dh110774/model/san_pham.dart';
import 'package:maclemylinh_18dh110774/screens/Home/itemProduct.dart';
import 'package:maclemylinh_18dh110774/screens/Home/refresh.dart';

class ProductsFragment extends StatefulWidget {
  static String routeName = "/products";
  const ProductsFragment({Key? key}) : super(key: key);

  @override
  State<ProductsFragment> createState() => _ProductFragmentState();
}

class _ProductFragmentState extends State<ProductsFragment> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> key =
      new GlobalKey<RefreshIndicatorState>();
  List<SanPham> _list = [];
  List<LoaiSP> _listCate = [];
  bool _isSelected = true;
  int _selectedIndex = -1;
  List<int> dataload = [];
  Future loadList() async {
    keyRefresh.currentState?.show();
    await Future.delayed(Duration(microseconds: 4000));
    final randon = Random();
    final data = List.generate(100, (_) => randon.nextInt(100));
    if (this.mounted) {
      setState(() {
        this.dataload = data;
      });
    }
  }

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  FetchData() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    var result = await ProductFirebase().getAll();
    var category = await ProductFirebase().getAllCate();
    if (result == null) {
      print('unable');
    } else {
      setState(() {
        _list = result;
        _foundProduct = result;
        _listCate = category;
      });
    }
  }

  List<SanPham> _foundProduct = [];
  @override
  void initState() {
    _foundProduct = _list;
    super.initState();
    FetchData();
  }

  void _FilterPro(int? idCate) {
    setState(() {
      _foundProduct = _list.where((e) => e.idLoaiSP == idCate).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Column(
        children: [
          SizedBox(
              height: 50,
              child: Row(children: [
                SizedBox(
                  width: 100,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          _foundProduct = _list;
                          _onSelected(-1);
                          _isSelected = true;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        padding: EdgeInsets.all(10),
                        height: 40,
                        decoration: BoxDecoration(
                            color: _isSelected
                                ? Colors.teal.shade700
                                : Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(0))),
                        child: Text(
                          'Tất cả',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: _isSelected ? Colors.white : Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _listCate.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              _onSelected(index);
                              _isSelected = false;
                              _FilterPro(_listCate[index].idCate);
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10, left: 10),
                              padding: EdgeInsets.all(10),
                              height: 30,
                              decoration: BoxDecoration(
                                  color: _selectedIndex != null &&
                                          _selectedIndex == index
                                      ? Colors.teal.shade700
                                      : Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0))),
                              child: Text(
                                '${_listCate[index].tenCate}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: _selectedIndex != null &&
                                          _selectedIndex == index
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ));
                      }),
                )
              ])),
          Expanded(
              child: Container(
                  margin: EdgeInsets.all(5),
                  child: RefreshWidget(
                      onRefresh: loadList,
                      key: key,
                      keyRefresh: keyRefresh,
                      child: StaggeredGridView.countBuilder(
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 5.0,
                        itemCount: _foundProduct.length,
                        crossAxisCount: 4,
                        itemBuilder: (BuildContext context, int index) =>
                            ItemProduct(
                          sanPham: _foundProduct[index],
                        ),
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.fit(2),
                      ))))
        ],
      ),
    );
  }
}
