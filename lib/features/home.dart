import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/products/presentation/pages/best_sellers_product_page.dart';
import 'package:freebies_e_commerce/features/products/presentation/pages/categories_page.dart';
import 'package:freebies_e_commerce/features/products/presentation/pages/featured_product_page.dart';
import 'package:freebies_e_commerce/features/products/presentation/pages/new_product_page.dart';
import 'package:freebies_e_commerce/features/products/presentation/pages/product_with_special_offers_page.dart';
import 'package:freebies_e_commerce/features/products/presentation/pages/search_product_page.dart';
import 'package:freebies_e_commerce/features/products/presentation/pages/top_rated_product_page.dart';
import 'package:freebies_e_commerce/features/products/presentation/widgets/product_box.dart';
import 'package:freebies_e_commerce/features/products/presentation/widgets/search_screen.dart';

import '../core/config/themes/app_theme.dart';
import '../core/utils/widgets/login_popup.dart';
import '../core/utils/widgets/logout_popup.dart';
import 'news/presentation/pages/home_news_page.dart';
import 'news/presentation/widgets/news.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    "Mega Mall",
                    style: TextStyle(
                        color: marinerApprox, fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: InkWell(
                      onTap: () {
                        widget.isLoggedIn
                            ? showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return logoutPopupWidget();
                                },
                              )
                            : showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return loginPopupWidget(context);
                                },
                              );
                      },
                      child: Icon(Icons.person_2_rounded)),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(5.0),
            // Adjust the height of the shadow
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    // Adjust shadow color and opacity
                    spreadRadius: 0.5,
                    blurRadius: 3,
                    offset: Offset(0, 2), // Adjust the position of the shadow
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 30.w),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchProductPage(
                                  isLoggedIn: widget.isLoggedIn,
                                )), // Ensure SearchScreen is correctly defined
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: alabaster,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Search Product Name',
                            style: TextStyle(
                                color: Color(0xFFC4C5C4), fontSize: 14.sp),
                          ),
                          const Icon(Icons.search),
                        ],
                      ),
                    )),
              ),
              Container(
                padding: const EdgeInsets.only(left: 30),
                height: 200, // Adjust the height according to your requirement
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Image.asset(
                      "assets/images/pub.png",
                      width: 315.w,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Image.asset(
                      "assets/images/pub.png",
                      width: 315.w,
                    ),
                  ],
                ),
              ),
              CategoriesPage(
                isLoggedIn: widget.isLoggedIn,
              ),
              Container(
                color: const Color(0xFFFAFAFA),
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FeaturedProductPage(
                      isLoggedIn: widget.isLoggedIn,
                    ),
                    Image.asset("assets/images/BannerDefault.png"),
                    NewProductPage(isLoggedIn: widget.isLoggedIn),
                    Image.asset("assets/images/bannerDefault2.png"),
                    ProductsWithSpecialOffersPage(
                        isLoggedIn: widget.isLoggedIn),
                    BestSellersProductPage(isLoggedIn: widget.isLoggedIn),
                    TopRatedProductPage(isLoggedIn: widget.isLoggedIn)
                  ],
                ),
              ),
              Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
                  child: HomeNewsPage(
                    isLoggedIn: widget.isLoggedIn,
                  ))
            ],
          ),
        ));
  }
}
