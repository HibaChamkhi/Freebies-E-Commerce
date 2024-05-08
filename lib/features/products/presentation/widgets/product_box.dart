import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/products/data/models/product.dart';

class ProductBox extends StatefulWidget {
  final ProductModel product;

  const ProductBox({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductBox> createState() => _ProductBoxState();
}

class _ProductBoxState extends State<ProductBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 156.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child:SingleChildScrollView (
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.blue,
                    width: 125.w,
                    height: 125.w,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.product.name,
                    style: TextStyle(fontSize: 14.0.sp),
                  ),
                ],
              ),
              SizedBox(height: 4.0.h),
              Text(
                "Rp.${widget.product.price}",
                style: TextStyle(fontSize: 12.0.sp,color: Colors.red,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.0.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.star, size: 10.0.sp, color: Colors.yellow),
                      Text(
                        "4.5",
                        style: TextStyle(fontSize: 10.0.sp),
                      ),
                    ],
                  ),
                  Text(
                    '(83 Reviews)',
                    style: TextStyle(fontSize: 10.0.sp, color: Colors.grey),
                  ),
                  Icon(Icons.more_vert, size: 14.sp),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
