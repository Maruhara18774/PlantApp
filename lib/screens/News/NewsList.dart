import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maclemylinh_18dh110774/model/News.dart';
import 'package:maclemylinh_18dh110774/firebase/News.dart';
import 'package:maclemylinh_18dh110774/screens/News/Newdetail.dart';



class NewsState extends StatefulWidget {
  static String routeName = "/NewsList";
  const NewsState ({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<NewsState> {
  final _myListKey = GlobalKey<AnimatedListState>();
  List<NewsXD> lsNews = [];


  FetchData()async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic result= await FirNews().getListNews();
    if(result==null){
      print('unable');
    }else{
      setState(() {
        lsNews=result;
      });
    }
  }
  @override
  void initState(){
    super.initState();
    FetchData();

  }
  @override
  Widget build(BuildContext context) {
    print(lsNews);
    return Material(
      child:  Container(
        // padding: EdgeInsets.only(left: 15, right: 15),
        color: Colors.grey.shade200,
        child: ListView.builder(
          // key: _myListKey,
          // initialItemCount: lsNews.length,
            itemCount: lsNews.length,
            itemBuilder: (context, index) {
              print(lsNews[index].nameNews);
              return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailNews(news: lsNews[index])));
                  },
                  child: Container(
                    padding: EdgeInsets.all(7),
                    margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                    decoration: BoxDecoration(
                        color: Colors.lightGreen.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: ShapeDecoration(
                              color: Colors.grey.shade100,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(7))),
                              image: DecorationImage(
                                  image: NetworkImage('${lsNews[index].imageNews}'),
                                  fit: BoxFit.cover)),
                        ),
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${lsNews[index].nameNews}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      '${lsNews[index].detailNews}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.grey.shade600),
                                    )
                                  ],
                                )))
                      ],
                    ),
                  ));
            }),

      )
      ,
    );
  }

// Widget _itemNews(int index) {

// }
}
