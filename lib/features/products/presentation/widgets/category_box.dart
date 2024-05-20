import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/products/data/models/category/category.dart';
import '../../../../core/utils/widgets/login_popup.dart';
import '../pages/search_by_category_page.dart';


class CategoryBox extends StatefulWidget {
  const CategoryBox({super.key, required this.category, required this.isLoading, required this.isLoggedIn});
  final CategoryModel category;
  final bool isLoading;
  final bool isLoggedIn;
  @override
  State<CategoryBox> createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        widget.isLoggedIn
            ? Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SearchByCategoryPage(title: widget.category.name, id:widget.category.id.toString(), isLoggedIn:  widget.isLoggedIn,
              )),
        )
            : showDialog(
          context: context,
          builder: (BuildContext context) {
            return loginPopupWidget(context);
          },
        );

      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.all(Radius.circular(15.r)),
            ),
            child: Image.network(
              widget.category.image,
            ),
          ),
           SizedBox(height: 10.h,),
          Text(widget.category.name,style: TextStyle(fontSize: 14.sp),)
        ],
      ),
    );
  }
}
