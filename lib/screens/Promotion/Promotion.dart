import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maclemylinh_18dh110774/model/khuyen_mai.dart';
import 'package:maclemylinh_18dh110774/firebase/Promotion.dart';
import 'package:maclemylinh_18dh110774/screens/Promotion/Promotiondetail.dart';


class Promotion extends StatefulWidget {
  Promotion({Key? key}) : super(key: key);

  @override
  _PromotionState createState() => _PromotionState();
}

class _PromotionState extends State<Promotion> {
  List<PromotionXD> lsPromo = [];

  @override
  void initState() {
    super.initState();
    FetchData();
  }

  FetchData() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic result = await DataPromotion().getPromotionList();
    if (result == null) {
      print('unable');
    } else {
      setState(() {
        lsPromo = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(body: Container(
      color: Colors.green.shade400,
      child: ListView.builder(
          itemCount: lsPromo.length,
          itemBuilder: (context, index) {
            return _itemPromo(index);
          }),
    )));
  }

  Widget _itemPromo(int index) {

    return InkWell(
        onTap: () {
          Navigator.push(
            context,
          MaterialPageRoute(
              builder: (context) =>
                  ItemPromotion(promotion: lsPromo[index])));
    },
        child: Container(
        // padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(top: 10, left: 16, right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ListTile ( //ListTile
              minLeadingWidth: 5,
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${DateFormat('dd/MM/yyyy').format(lsPromo[index].ngaybatdau!.toDate())} - ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  Text(
                    '${DateFormat('dd/MM/yyyy').format( lsPromo[index].ngayketthuc!.toDate())}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
              leading: Icon(Icons.card_giftcard_outlined,
                  color: Colors.teal.shade800),
              title: Text(
                '${lsPromo[index].tenkhuyenmai} | Khuyến mãi ${lsPromo[index].giamgia}% giá trị đơn hàng ',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ))
    );  }

  DateFormat(String s) {

  }

  NumberFormat(String s) {}
}

