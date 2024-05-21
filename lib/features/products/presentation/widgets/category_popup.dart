import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/products/data/models/category/category.dart';
import '../../../../core/utils/widgets/dialog_widget.dart';
import '../bloc/product_bloc.dart';
import 'category_box.dart';

Widget categoryPopupWidget(context,List<CategoryModel> categories ,bool isLoggedIn ,CategoriesStatus categoriesStatus){
  return DialogWidget(title: 'Categories', widget:
  Container(
    height: 250,
    width: 350,
    padding: EdgeInsets.symmetric(vertical: 20.h),
    child: Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of items in each row
          crossAxisSpacing: 14.0.w, // Spacing between columns
          mainAxisSpacing: 35.0.h, // Spacing between rows
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            // margin: EdgeInsets.only(left: 20.0.w),
            child: CategoryBox(
              category: categories[index],
              isLoading: categoriesStatus == CategoriesStatus.loading,
              isLoggedIn: isLoggedIn,
            ),
          );
        },
      ),
    ),
  ),);
}
