import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/news.dart';
import '../bloc/news_bloc.dart';
import 'news_detail.dart';

class NewBox extends StatefulWidget {
  const NewBox({super.key, required this.newsModel});

  final NewsModel newsModel;

  @override
  State<NewBox> createState() => _NewBoxState();
}

class _NewBoxState extends State<NewBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewsDetails(news: widget.newsModel,) ),
        );
      },
      child: Container(
        // height: 100,
        padding: EdgeInsets.symmetric(vertical: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 250, child: Text(widget.newsModel.title,style: TextStyle(fontWeight: FontWeight.bold),)),
                SizedBox(
                  width: 250,
                  child: Text(
                    widget.newsModel.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(extractDate(widget.newsModel.created_at)),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
              ),
              child: Image.network(
                widget.newsModel.image,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
