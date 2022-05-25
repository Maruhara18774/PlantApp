import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/firebase/Promotion.dart';
import 'package:maclemylinh_18dh110774/firebase/product.dart';
import 'package:maclemylinh_18dh110774/model/khuyen_mai.dart';
import 'package:maclemylinh_18dh110774/model/loai_san_pham.dart';
import 'package:maclemylinh_18dh110774/model/san_pham.dart';
import 'package:maclemylinh_18dh110774/screens/Home/itemProduct.dart';
import 'package:maclemylinh_18dh110774/screens/Home/sale-fragment.dart';
import 'package:maclemylinh_18dh110774/screens/Promotion/Promotiondetail.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  List<LoaiSP> listCate = [];
  List<SanPham> listPro = [];
  List<PromotionXD> listDis = [];

  Future fetchData() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic result = await ProductFirebase().getAll();
    dynamic category = await ProductFirebase().getAllCate();
    dynamic dis = await DataPromotion().getPromotionList();
    if (result == null) {
      print('unable');
    } else {
      if (this.mounted)
        setState(() {
          listPro = result;
          listCate = category;
          listDis = dis;
        });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  int activeIndex = 0;
  final urlImgs = [
    'https://images.unsplash.com/photo-1624304314520-8acb626f91f9?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDJ8fHBsYW50cyUyMG9uJTIwcG90c3xlbnwwfDB8MHx8&auto=format&fit=crop&w=500',
    'https://images.unsplash.com/photo-1533090368676-1fd25485db88?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzR8fHBsYW50cyUyMG9uJTIwcG90c3xlbnwwfDB8MHx8&auto=format&fit=crop&w=500',
    'https://images.unsplash.com/photo-1481487196290-c152efe083f5?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTR8fHBsYW50cyUyMG9uJTIwcG90c3xlbnwwfDB8MHx8&auto=format&fit=crop&w=500',
    'https://images.unsplash.com/photo-1534349762230-e0cadf78f5da?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nzh8fHBsYW50c3xlbnwwfDB8MHx8&auto=format&fit=crop&w=500',
    'https://images.unsplash.com/photo-1513694203232-719a280e022f?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTIwfHxwbGFudHN8ZW58MHwwfDB8fA%3D%3D&auto=format&fit=crop&w=500',
    'https://images.unsplash.com/photo-1501256362032-b72b7b1bf58d?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTY5fHxwbGFudHN8ZW58MHwwfDB8fA%3D%3D&auto=format&fit=crop&w=500'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      const SizedBox(
        height: 10,
      ),
      CarouselSlider.builder(
        itemCount: urlImgs.length,
        itemBuilder: (context, index, realIndex) {
          final urlImg = urlImgs[index];
          return buildImage(urlImg, index);
        },
        options: CarouselOptions(
            autoPlayInterval: Duration(seconds: 2),
            height: 250,
            // enlargeCenterPage: true,
            // enlargeStrategy: CenterPageEnlargeStrategy.height,
            viewportFraction: 1,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            }),
      ),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: urlImgs.map((url) {
            int index = urlImgs.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: activeIndex == index
                    ? Color.fromARGB(255, 0, 0, 0)
                    : Color.fromARGB(255, 213, 213, 213),
              ),
            );
          }).toList()),
      SizedBox(height: 20),
      SizedBox(
        child: Text('Danh Mục',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 22, 58, 95))),
      ),
      SizedBox(
        height: 10,
      ),
      SizedBox(
        child: Container(
          height: 150,
          // Design Category
          child: _buildCategory(),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      SizedBox(
        child: Text('Nổi Bật',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 22, 58, 95))),
      ),
      SizedBox(
        height: 10,
      ),
      SizedBox(
        child: Container(
          height: 270,
          child: _buildNewProduct(),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Text('Khuyến mãi hot',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 22, 58, 95))),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Promotion()));
              },
              child: Text('Xem tất cả',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Dosis',
                      color: Colors.grey.shade600)),
            )
          ],
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(height: 200, child: _buildDis())
    ])));
  }

  Widget buildImage(String urlImg, int index) => Container(
        // margin: EdgeInsets.symmetric(horizontal: 24),
        color: Colors.grey,
        child: Image.network(
          urlImg,
          width: 375,
          fit: BoxFit.cover,
        ),
      );

  Widget _buildCategory() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: listCate.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => ProductsFragment()));
              },
              child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                      shadows: [
                        BoxShadow(
                            offset: Offset(0, 3),
                            color: Colors.grey.shade300,
                            blurRadius: 10)
                      ],
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ))),
                  child: Column(
                    children: [
                      Container(
                        height: 90,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: Center(
                                child: Image(
                              image: NetworkImage(
                                  listCate[index].imgCate.toString()),
                              fit: BoxFit.fitWidth,
                            ))),
                        decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(0)))),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: 100,
                          padding: EdgeInsets.all(5),
                          child: Text(
                            '${listCate[index].tenCate}',
                            maxLines: 1,
                            style: TextStyle(fontSize: 14),
                          ))
                    ],
                  )));
        });
  }

  Widget _buildNewProduct() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
              height: 180, child: ItemProduct(sanPham: listPro[index]));
        },
        itemCount: listPro.length);
  }

  Widget _buildDis() {
    return ListView.builder(
        itemCount: listDis.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ItemPromotion(promotion: listDis[index])));
              },
              child: Container(
                  padding: EdgeInsets.all(7),
                  margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 233, 233, 233),
                      borderRadius: BorderRadius.all(Radius.circular(0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: ShapeDecoration(
                            color: Color.fromARGB(255, 201, 201, 201),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0))),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://png.pngtree.com/png-vector/20190629/ourlarge/pngtree-50-off-discount-and-sale-promotion-banner-png-image_1517602.jpg'),
                                fit: BoxFit.cover)),
                      ),
                      Expanded(
                          child: Container(
                              padding:
                                  EdgeInsets.only(top: 10, left: 10, right: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${listDis[index].tenkhuyenmai}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    '${listDis[index].trangthai}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                  )
                                ],
                              )))
                    ],
                  )));
        });
  }
}
