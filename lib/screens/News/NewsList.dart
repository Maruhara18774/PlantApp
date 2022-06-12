import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/model/News.dart';
import 'package:maclemylinh_18dh110774/firebase/News.dart';
import 'package:maclemylinh_18dh110774/screens/News/Newdetail.dart';

class NewsState extends StatefulWidget {
  static String routeName = "/NewsList";
  const NewsState({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<NewsState> {
  final _myListKey = GlobalKey<AnimatedListState>();
  List<NewsXD> lsNews = [];

  FetchData() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic result = await FirNews().getListNews();
    if (result == null) {
      print('unable');
    } else {
      setState(() {
        lsNews = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    FetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 29, 86, 110),
        title: const Text("Tin tức"),
      ),
      body: Material(
        child: Container(
          color: Colors.grey.shade200,
          child: ListView.builder(
              itemCount: lsNews.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailNews(news: lsNews[index])));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      margin:
                          const EdgeInsets.only(top: 10, left: 16, right: 16),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 225, 225, 225),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${lsNews[index].ten}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        '${lsNews[index].noidung}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      )
                                    ],
                                  )))
                        ],
                      ),
                    ));
              }),
        ),
      ),
    );
  }

// Widget _itemNews(int index) {

// }
}
