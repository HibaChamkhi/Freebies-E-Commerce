import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/auth/presentation/widgets/sign_in.dart';
import '../../../../core/config/themes/app_theme.dart';
import 'dialog_widget.dart';

Widget loginPopupWidget(context){
  return DialogWidget(title: 'Login Account', widget: Column(
    children: [
      Image.asset("assets/images/login.png"),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 20.0.h),
            child: const Text(
              "You need to sign in first",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ),
          const Text(
              textAlign: TextAlign.center,
              "Please login/register first to make a transaction",
              style: TextStyle(
                  color: Colors.grey, fontSize: 14)),
      GestureDetector(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              width: 325,
              height: 50,
              decoration: BoxDecoration(
                  color: marinerApprox,
                  borderRadius: BorderRadius.circular(10)),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignIn()),
              );
            },
          ),
        ],
  ));
}
