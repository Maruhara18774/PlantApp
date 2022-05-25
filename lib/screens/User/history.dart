import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maclemylinh_18dh110774/firebase/order.dart';
import 'package:maclemylinh_18dh110774/firebase/orderDetail.dart';
import 'package:maclemylinh_18dh110774/firebase/product.dart';
import 'package:maclemylinh_18dh110774/model/chi_tiet_gio_hang.dart';
import 'package:maclemylinh_18dh110774/model/gio_hang.dart';
import 'package:maclemylinh_18dh110774/model/san_pham.dart';
import 'package:maclemylinh_18dh110774/screens/User/detailHis.dart';
import 'package:maclemylinh_18dh110774/screens/checkout.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final controller = PageController();
  String uid = "";
  List<ChiTietGioHang> listProduct = [];
  List<GioHang> listOrder = [];
  // List<MDFeedback> listFeed = [];
  Future fetchUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    uid = user!.uid.toString();
  }

  List<SanPham> listProductFeed = [];
  Future fetchProduct(String id) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic resultPro = await ProductFirebase().getProductId(id);

    if (resultPro == null) {
      print('unable');
    } else {
      if (this.mounted) {
        setState(() {
          listProductFeed = resultPro;
        });
      }
    }
  }

  Future fetchDataPro() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    var result = await OrderFirebase().getListOrder(uid); //getListOrder
    var resultPro = await OrderDetailFirebase().getListDetailOrder();

    if (result == null) {
      print('unable');
    } else {
      if (this.mounted) {
        setState(() {
          listOrder = result;
          listProduct = resultPro;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserInfo();
    fetchDataPro();
    // FetchDataFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lịch sử'),
          backgroundColor: const Color.fromARGB(255, 29, 86, 110),
        ),
        body: DefaultTabController(
          length: 6,
          child: Column(
            children: <Widget>[
              TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.list,
                      color: Colors.black,
                    ),
                    // text: "Tất cả",
                    child: Text(
                      'Tất cả',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.schedule,
                      color: Colors.black,
                    ),
                    child: Text(
                      'Chờ xác nhận',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.task_alt,
                      color: Colors.black,
                    ),
                    child: Text(
                      'Đã xác nhận',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.delivery_dining,
                      color: Colors.black,
                    ),
                    child: Text(
                      'Đang giao hàng',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.cases_outlined,
                      color: Colors.black,
                    ),
                    child: Text(
                      'Giao hàng thành công',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.cancel_presentation,
                      color: Colors.black,
                    ),
                    child: Text(
                      'Đã hủy',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
                isScrollable: true,
              ),
              Expanded(
                  child: FutureBuilder(
                future: fetchDataPro(),
                builder: (context, snapshot) {
                  return snapshot.hasData || listOrder.isNotEmpty
                      ? TabBarView(
                          children: <Widget>[
                            Container(
                              child: all(),
                            ),
                            Container(
                              child: choXacNhan(),
                            ),
                            Container(
                              child: daXacNhan(),
                            ),
                            Container(
                              child: dangGiaoHang(),
                            ),
                            Container(
                              child: giaoThanhCong(),
                            ),
                            Container(
                              child: daHuy(),
                            ),
                          ],
                        )
                      : const Text('load');
                },
              )),
            ],
          ),
        ));
  }

  Widget all() {
    return Item(listOrder, listProduct);
  }

  Widget daHuy() {
    List<GioHang> listOrder1 =
        listOrder.where((element) => element.tinhTrang == 'Đã hủy').toList();
    OrderDetailFirebase().getListDetailOrder();

    return Item(listOrder1, listProduct);
  }

  Widget giaoThanhCong() {
    List<GioHang> listOrder1 = listOrder
        .where((element) => element.tinhTrang == 'Thành công')
        .toList();

    return Item(listOrder1, listProduct);
  }

  Widget dangGiaoHang() {
    List<GioHang> listOrder1 = listOrder
        .where((element) => element.tinhTrang == 'Đang giao hàng')
        .toList();

    return Item(listOrder1, listProduct);
  }

  Widget daXacNhan() {
    List<GioHang> listOrder1 = listOrder
        .where((element) => element.tinhTrang == 'Đã xác nhận')
        .toList();

    return Item(listOrder1, listProduct);
  }

  Widget choXacNhan() {
    List<GioHang> listOrder1 = listOrder
        .where((element) => element.tinhTrang == 'Chờ xác nhận')
        .toList();

    return Item(listOrder1, listProduct);
  }

  Stack Item(List<GioHang> listOrder, List<ChiTietGioHang> listPro) {
    int indexOrder;

    return Stack(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: listOrder.length,
            itemBuilder: (context, index) {
              indexOrder = index;
              String idOrder = listOrder[index].idGioHang.toString();

              List<ChiTietGioHang> listProduct1 = listPro
                  .where((element) =>
                      element.idGioHang == listOrder[index].idGioHang)
                  .toList();

              return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: ((context) => DetailHis())));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 5),
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 235, 235, 235),
                        borderRadius: BorderRadius.all(Radius.circular(0))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                'Mã đơn hàng: ${listOrder[index].idGioHang}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.teal.shade800,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text('${listOrder[index].tinhTrang}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey.shade600))
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${listOrder[index].ngayDat}'),
                            Text(
                              'Tổng tiền: ${NumberFormat('###,###').format(double.parse(listOrder[index].tong.toString()))}',
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ));
            })
      ],
    );
  }
}
