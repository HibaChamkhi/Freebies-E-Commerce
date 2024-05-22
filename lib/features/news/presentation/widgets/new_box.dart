import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/widgets/login_popup.dart';
import '../../data/models/news.dart';
import '../bloc/news_bloc.dart';
import 'news_detail.dart';

class NewBox extends StatefulWidget {
  const NewBox({super.key, required this.newsModel, required this.isLoggedIn});

  final NewsModel newsModel;
  final bool isLoggedIn;

  @override
  State<NewBox> createState() => _NewBoxState();
}

class _NewBoxState extends State<NewBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.isLoggedIn
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewsDetails(
                          news: widget.newsModel,
                        )),
              )
            : showDialog(
                context: context,
                builder: (BuildContext context) {
                  return loginPopupWidget(context);
                },
              );
        ;
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
                SizedBox(
                    width: 250.w,
                    child: Text(
                      widget.newsModel.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  width: 250.w,
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
              margin: EdgeInsets.only(left: 10.w),
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
