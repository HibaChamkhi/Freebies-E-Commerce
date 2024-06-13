import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/news.dart';
import '../bloc/news_bloc.dart';

class NewsDetails extends StatefulWidget {
  const NewsDetails({super.key, required this.news});
  final NewsModel news ;
  @override
  State<NewsDetails> createState() => _newsDetailsState();
}

class _newsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Detail news"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                    child: Image.network(
                      widget.news.image,
                      width: 360.w,
                      height: 220.h,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.h,),
              Text(widget.news.title,style:TextStyle(fontSize: 24.0.sp,fontWeight: FontWeight.bold) ,),
              SizedBox(height: 10.h,),
              Text(extractDate(widget.news.created_at),style: TextStyle(fontSize: 12.0.sp,fontWeight: FontWeight.bold,color: Colors.grey),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(widget.news.description),
              ),
            ],
          ) ,
        ),
      ),
    );
  }
}
