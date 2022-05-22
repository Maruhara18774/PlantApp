import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maclemylinh_18dh110774/screens/Home/sale-fragment.dart';

import '../../model/khuyen_mai.dart';

class ItemPromotion extends StatefulWidget {
  PromotionXD? promotion;
  ItemPromotion({this.promotion});

  @override
  _ItemPromotionState createState() => _ItemPromotionState();
}
class _ItemPromotionState extends State<ItemPromotion> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Thông Tin Ưu Đãi',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 29, 86, 110),
            ),
          ),
        ),
        body: Container(
            height: size.height,
            color: Colors.grey.shade300,
            width: size.width,
            padding: EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Text(
                            '''GIẢM ${widget.promotion!.giamgia} % CHO TẤT CẢ ĐƠN HÀNG BẤT KỲ''',
                            maxLines: 1,
                            style: TextStyle(
                                color : Colors.red.shade600,
                                fontWeight: FontWeight.bold, fontSize: 21),
                          ),
                          Text(
                            'Hạn sử dụng: ${widget.promotion!.ngayketthuc!.toDate().toString()}',
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.grey.shade500),
                          ),

                          ListTile(
                            title: Text (
                              'MÃ KHUYẾN MÃI : ${widget.promotion!.id}',
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.red.shade500),

                            ),
                            leading: Icon(Icons.copy_sharp,
                              size: 20 ,
                              color: Colors.teal.shade900,
                            ),
                            onTap : () {
                              Clipboard.setData(
                                  ClipboardData(text: '${widget.promotion!.id}'));
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: const Text('Sao chép thành công !'),
                              ));
                            },

                          ),
                          /*Container(
                              padding: EdgeInsets.only(left:20),
                              height: 40,
                              width: 170,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [Text('${widget.promotion!.id}'),
                                  IconButton(
                                    icon: Icon(Icons.copy_sharp),
                                    iconSize: 20,
                                    onPressed: () {
                                      Clipboard.setData(
                                          ClipboardData(text: '${widget.promotion!.id}'));
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: const Text('Sao chép thành công !'),
                                      ));
                                    },
                                    color: Colors.teal.shade900,

                                  ), ],
                              )),*/


                        ],

                      )),

                  SizedBox(
                    height: 7,
                  ),

                  /*Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                            padding: EdgeInsets.only(left:20),
                            height: 40,
                            width: 170,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text('${widget.promotion!.id}'),
                                IconButton(
                                  icon: Icon(Icons.copy_sharp),
                                  iconSize: 20,
                                  onPressed: () {
                                    Clipboard.setData(
                                        ClipboardData(text: '${widget.promotion!.id}'));
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: const Text('Sao chép thành công !'),
                                    ));
                                  },
                                  color: Colors.teal.shade900,

                                ), ],
                            )),


                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),*/
                  Container(
                      padding: EdgeInsets.all(20),
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Điều khoản sử dụng:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Column(
                              children: [
                                ListTile(
                                    minLeadingWidth: 5,
                                    leading: Icon(
                                      Icons.fiber_manual_record,
                                      size: 12,
                                      color: Colors.teal.shade800,
                                    ),
                                    title: Text(
                                        'Voucher không áp dụng đồng thời với các chương trình khuyến mãi khác.')),

                                ListTile(
                                    minLeadingWidth: 5,
                                    leading: Icon(
                                      Icons.fiber_manual_record,
                                      size: 12,
                                      color: Colors.teal.shade800,
                                    ),
                                    title: Text(
                                        'Voucher áp dụng cho nhiều lần thanh toán.')),
                                ListTile(
                                    minLeadingWidth: 5,
                                    leading: Icon(
                                      Icons.fiber_manual_record,
                                      size: 12,
                                      color: Colors.teal.shade800,
                                    ),
                                    title: Text(
                                        'Thời gian áp dụng voucher từ ngày ${widget.promotion!.ngaybatdau!.toDate().toString()} đến ngày ${widget.promotion!.ngayketthuc!.toDate().toString()}.')),

                                // 'Thời gian áp dụng voucher từ ngày ${DateFormat('dd/MM/yyyy').format(widget.promotion!.ngaybatdau!.toDate())} đến ngày ${DateFormat('dd/MM/yyyy').format(widget.promotion!.ngayketthuc!.toDate())}. Voucher có thể kế thúc sớm tùy vào chính sách của cửa hàng.')),
                                ListTile(
                                    minLeadingWidth: 5,
                                    leading: Icon(
                                      Icons.fiber_manual_record,
                                      size: 12,
                                      color: Colors.teal.shade800,
                                    ),
                                    title: Text(
                                        'Voucher chỉ áp dụng quý khách đến mua hàng trực tiếp tại cửa hàng.')),
                                ListTile(
                                    minLeadingWidth: 5,
                                    leading: Icon(
                                      Icons.fiber_manual_record,
                                      size: 12,
                                      color: Colors.teal.shade800,
                                    ),
                                    title: Text(
                                        'Voucher không được hoàn lại và không có giá trị quy đổi thành tiền mặt.')),

                              ],
                            ),

                          )

                        ],

                      )),
                  SizedBox(
                    height: 50,
                  ),

                ],
              ),
            )));
  }

  DateFormat(String s) {}
}
