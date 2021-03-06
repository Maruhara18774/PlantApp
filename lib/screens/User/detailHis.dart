import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maclemylinh_18dh110774/firebase/Promotion.dart';
import 'package:maclemylinh_18dh110774/firebase/address.dart';
import 'package:maclemylinh_18dh110774/firebase/notification.dart';
import 'package:maclemylinh_18dh110774/firebase/order.dart';
import 'package:maclemylinh_18dh110774/firebase/orderDetail.dart';
import 'package:maclemylinh_18dh110774/firebase/product.dart';
import 'package:maclemylinh_18dh110774/global.dart';
import 'package:maclemylinh_18dh110774/model/chi_tiet_gio_hang.dart';
import 'package:maclemylinh_18dh110774/model/dia_chi.dart';
import 'package:maclemylinh_18dh110774/model/gio_hang.dart';
import 'package:maclemylinh_18dh110774/model/khuyen_mai.dart';
import 'package:maclemylinh_18dh110774/model/san_pham.dart';
import 'package:maclemylinh_18dh110774/screens/Home/sale-fragment.dart';

class DetailHis extends StatefulWidget {
  static String routeName = "/detailHis";
  const DetailHis({Key? key}) : super(key: key);

  @override
  State<DetailHis> createState() => _DetailHisState();
}

class _DetailHisState extends State<DetailHis> {
  String orderID = "";
  GioHang? order;
  DiaChi? address;
  PromotionXD? promotion = null;
  List<ChiTietGioHang> details = [];
  List<SanPham> products = [];
  double discount = 0;
  double sum = 0;

  FetchData(String orderID) async {
    List<SanPham> products = [];
    await Firebase.initializeApp();
    var order = await OrderFirebase().getOrder(orderID);
    var details = await OrderDetailFirebase().getDetailOrder(orderID);
    var address = await AddressFirebase().getAddress(order.idGiaoHang);
    var promotion = await DataPromotion().getPromotion(order.idKhuyenMai);
    for (var i = 0; i < details.length; i++) {
      var product = await ProductFirebase().getProduct(details[i].idSanPham);
      products.add(product);
    }
    double sum = 0;
    for (var detail in details) {
      sum = sum + detail.tongTien;
    }
    setState(() {
      this.orderID = orderID;
      this.order = order;
      this.details = details;
      this.products = products;
      this.address = address;
      this.sum = sum;
      if (promotion.id != "ERROR") {
        this.promotion = promotion;
        this.discount = (sum * promotion.giamgia.toDouble()) / 100;
      }
    });
  }

  CancelOrder() async {
    await Firebase.initializeApp();
    await OrderFirebase().cancelOrder(orderID);
    await FetchData(orderID);
    await AddNotification(orderID);
    Fluttertoast.showToast(msg: "H???y ????n h??ng th??nh c??ng.");
  }

  AddNotification(String idOrder) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await NotificationFirebase()
        .Add(idOrder, "????n h??ng " + idOrder + " ???? ???????c h???y th??nh c??ng.");
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (orderID == "") {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      FetchData(args);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi ti???t ????n h??ng'),
        backgroundColor: const Color.fromARGB(255, 29, 86, 110),
      ),
      body: Container(
        child: Container(
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Th??ng tin giao h??ng",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                SizedBox(height: 5),
                this.address != null
                    ? Text("T??n ng?????i nh???n:   " + address!.ten!)
                    : Text(""),
                SizedBox(height: 5),
                this.address != null
                    ? Text("S??? ??i???n tho???i:   " + address!.sdt!)
                    : Text(""),
                SizedBox(height: 5),
                this.address != null
                    ? Text("?????a ch???:   " + address!.diaChi!)
                    : Text(""),
                SizedBox(height: 5),
                const Divider(
                  // height: 20,
                  // thickness: 5,
                  // endIndent: 0,
                  color: Color.fromARGB(255, 148, 148, 148),
                ),
                Text("Chi ti???t ????n h??ng",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                SizedBox(height: 5),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: details.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: Image.network(products[index].hinhAnh!),
                          ),
                          SizedBox(
                            width: width - 140,
                            height: 70,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    products[index].ten! +
                                        " x " +
                                        details[index].soLuong.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Text('T???ng: ' +
                                      details[index].tongTien.toString())
                                ],
                              ),
                            ),
                          ),
                          // SizedBox(height: 5),
                        ],
                      );
                    }),
                const Divider(
                  height: 20,
                  thickness: 0,
                  indent: 80,
                  endIndent: 0,
                  color: Color.fromARGB(255, 148, 148, 148),
                ),
                SizedBox(
                  width: width - 50,
                  child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        "Th??nh ti???n: " + this.sum.toString(),
                        textAlign: TextAlign.end,
                      )),
                ),
                SizedBox(height: 5),
                this.discount != 0
                    ? SizedBox(
                        width: width - 50,
                        child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(
                              "Gi???m gi??: - " + this.discount.toString(),
                              textAlign: TextAlign.end,
                            )),
                      )
                    : SizedBox(
                        width: width - 50,
                        child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(
                              "Gi???m gi??: 0",
                              textAlign: TextAlign.end,
                            )),
                      ),
                SizedBox(height: 5),
                SizedBox(
                  width: width - 50,
                  child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: this.order != null
                          ? Text(
                              "T???ng c???ng: " + this.order!.tong.toString(),
                              textAlign: TextAlign.end,
                            )
                          : Text("T???ng c???ng: 0")),
                ),
                SizedBox(height: 5),
                const Divider(
                  color: Color.fromARGB(255, 148, 148, 148),
                ),
                Text("Th??ng tin ????n h??ng",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                SizedBox(height: 5),
                this.order != null
                    ? Text("Ng??y ?????t:   " + this.order!.ngayDat!)
                    : Text(""),
                SizedBox(height: 5),
                this.order != null
                    ? Text("T??nh tr???ng:   " + getStatus(this.order!.tinhTrang!))
                    : Text(""),
                SizedBox(height: 5),
                this.order != null && this.order!.tinhTrang == 'New'
                    ? ElevatedButton(
                        onPressed: () {
                          this.CancelOrder();
                        },
                        child: Text("H???y ????n h??ng"))
                    : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

getStatus(String status) {
  var result = "";
  switch (status) {
    case 'New':
      {
        result = 'M???i';
      }
      break;

    case 'Cancel':
      {
        result = '???? h???y';
      }
      break;

    default:
      {
        result = 'Kh??ng x??c ?????nh';
      }
      break;
  }
  return result;
}
