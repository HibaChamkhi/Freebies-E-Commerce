import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/themes/app_theme.dart';

class SearchCategoryScreen extends StatefulWidget {
  const SearchCategoryScreen({super.key, required this.title});
final String title ;
  @override
  State<SearchCategoryScreen> createState() => _SearchCategoryScreenState();
}

class _SearchCategoryScreenState extends State<SearchCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(
      backgroundColor: Colors.white,
    title: const Text('Category'),
    ),
      body: Column(
        children: [
          Text(widget.title),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 30.w),
            child: TextField(
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
        ],
      ),
    );
  }
}
