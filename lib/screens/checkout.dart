import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maclemylinh_18dh110774/firebase/Promotion.dart';
import 'package:maclemylinh_18dh110774/firebase/address.dart';
import 'package:maclemylinh_18dh110774/firebase/notification.dart';
import 'package:maclemylinh_18dh110774/firebase/order.dart';
import 'package:maclemylinh_18dh110774/firebase/orderDetail.dart';
import 'package:maclemylinh_18dh110774/model/chi_tiet_gio_hang.dart';
import 'package:maclemylinh_18dh110774/model/dia_chi.dart';
import 'package:maclemylinh_18dh110774/model/san_pham.dart';
import 'package:maclemylinh_18dh110774/screens/Address/address.dart';
import 'package:maclemylinh_18dh110774/screens/cart.dart';
import 'package:maclemylinh_18dh110774/screens/home.dart';

import '../global.dart';
import '../model/khuyen_mai.dart';

class CheckoutPage extends StatefulWidget {
  static String routeName = "/checkout";
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<ChiTietGioHang> _listCTGH = [];
  List<SanPham> _listSP = [];
  DiaChi? _diaChi;
  double sum = 0;
  String? _voucher;
  PromotionXD? promotion;
  double discount = 0;
  double finalSum = 0;
  @override
  void initState() {
    super.initState();
    _listCTGH = cartCTGioHang;
    _listSP = cartSanPhamGlb;
    for (var detail in _listCTGH) {
      sum = sum + detail.tongTien!;
    }
    finalSum = sum;
  }

  fetchData(String idDiaChi) async {
    if (idDiaChi != "" && _diaChi == null) {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      var result = await AddressFirebase().getAddress(idDiaChi);
      if (result == null) {
        print('unable');
      } else {
        setState(() {
          _diaChi = result;
        });
      }
    }
  }

  GetPromotion() async {
    if (_voucher == "") {
      setState(() {
        promotion = null;
        discount = 0;
        finalSum = sum;
      });
    } else {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      var result = await DataPromotion().getIDPromotion(_voucher!);
      if (result == null || result.length == 0) {
        Fluttertoast.showToast(msg: 'Wrong/ expired voucher');
        setState(() {
          promotion = null;
          discount = 0;
          finalSum = sum;
        });
      } else {
        setState(() {
          promotion = result[0];
          discount = (sum * promotion!.giamgia!.toDouble()) / 100;
          finalSum = sum - discount;
        });
      }
    }
  }

  AddOrder() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    var result = await OrderFirebase().AddOrder(
        _diaChi!.id!, finalSum, promotion == null ? "" : promotion!.id!);
    await AddOrderDetails(result);
    await AddNotification(result);
    cartCTGioHang = List<ChiTietGioHang>.empty(growable: true);
    cartSanPhamGlb = List<SanPham>.empty(growable: true);
    Fluttertoast.showToast(msg: 'Đặt hàng thành công');
    Navigator.pushNamed(context, HomePage.routeName);
  }

  AddOrderDetails(String idOrder) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    for (var i = 0; i < _listCTGH.length; i++) {
      var element = _listCTGH[i];
      await OrderDetailFirebase().AddOrderDetail(
          idOrder, element.idSanPham!, element.soLuong!, element.tongTien!);
    }
  }

  AddNotification(String idOrder) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await NotificationFirebase().Add(
        idOrder,
        "Đơn hàng " +
            idOrder +
            " đã được đặt thành công. Cửa hàng sẽ sớm xác nhận đơn hàng của bạn");
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final args = ModalRoute.of(context)!.settings.arguments as String;
    fetchData(args);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 29, 86, 110),
        title: const Text("Thanh toán"),
      ),
      bottomNavigationBar: Row(
        children: [
          SizedBox(
            width: (width * 30) / 100,
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, CartPage.routeName);
              },
              child: const Text("Hủy"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ))),
            ),
          ),
          SizedBox(
            width: (width * 70) / 100,
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {
                if (_diaChi == null) {
                  Fluttertoast.showToast(msg: 'Vui lòng nhập địa chỉ');
                } else {
                  AddOrder();
                }
              },
              child: const Text("Xác nhận thanh toán"),
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AddressPage.routeName);
                  },
                  child: _diaChi == null
                      ? Row(
                          children: const [
                            Text(
                              'Vui lòng chọn địa chỉ',
                              style: TextStyle(fontSize: 15.0),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Container(
                              width: width - 20,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 29, 86, 110)),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 5, bottom: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                      'Tên người nhận: ' +
                                          _diaChi!.ten.toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Số điện thoại: ' +
                                          _diaChi!.sdt.toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Địa chỉ: ' + _diaChi!.diaChi.toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
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
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Image.network(_listSP[index].hinhAnh!),
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  _listSP[index].ten!,
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                    _listSP[index].gia.toString() +
                                        " VND x " +
                                        _listCTGH[index].soLuong.toString(),
                                    maxLines: 5,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(height: 5),
                                Text('Tổng: ' +
                                    _listCTGH[index].tongTien.toString()),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }),
              const Divider(
                height: 20,
                thickness: 0,
                indent: 20,
                endIndent: 20,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Tổng sản phẩm (' +
                        _listSP.length.toString() +
                        ' món): ' +
                        sum.toString() +
                        ' VND'),
                    const SizedBox(height: 5),
                    Text('Giảm giá: ' +
                        (promotion == null
                            ? '0 VND'
                            : '- ' + (discount.toString()))),
                    const SizedBox(height: 5),
                    Text('Tổng cộng: ' + finalSum.toString() + ' VND')
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    const Text(
                      'Mã giảm giá: ',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    SizedBox(
                      width: width - 200,
                      height: 50,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), hintText: "nhập mã"),
                        onChanged: (value) {
                          _voucher = value;
                        },
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          GetPromotion();
                        },
                        icon: const Icon(Icons.add_circle_outline))
                  ],
                ),
              ),
            ])),
      ),
    );
  }
}
