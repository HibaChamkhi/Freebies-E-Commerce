import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/auth/presentation/widgets/sign_in.dart';
import 'package:freebies_e_commerce/features/products/data/models/product.dart';
import 'package:freebies_e_commerce/features/products/presentation/widgets/product_details.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/config/themes/app_theme.dart';
import '../../../../core/utils/widgets/login_popup.dart';

class ProductBox extends StatefulWidget {
  final ProductModel product;
  final bool isLoading;

  final bool isLoggedIn;

  const ProductBox(
      {super.key,
      required this.product,
      required this.isLoading,
      required this.isLoggedIn});

  @override
  State<ProductBox> createState() => _ProductBoxState();
}

class _ProductBoxState extends State<ProductBox> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? SizedBox(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.grey.shade50,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                width: 156,
                height: 242,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: boxGrey,
                      width: 125,
                      height: 125,
                    ),
                    Container(
                      color: boxGrey,
                      width: 100,
                      height: 20,
                    ),
                    Container(
                      color: boxGrey,
                      width: 100,
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          )
        : InkWell(
            onTap: () {
              widget.isLoggedIn
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetails(
                                product: widget.product,
                              )),
                    )
                  : showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return loginPopupWidget(context);
                      },
                    );
            },
            child: Container(
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
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 125.w,
                            height: 125.h,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.r)),
                            ),
                            child: Image.network(
                              widget.product.image,
                            ),
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
                        style: TextStyle(
                            fontSize: 12.0.sp,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.0.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.star,
                                  size: 10.0.sp, color: Colors.yellow),
                              Text(
                                "4.5",
                                style: TextStyle(fontSize: 10.0.sp),
                              ),
                            ],
                          ),
                          Text(
                            '(83 Reviews)',
                            style: TextStyle(
                                fontSize: 10.0.sp, color: Colors.grey),
                          ),
                          Icon(Icons.more_vert, size: 14.sp),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
