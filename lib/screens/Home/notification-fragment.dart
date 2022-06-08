import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/firebase/notification.dart';
import 'package:maclemylinh_18dh110774/model/thong_bao.dart';
import 'package:maclemylinh_18dh110774/screens/User/detailHis.dart';

class NotificationFragment extends StatefulWidget {
  const NotificationFragment({Key? key}) : super(key: key);

  @override
  State<NotificationFragment> createState() => _NotificationFragmentState();
}

class _NotificationFragmentState extends State<NotificationFragment> {
  List<ThongBao> _list = [];

  @override
  void initState() {
    super.initState();
    FetchData();
  }

  FetchData() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    var result = await NotificationFirebase().GetNotis();
    if (result == null) {
      print('unable');
    } else {
      setState(() {
        _list = new List.from(result.reversed);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: _list.isEmpty ? Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text('Hiện không có thông báo.'),
      ):
      ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _list.length,
          itemBuilder: (context,index){
            return OutlinedButton(onPressed: (){
              Navigator.pushNamed(context, DetailHis.routeName, arguments: _list[index].idGioHang.toString());
            },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0,left: 5.0, right: 5.0),
                  child: Text(_list[index].noidung!, style: TextStyle(color: Colors.black54)),
                )
            );
          }),
    );
  }
}
