import 'package:flutter/material.dart';
import 'package:maclemylinh_18dh110774/model/san_pham.dart';

class ItemProduct extends StatefulWidget {
  SanPham sanPham;
  ItemProduct({required this.sanPham});

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  @override
  Widget build(BuildContext context) {
    int isimportant = 0;
    // Favorites favorites = new Favorites(
    //     id: widget.detailProduct.id,
    //     isImportant: 0,
    //     idProduct: widget.detailProduct.id,
    //     productName: widget.detailProduct.namePro,
    //     categoryName: widget.detailProduct.idCate,
    //     price: widget.detailProduct.pricePro,
    //     images: widget.detailProduct.imgProduct);
    return Container(
      decoration: BoxDecoration(),
      padding: EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) =>
          //         SanPham(sanPham: widget.detailProduct)));
        },
        child: Container(
            child: Column(children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 3,
                        offset: Offset(1, 1))
                  ]),
              child: Column(children: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 150,
                  child: Center(
                      heightFactor: 0.7,
                      child: Image(
                        image: NetworkImage('${widget.sanPham.hinhAnh}'),
                        fit: BoxFit.fitHeight,
                      )),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.sanPham.ten}',
                        style: TextStyle(
                            fontSize: 16, color: Colors.teal.shade800),
                      ),
                      Text(
                          '${widget.sanPham.tinhtrang == 1 ? 'Còn hàng' : 'Hết hàng'}',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.sanPham.gia}',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold),
                          ),
                          // FavIconListPro(favorites)
                        ],
                      )
                    ],
                  ),
                )
              ])),
        ])),
      ),
    );
  }
}
