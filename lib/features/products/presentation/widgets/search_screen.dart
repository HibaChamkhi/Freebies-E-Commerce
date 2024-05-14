import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/themes/app_theme.dart';
import '../bloc/product_bloc.dart';
import 'product_box.dart'; // Import your ProductBox widget

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
    required this.searchProduct,
    required this.isLoggedIn,
    required this.state,
  }) : super(key: key);

  final Function(String) searchProduct;
  final bool isLoggedIn;
  final ProductState state;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = '';
  bool showGrid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Search'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 30.w),
        child: Column(
          children: [
            TextField(
              onChanged: (query) {
                setState(() {
                  searchText = query;
                });
                // Call your function here
                if (query.isNotEmpty) {
                  widget.searchProduct(query);
                } else {
                  // Clear the products list when text is empty
                  clearProducts(widget.state);
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: alabaster,
                hintText: 'Search Product Name',
                hintStyle: const TextStyle(color: Color(0xFFC4C5C4)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: const Icon(Icons.search),
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: searchText.isNotEmpty
                  ? widget.state.products.isNotEmpty
                  ? showGrid
                  ? SizedBox(
                height: 250,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0.w,
                    mainAxisSpacing: 20.0.h,
                  ),
                  itemCount: widget.state.products.length,
                  itemBuilder: (context, index) {
                    return ProductBox(
                      product: widget.state.products[index],
                      isLoading: widget.state.productsStatus == ProductsStatus.loading,
                      isLoggedIn: widget.isLoggedIn,
                    );
                  },
                ),
              )
                  : ListView.builder(
                itemCount: widget.state.products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Toggle between showing grid and list
                      setState(() {
                        showGrid = true;
                      });
                    },
                    child: ListTile(
                      title: Text(widget.state.products[index].name),
                    ),
                  );
                },
              )
                  : Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 120.0.h, bottom: 20.h),
                      child: Image.asset("assets/images/notFound.png"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0.h),
                      child: Text(
                        'There are no suitable products',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      'Please try using other keywords to find the product name',
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    ),
                  ],
                ),
              )
                  : Container(), // If searchText is empty, don't show any products
            ),
          ],
        ),
      ),
    );
  }

  void clearProducts(ProductState state) {
    setState(() {
      // Clear the products list
      state.products.clear();
    });
  }
}
