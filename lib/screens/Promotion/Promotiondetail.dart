import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          title: const Text(
            'Thông Tin Ưu Đãi',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 29, 86, 110),
            ),
          ),
        ),
        body: Container(
            height: size.height,
            color: Colors.grey.shade300,
            width: size.width,
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      padding: const EdgeInsets.all(20),
                      width: size.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(0))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '''GIẢM ${widget.promotion!.giamgia}% CHO TẤT CẢ ĐƠN HÀNG BẤT KỲ''',
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.red.shade600,
                                fontWeight: FontWeight.bold,
                                fontSize: 21),
                          ),
                          Text(
                            'Hạn sử dụng: ${widget.promotion!.ngaykt!}',
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.grey.shade500),
                          ),
                          ListTile(
                            title: Text(
                              'MÃ KHUYẾN MÃI : ${widget.promotion!.id}',
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.red.shade500),
                            ),
                            leading: Icon(
                              Icons.copy_sharp,
                              size: 20,
                              color: Colors.teal.shade900,
                            ),
                            onTap: () {
                              Clipboard.setData(ClipboardData(
                                  text: '${widget.promotion!.id}'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Sao chép thành công !'),
                              ));
                            },
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 7,
                  ),
                  Container(
                      padding: const EdgeInsets.all(20),
                      width: size.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(0))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Điều khoản sử dụng:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
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
                                    title: const Text(
                                        'Voucher không áp dụng đồng thời với các chương trình khuyến mãi khác.')),

                                ListTile(
                                    minLeadingWidth: 5,
                                    leading: Icon(
                                      Icons.fiber_manual_record,
                                      size: 12,
                                      color: Colors.teal.shade800,
                                    ),
                                    title: const Text(
                                        'Voucher áp dụng cho nhiều lần thanh toán.')),
                                ListTile(
                                    minLeadingWidth: 5,
                                    leading: Icon(
                                      Icons.fiber_manual_record,
                                      size: 12,
                                      color: Colors.teal.shade800,
                                    ),
                                    title: Text(
                                        'Thời gian áp dụng voucher từ ngày ${widget.promotion!.ngaybd} đến ngày ${widget.promotion!.ngaykt}.')),

                                // 'Thời gian áp dụng voucher từ ngày ${DateFormat('dd/MM/yyyy').format(widget.promotion!.ngaybatdau!.toDate())} đến ngày ${DateFormat('dd/MM/yyyy').format(widget.promotion!.ngayketthuc!.toDate())}. Voucher có thể kế thúc sớm tùy vào chính sách của cửa hàng.')),
                                ListTile(
                                    minLeadingWidth: 5,
                                    leading: Icon(
                                      Icons.fiber_manual_record,
                                      size: 12,
                                      color: Colors.teal.shade800,
                                    ),
                                    title: const Text(
                                        'Voucher chỉ áp dụng quý khách đến mua hàng trực tiếp tại cửa hàng.')),
                                ListTile(
                                    minLeadingWidth: 5,
                                    leading: Icon(
                                      Icons.fiber_manual_record,
                                      size: 12,
                                      color: Colors.teal.shade800,
                                    ),
                                    title: const Text(
                                        'Voucher không được hoàn lại và không có giá trị quy đổi thành tiền mặt.')),
                              ],
                            ),
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            )));
  }
}
