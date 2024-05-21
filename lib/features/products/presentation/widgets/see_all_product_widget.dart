import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/products/data/models/product/product.dart';
import 'package:freebies_e_commerce/features/products/presentation/bloc/product_bloc.dart';
import 'package:freebies_e_commerce/features/products/presentation/widgets/product_box.dart';

class SeeAllProduct extends StatefulWidget {
  const SeeAllProduct({super.key, required this.isLoggedIn, required this.title, required this.productsStatus, required this.products});
final ProductsStatus productsStatus ;
final List<ProductModel> products ;
final bool isLoggedIn ;
final String title ;
  @override
  State<SeeAllProduct> createState() => _SeeAllProductState();
}

class _SeeAllProductState extends State<SeeAllProduct> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text(widget.title),backgroundColor: Colors.white,),
      body:  Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        // height: 250,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0.w,
            mainAxisSpacing: 15.0.h,
              mainAxisExtent:210,
          ),
          itemCount: widget.products.length,
          itemBuilder: (context, index) {
            return ProductBox(
              product: widget.products[index],
              isLoading: widget.productsStatus == ProductsStatus.loading,
              isLoggedIn: widget.isLoggedIn,
            );
          },
        ),
      ),
    );
  }
}
