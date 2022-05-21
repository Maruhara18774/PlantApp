import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:maclemylinh_18dh110774/firebase/product.dart';
import 'package:maclemylinh_18dh110774/global.dart';
import 'package:maclemylinh_18dh110774/model/chi_tiet_gio_hang.dart';
import 'package:maclemylinh_18dh110774/model/san_pham.dart';
import 'package:maclemylinh_18dh110774/screens/Home/itemProduct.dart';

class DetailPro extends StatefulWidget {
  SanPham sanPham;
  DetailPro({required this.sanPham});

  @override
  State<DetailPro> createState() => _DetailProState();
}

class _DetailProState extends State<DetailPro> {
  String UID = "";
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FetchUserInfo();
    FetchDataPro();
    FetchFeed();
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
        appBar: AppBar(),
        body: Container(
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                child: Image.network(imgPro.toString()),
              ),
              Container(
                padding: EdgeInsets.all(20),
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
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        Text(
                          '${NumberFormat('###,###').format(int.parse(giaPro.toString()))} VND',
                          style: TextStyle(fontSize: 25, color: Colors.red),
                        )
                      ],
                    ),
                    Text(
                      tinhtrangPro == 1 ? "Còn hàng" : "Hết hàng",
                      style: TextStyle(
                          fontSize: 16,
                          color: tinhtrangPro == 1
                              ? Color.fromARGB(255, 19, 117, 60)
                              : Color.fromARGB(255, 165, 28, 13)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mô tả',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(motaPro.toString())
                    ]),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                var cartItem = cartCTGioHang.firstWhere((element) => element.idSanPham == widget.sanPham.id, orElse: () => ChiTietGioHang(id: -1));
                                if(cartItem.id == -1){
                                  cartSanPhamGlb.add(widget.sanPham);
                                  cartCTGioHang.add(new ChiTietGioHang(idSanPham: id,soLuong: 1,tongTien: giaPro?.toDouble()));
                                }
                                else{
                                  cartItem.soLuong = cartItem.soLuong! + 1;
                                }
                                Fluttertoast.showToast(msg: "Thêm vào giỏ hàng thành công");
                              },
                              child: Text(
                                'Thêm vào',
                                style: TextStyle(fontSize: 15),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 33, 171, 165)),
                              )),
                          ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'Đặt hàng',
                                style: TextStyle(fontSize: 15),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 33, 171, 165)),
                              )),
                        ],
                      )
                    ]),
              ),
            ]),
          ),
        ));
  }
}
