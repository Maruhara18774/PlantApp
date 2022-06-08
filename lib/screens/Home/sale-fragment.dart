import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:maclemylinh_18dh110774/model/khuyen_mai.dart';
import 'package:maclemylinh_18dh110774/firebase/Promotion.dart';
import 'package:maclemylinh_18dh110774/screens/Promotion/Promotiondetail.dart';
class Promotion extends StatefulWidget {
  const Promotion({Key? key}) : super(key: key);

  @override
  State<Promotion> createState() => _PromotionState();
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
      //color: Colors.green.shade400,
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
            margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
            decoration: BoxDecoration(
                color: Colors.black12.withOpacity(0.05),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: ListTile ( //ListTile
              minLeadingWidth: 5,
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Ngày bắt đầu khuyến mãi : ${lsPromo[index].ngaybd!.substring(0,10)}',

                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
              leading: Icon(Icons.card_giftcard_outlined,
                  color: Colors.red.shade800),
              title: Text(
                '${lsPromo[index].ten} ',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color : Colors.red.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ))
    );  }
}

