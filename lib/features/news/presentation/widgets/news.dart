import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/news/data/models/news.dart';
import 'package:freebies_e_commerce/features/news/presentation/bloc/news_bloc.dart';
import 'package:freebies_e_commerce/features/news/presentation/widgets/new_box.dart';
import 'package:freebies_e_commerce/features/news/presentation/widgets/search_news_screen.dart';

class News extends StatefulWidget {
  const News({super.key, required this.state, required this.isLoggedIn});

  final bool isLoggedIn;
  final NewsState state;

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                "Latest News",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          // Wrap ListView.builder in a ConstrainedBox
          ConstrainedBox(
            constraints:  BoxConstraints(
              maxHeight: 500.0.h // Adjust this value as needed
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return NewBox(
                  newsModel: widget.state.newsValue[index],
                  isLoggedIn: widget.isLoggedIn,
                );
              },
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewsCategoryScreen(
                          state: widget.state,
                          isLoggedIn: widget.isLoggedIn,
                          searchNews: (String) {},
                        )),
              );
            },
            child: Container(
              alignment: Alignment.center,
              width: 325,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "See All News",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
