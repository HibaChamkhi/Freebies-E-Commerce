import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/products/presentation/widgets/product_box.dart';

import '../../../../core/config/themes/app_theme.dart';
import '../../../../core/utils/widgets/filter_popup.dart';
import '../../data/data_source/supabase_data_source.dart';
import '../../data/models/product/product.dart';
import '../bloc/product_bloc.dart';

class SearchCategoryScreen extends StatefulWidget {
  const SearchCategoryScreen({
    super.key,
    required this.title,
    required this.state,
    required this.isLoggedIn,
    required this.searchProduct,
    required this.sortFunction,
    required this.filterFunction,
  });

  final ProductState state;
  final String title;
  final bool isLoggedIn;
  final Function(String) searchProduct;
  final Function(ProductSortType) sortFunction;
  final Function(List<int>,double,double) filterFunction;

  @override
  State<SearchCategoryScreen> createState() => _SearchCategoryScreenState();
}

class _SearchCategoryScreenState extends State<SearchCategoryScreen> {
  String searchText = '';
  bool showGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
      GestureDetector(
        onTap: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return FilterPopupWidget( context: context,
                sortFunction: (type) {
                widget.sortFunction(type);
              },
                subCategories:widget.state.subCategories,
                filterFunction: (list,min,max) {
                  widget.filterFunction(list,min,max);
                },);
            },
          );
        },
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
            padding: EdgeInsets.symmetric(
              vertical: 20.h,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), border: Border.all()),
            child: const Text(
              "Filter & Sorting",
              textAlign: TextAlign.center,
            )),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Category',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(widget.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20.0.h,
              ),
              child: TextField(
                onChanged: (query) {
                  setState(() {
                    searchText = query;
                    showGrid = false;
                  });
                  // Call your function here
                  if (query.isNotEmpty) {
                    widget.searchProduct(query);
                  } else {
                    setState(() {
                      showGrid = true;
                    });
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
            ),
            Expanded(
                child: showGrid
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
                              isLoading: widget.state.productsStatus ==
                                  ProductsStatus.loading,
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
                            Text(widget.state.products[index].name),
                          ],
                        ),
                      ),
                    );
                  },
                )
                            //   ),
                       )
          ],
        ),
      ),
    );
  }
}
