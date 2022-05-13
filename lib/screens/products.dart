import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/firebase/product.dart';
import 'package:maclemylinh_18dh110774/model/san_pham.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<SanPham> _list = [];

  @override
  void initState() {
    super.initState();
    FetchData();
  }

  FetchData() async {
    await Firebase.initializeApp();
    var result = await ProductFirebase().getAll();
    if (result == null) {
      print('unable');
    } else {
      setState(() {
        _list = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
        itemCount: _list.length,
          itemBuilder: (context, index){
          return Column(
            children: [
              SizedBox(
                height: 90,
                width: 90,
                child: Image.network(_list[index].hinhAnh!),
              ),
            Center(
              child: Text(
              _list[index].ten!,
              textAlign: TextAlign.center,
              ),)
            ],
          );
      })
    );
  }
}
