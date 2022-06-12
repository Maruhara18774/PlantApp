import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maclemylinh_18dh110774/global.dart';
import 'package:maclemylinh_18dh110774/model/chi_tiet_gio_hang.dart';
import 'package:maclemylinh_18dh110774/model/san_pham.dart';
import 'package:maclemylinh_18dh110774/screens/checkout.dart';
import 'package:maclemylinh_18dh110774/screens/home.dart';

class CartPage extends StatefulWidget {
  static String routeName = "/cart";
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<ChiTietGioHang> _listCTGH = [];
  List<SanPham> _listSP = [];
  double sum = 0;
  @override
  void initState() {
    super.initState();
    _listCTGH = cartCTGioHang;
    _listSP = cartSanPhamGlb;
    for (var detail in _listCTGH) {
      sum = sum + detail.tongTien!;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 29, 86, 110),
        title: const Text("Giỏ hàng"),
      ),
      bottomNavigationBar: Row(
        children: [
          SizedBox(
              width: (width * 1) / 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("Total: " + sum.toString()),
              )),
          SizedBox(
            width: (width * 1) / 2,
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {
                if (sum != 0) {
                  Navigator.pushNamed(context, CheckoutPage.routeName,
                      arguments: "");
                } else {
                  Fluttertoast.showToast(msg: "Giỏ hàng trống.");
                }
              },
              child: const Text("THANH TOÁN"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 29, 86, 110)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ))),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _listSP.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        const SizedBox(height: 5),
                        SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.network(_listSP[index].hinhAnh!)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          height: 100,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                _listSP[index].ten!,
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(_listSP[index].gia.toString() + " VND",
                                  maxLines: 5,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal)),
                              Padding(
                                padding: const EdgeInsets.only(left: 60.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if ((_listCTGH[index].soLuong! - 1) !=
                                              0) {
                                            _listCTGH[index].soLuong =
                                                _listCTGH[index].soLuong! - 1;
                                            _listCTGH[index].tongTien =
                                                _listCTGH[index].soLuong! *
                                                    _listSP[index]
                                                        .gia!
                                                        .toDouble();
                                            sum = sum -
                                                _listSP[index].gia!.toDouble();
                                          } else {
                                            sum = sum -
                                                _listSP[index].gia!.toDouble();
                                            _listSP.removeAt(index);
                                            _listCTGH.removeAt(index);
                                          }
                                        });
                                      },
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.black,
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          elevation:
                                              MaterialStateProperty.all(0)),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(_listCTGH[index].soLuong.toString()),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _listCTGH[index].soLuong =
                                              _listCTGH[index].soLuong! + 1;
                                          _listCTGH[index].tongTien =
                                              _listCTGH[index].tongTien! +
                                                  _listSP[index]
                                                      .gia!
                                                      .toDouble();
                                          sum = sum +
                                              _listSP[index].gia!.toDouble();
                                        });
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          elevation:
                                              MaterialStateProperty.all(0)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }),
            ])),
      ),
    );
  }
}
