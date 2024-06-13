import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../config/themes/app_theme.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  late void Function(String value)? onChanged;
  final String? Function(String?)? validator;
  final String prefixIcon;
  final bool isPassword;

  InputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.inputFormatters,
    this.onChanged,
    this.prefixIcon = 'assets/icons/ic_calendar.svg',
    FocusNode? focusNode,
    this.isPassword = false,
  });

  @override
  State<InputField> createState() => _TextFormFieldWidget();
}

class _TextFormFieldWidget extends State<InputField> {
  bool show = false;
  bool hidePassword = true;
  bool validate = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.hintText,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            )),
        SizedBox(height: 10.h),
        TextFormField(
          controller: widget.controller,
          cursorColor: Colors.blue,
          obscureText: widget.isPassword
              ? hidePassword
              ? true
              : false
              : false,
          onEditingComplete: () {
            FocusScope.of(context).nextFocus();
          },
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          style: TextStyle(
            fontFamily: "Inter",
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 18.sp,
            letterSpacing: widget.isPassword ? 1 : 0,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: widget.hintText,
            fillColor: Colors.grey[100],
            filled: true,
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            suffixIcon: widget.isPassword
                ? InkWell(
              child: Icon(!hidePassword ? Icons.remove_red_eye : Icons.visibility_off ,color: marinerApprox,),
              onTap: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
            )
                : null,
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}