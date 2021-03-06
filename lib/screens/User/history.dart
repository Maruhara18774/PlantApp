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
          title: const Text('L???ch s???'),
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
                    // text: "T???t c???",
                    child: Text(
                      'T???t c???',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.schedule,
                      color: Colors.black,
                    ),
                    child: Text(
                      'Ch??? x??c nh???n',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.task_alt,
                      color: Colors.black,
                    ),
                    child: Text(
                      '???? x??c nh???n',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.delivery_dining,
                      color: Colors.black,
                    ),
                    child: Text(
                      '??ang giao h??ng',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.cases_outlined,
                      color: Colors.black,
                    ),
                    child: Text(
                      'Giao h??ng th??nh c??ng',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.cancel_presentation,
                      color: Colors.black,
                    ),
                    child: Text(
                      '???? h???y',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
                isScrollable: true,
              ),
              Expanded(
                  child: listOrder.length != 0 ?
                  TabBarView(
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
                  ): Text("Loading ...")
              ),
            ],
          ),
        ));
  }

  Widget all() {
    return Item(listOrder, listProduct);
  }

  Widget daHuy() {
    List<GioHang> listOrder1 =
        listOrder.where((element) => element.tinhTrang == 'Cancel').toList();
    OrderDetailFirebase().getListDetailOrder();

    return Item(listOrder1, listProduct);
  }

  Widget giaoThanhCong() {
    List<GioHang> listOrder1 = listOrder
        .where((element) => element.tinhTrang == 'Th??nh c??ng')
        .toList();

    return Item(listOrder1, listProduct);
  }

  Widget dangGiaoHang() {
    List<GioHang> listOrder1 = listOrder
        .where((element) => element.tinhTrang == '??ang giao h??ng')
        .toList();

    return Item(listOrder1, listProduct);
  }

  Widget daXacNhan() {
    List<GioHang> listOrder1 = listOrder
        .where((element) => element.tinhTrang == '???? x??c nh???n')
        .toList();

    return Item(listOrder1, listProduct);
  }

  Widget choXacNhan() {
    List<GioHang> listOrder1 = listOrder
        .where((element) => element.tinhTrang == 'New')
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
                    Navigator.pushNamed(context, DetailHis.routeName, arguments: listOrder[index].idGioHang.toString());
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
                                'M?? ????n h??ng: ${listOrder[index].idGioHang}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.teal.shade800,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text('${getStatus(listOrder[index].tinhTrang!)}',
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
                              'T???ng ti???n: ${NumberFormat('###,###').format(double.parse(listOrder[index].tong.toString()))}',
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
getStatus(String status){
  var result = "";
  switch (status){
    case 'New': {
      result = 'M???i';
    }
    break;

    case 'Cancel': {
      result = '???? h???y';
    }
    break;

    default: {
      result = 'Kh??ng x??c ?????nh';
    }
    break;
  }
  return result;
}