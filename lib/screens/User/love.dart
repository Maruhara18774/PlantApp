import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:maclemylinh_18dh110774/firebase/favorite.dart';
import 'package:maclemylinh_18dh110774/firebase/product.dart';
import 'package:maclemylinh_18dh110774/model/san_pham.dart';
import 'package:maclemylinh_18dh110774/model/yeu_thich.dart';
import 'package:maclemylinh_18dh110774/screens/Home/itemProduct.dart';

class LovePage extends StatefulWidget {
  const LovePage({Key? key}) : super(key: key);

  @override
  State<LovePage> createState() => _LovePageState();
}

class _LovePageState extends State<LovePage> {
  List<YeuThich> _list = [];
  List<SanPham> _listPrd = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FetchData();
  }

  FetchData() async {
    List<SanPham> listPrd = [];
    List<YeuThich> list = [];
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    var result = await FavoriteFirebase().GetFavorites();
    list = result;

    for(var i = 0; i< list.length;i++){
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      var pro = await ProductFirebase().getProduct(list[i].idSanPham);
      listPrd.add(pro);
    }

    setState(() {
      this._list = result;
      this._listPrd = listPrd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yêu thích'),
        backgroundColor: const Color.fromARGB(255, 29, 86, 110),
        leading: IconButton(
          alignment: Alignment.center,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: StaggeredGridView.countBuilder(
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 5.0,
            itemCount: _listPrd.length,
            crossAxisCount: 4,
            itemBuilder: (BuildContext context, int index) =>
                ItemProduct(
                  sanPham: _listPrd[index],
                ),
            staggeredTileBuilder: (int index) =>
            const StaggeredTile.fit(2),
          )
        ),
      ),
    );
  }
}
