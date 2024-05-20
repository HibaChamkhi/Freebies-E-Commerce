import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogWidget extends StatefulWidget {
  const DialogWidget({super.key, required this.title, required this.widget, this.isDivider = true});
  final String title;
  final Widget widget;
  final bool isDivider ;

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) {
 return   AlertDialog(
      backgroundColor: const Color(0xFFFFFFFF),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(widget.title),
          GestureDetector(
            onTap: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Icon(Icons.close),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            if(widget.isDivider)
            const Divider(),
            SizedBox(height: 20.h,),
            widget.widget
          ],
        ),
      ),
    );
  }
}


