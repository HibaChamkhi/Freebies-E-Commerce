import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/config/themes/app_theme.dart';
import '../../../../core/utils/widgets/filter_popup.dart';
import '../../data/data_source/supabase_data_source.dart';
import '../bloc/news_bloc.dart';
import 'new_box.dart';


class NewsCategoryScreen extends StatefulWidget {
  const NewsCategoryScreen({
    super.key,

    required this.state,
    required this.isLoggedIn,
    required this.searchNews,
  });

  final NewsState state;

  final bool isLoggedIn;
  final Function(String) searchNews;

  @override
  State<NewsCategoryScreen> createState() => _newsCategoryScreenState();
}

class _newsCategoryScreenState extends State<NewsCategoryScreen> {
  String newsText = '';
  bool showGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // Text(widget.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20.0.h,
              ),
              child: TextField(
                onChanged: (query) {
                  setState(() {
                    newsText = query;
                    showGrid = false;
                  });
                  // Call your function here
                  if (query.isNotEmpty) {
                    widget.searchNews(query);
                  } else {
                    setState(() {
                      showGrid = true;
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: alabaster,
                  hintText: 'news news Name',
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
                                crossAxisCount: 1,
                                crossAxisSpacing: 8.0.w,
                                mainAxisSpacing: 0.0.h,
                                mainAxisExtent:130,
                          ),
                          itemCount: widget.state.newsValue.length,
                          itemBuilder: (context, index) {
                            return NewBox(newsModel: widget.state.newsValue[index]);
                          },
                        ),
                      )
                    : ListView.builder(
                  itemCount: widget.state.newsValue.length,
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
                            SizedBox(width:250,child: Text(widget.state.newsValue[index].title)),
                          ],
                        ),
                      ),
                    );
                  },
                )
                       )
          ],
        ),
      ),
    );
  }
}
