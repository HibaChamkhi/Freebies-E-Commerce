import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/products/presentation/pages/featured_product_page.dart';
import 'package:freebies_e_commerce/features/products/presentation/widgets/product_box.dart';

import '../core/config/themes/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.isLoggedIn});
final bool isLoggedIn ;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white  ,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Mega Mall",
            style: TextStyle(color: marinerApprox, fontWeight: FontWeight.bold),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(5.0), // Adjust the height of the shadow
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Adjust shadow color and opacity
                    spreadRadius: 0.5,
                    blurRadius: 3,
                    offset: Offset(0, 2), // Adjust the position of the shadow
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 30.w),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: alabaster,
                  // Assuming 'alabaster' is a Color variable or constant
                  hintText: 'Search Product Name',
                  hintStyle: const TextStyle(color: Color(0xFFC4C5C4)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    // Adjust the radius as needed
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: const Icon(
                      Icons.search), // Adding the search icon as suffix
                ),
              ),
            ),


             FeaturedProductPage(isLoggedIn: widget.isLoggedIn,),

          ],
        ));
  }
}
