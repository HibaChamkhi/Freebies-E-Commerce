import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/products/data/models/search/search.dart';

import '../../../../core/config/themes/app_theme.dart';
import '../bloc/product_bloc.dart';
import '../bloc/search/search_bloc.dart';
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
  final SearchState state;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                setState(() {
                  searchText = query;
                  showGrid = false;
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
            const SizedBox(
              height: 20,
            ),
            (!showGrid && (searchText.isNotEmpty && widget.state.products.isNotEmpty))
                ? Text(
                    "Search Suggestions",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
                  ) : Container(),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child:
              searchText.isNotEmpty
                      ? widget.state.products.isNotEmpty
                          ? showGrid
                              ? SizedBox(
                                  height: 250,
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 8.0.w,
                                          mainAxisSpacing: 15.0.h,
                                          mainAxisExtent:210,
                                    ),
                                    itemCount: widget.state.products.length,
                                    itemBuilder: (context, index) {
                                      return ProductBox(
                                        product: widget.state.products[index],
                                        isLoading:
                                            widget.state.searchProductsStatus ==
                                                SearchProductsStatus.loading,
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
                                        if (!showGrid) {
                                          setState(() {
                                            showGrid = true;
                                          });
                                        }
                                        BlocProvider.of<SearchBloc>(context)
                                            .add(SetSearchValueEvent(
                                                searchValue: SearchModel(
                                          text: searchText,
                                        )));
                                      },
                                      child: ListTile(
                                        title: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.search,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(widget
                                                .state.products[index].name),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                          : Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 120.0.h, bottom: 20.h),
                                    child: Image.asset(
                                        "assets/images/notFound.png"),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.0.h),
                                    child: Text(
                                      'There are no suitable products',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Text(
                                    'Please try using other keywords to find the product name',
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.grey),
                                  ),
                                ],
                              ),
                            )
                      : ListView.builder(
                          itemCount: widget.state.searchValue.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  String query =
                                      widget.state.searchValue[index].text;
                                  widget.searchProduct(query);
                                  searchText = query;
                                  showGrid = true;
                                });
                              },
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.access_time_rounded,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(widget
                                            .state.searchValue[index].text),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<SearchBloc>(context)
                                            .add(DeleteSearchValueEvent(
                                                id: widget.state
                                                    .searchValue[index].id!));
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                  // : Container(),
            ),
          ],
        ),
      ),
    );
  }

  void clearProducts(SearchState state) {
    setState(() {
      // Clear the products list
      state.products.clear();
    });
  }
}
