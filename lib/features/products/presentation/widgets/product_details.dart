import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/product/product.dart';
class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});
final ProductModel product ;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Detail Product"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: 325.w,
                  height: 300.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ),
                  child: Image.network(
                    widget.product.image,
                  ),),
              ],
            ),
            Text(widget.product.name,style:TextStyle(fontSize: 24.0.sp,fontWeight: FontWeight.bold) ,),
            Text(
              "Rp.${widget.product.price}",
              style: TextStyle(fontSize: 16.0.sp,color: Colors.red,fontWeight: FontWeight.bold),
            ),
            Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.star, size: 14.0.sp, color: Colors.yellow),
                    Text(
                      "4.5",
                      style: TextStyle(fontSize: 14.0.sp),
                    ),
                  ],
                ),
                SizedBox(width: 20,),
                Text(
                  '83 Reviews',
                  style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                ),
                SizedBox(width: 100,),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.green[50],borderRadius: BorderRadius.circular(25)),
                    child: Text("Tersedia : 250",style: TextStyle(fontSize: 12.0.sp, color: Colors.green),)),
              ],
            ),
            Text("Description Product",style: TextStyle(fontSize: 16.0.sp,fontWeight: FontWeight.bold),),
            Text(widget.product.description),
          ],
        ) ,
      ),
    );
  }
}
