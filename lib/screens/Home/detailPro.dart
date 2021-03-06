import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:maclemylinh_18dh110774/firebase/favorite.dart';
import 'package:maclemylinh_18dh110774/firebase/product.dart';
import 'package:maclemylinh_18dh110774/global.dart';
import 'package:maclemylinh_18dh110774/model/chi_tiet_gio_hang.dart';
import 'package:maclemylinh_18dh110774/model/san_pham.dart';
import 'package:maclemylinh_18dh110774/model/yeu_thich.dart';

class DetailPro extends StatefulWidget {
  SanPham sanPham;
  DetailPro({required this.sanPham});

  @override
  State<DetailPro> createState() => _DetailProState();
}

class _DetailProState extends State<DetailPro> {
  String UID = "";
  bool isLogin = false;
  YeuThich? favo = null;
  // List<MDFeedback> mdFeedback = [];
  FetchFeed() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    //   dynamic result = await FirFeedback()
    //       .getListFeedbackPro(widget.detailProduct.id.toString());
    //   if (result == null) {
    //     print('unable');
    //   } else {
    //     setState(() {
    //       mdFeedback = result;
    //     });
    //   }
    // }
  }

  // List<MDDetailShoppingCart> listShopping = [];
  FetchUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      UID = user.uid;
    }
  }

  List<SanPham> listPro = [];

  FetchDataPro() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic result = await ProductFirebase()
        .getCateProductList(widget.sanPham.idLoaiSP.toString());
    // dynamic resultshopping = await FirShoppingCart().getListShoppingCart(UID);
    if (result == null) {
      print('unable');
    } else {
      setState(() {
        listPro = result;
        // listShopping = resultshopping;
      });
    }
  }

  FetchFavorite() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    var result = await FavoriteFirebase().GetStatus(widget.sanPham.id!);
    setState(() {
      if(result.id != 'NULL'){
        this.favo = result;
      }
      else{
        this.favo = null;
      }
    });
  }

  favorite() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await FavoriteFirebase().Add(widget.sanPham.id!);
    await FetchFavorite();
  }

  unFavorite() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await FavoriteFirebase().Remove(this.favo!.id!);
    await FetchFavorite();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FetchUserInfo();
    FetchDataPro();
    FetchFeed();
    FetchFavorite();
    if (currentUserGlb.uid != '') {
      isLogin = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    int? id = widget.sanPham.id;
    String? idPro = widget.sanPham.id.toString();
    String tenPro = widget.sanPham.ten.toString();
    int? giaPro = widget.sanPham.gia;
    String? imgPro = widget.sanPham.hinhAnh;
    String motaPro = widget.sanPham.mota.toString();
    int? tinhtrangPro = widget.sanPham.tinhtrang;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(tenPro),
          backgroundColor: const Color.fromARGB(255, 29, 86, 110),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                child: Image.network(imgPro.toString()),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width / 1.5,
                          child: Text(
                            tenPro,
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        Text(
                          '${NumberFormat('###,###').format(int.parse(giaPro.toString()))} VND',
                          style: const TextStyle(fontSize: 25, color: Colors.red),
                        )
                      ],
                    ),
                    Text(
                      tinhtrangPro == 1 ? "C??n h??ng" : "H???t h??ng",
                      style: TextStyle(
                          fontSize: 16,
                          color: tinhtrangPro == 1
                              ? const Color.fromARGB(255, 19, 117, 60)
                              : const Color.fromARGB(255, 165, 28, 13)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'M?? t???',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(motaPro.toString())
                    ]),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          this.isLogin ?
                          ElevatedButton(
                              onPressed: () {
                                if(tinhtrangPro == 1){
                                  var cartItem = cartCTGioHang.firstWhere((element) => element.idSanPham == widget.sanPham.id, orElse: () => ChiTietGioHang(id: ""));
                                  if(cartItem.id == ""){
                                    cartSanPhamGlb.add(widget.sanPham);
                                    cartCTGioHang.add(ChiTietGioHang(idSanPham: id,soLuong: 1,tongTien: giaPro?.toDouble()));
                                  }
                                  else{
                                    cartItem.soLuong = cartItem.soLuong! + 1;
                                    cartItem.tongTien = cartItem.tongTien! + giaPro!;
                                  }
                                  Fluttertoast.showToast(msg: "Th??m v??o gi??? h??ng th??nh c??ng");
                                }
                                else{
                                  Fluttertoast.showToast(msg: "S???n ph???m ???? h???t h??ng");
                                }
                              },
                              child: const Text(
                                'Th??m v??o',
                                style: TextStyle(fontSize: 15),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 33, 171, 165)),
                              )):SizedBox(),
                          this.isLogin ? Container(
                            child: this.favo != null ? ElevatedButton(
                                onPressed: () {
                                  unFavorite();

                                },
                                child: const Text(
                                  'H???y y??u th??ch',
                                  style: TextStyle(fontSize: 15),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      const Color.fromARGB(255, 33, 171, 165)),
                                )): ElevatedButton(
                                onPressed: () {
                                  favorite();
                                },
                                child: const Text(
                                  'Y??u th??ch',
                                  style: TextStyle(fontSize: 15),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      const Color.fromARGB(255, 33, 171, 165)),
                                ))
                          )
                          :SizedBox(),
                        ],
                      )
                    ]),
              ),
            ]),
          ),
        ));
  }
}
