import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/auth/presentation/widgets/register_information.dart';
import '../../../../core/config/themes/app_theme.dart';
import '../pages/sign_in_page.dart';
import '../pages/sign_up_page.dart';

class VerificationScreen extends StatefulWidget {
  final String emailOrPhone;

  const VerificationScreen({Key? key, required this.emailOrPhone}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _codeControllers = List.generate(4, (_) => TextEditingController());
  List<String> _errors = List.filled(4, '');

  @override
  void dispose() {
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _verifyCode() async {
    // Verification logic here
  }

  void _resendCode() async {
    // Resend code logic here
  }

  bool _isCodeFilled() {
    bool isFilled = true;
    for (int i = 0; i < _codeControllers.length; i++) {
      if (_codeControllers[i].text.isEmpty) {
        setState(() {
          _errors[0] = 'Please fill this field';
        });
        isFilled = false;
      }
      else {
        setState(() {
          _errors[0] = '';
        });
      }
    }
    return isFilled;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 100.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Verification",
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            Text(
              "We have sent a verification code to ${widget.emailOrPhone}. Change?",
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(height: 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Verification Code', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                TextButton(
                  onPressed: _resendCode,
                  child: const Text(
                    'Re-send Code',
                    style: TextStyle(color: marinerApprox, fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) => _buildCodeTextField(index)),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) => Text(_errors[index], style: TextStyle(color: Colors.red))),
            ),
            SizedBox(height: 200.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (_isCodeFilled()) {
                      // If all code fields are filled, proceed with verification
                      _verifyCode();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  SignInPage()),
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 325,
                    height: 50,
                    decoration: BoxDecoration(color: marinerApprox, borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      'Continue',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeTextField(int index) {
    return SizedBox(
      width: 75.0,
      height: 50.0,
      child: TextField(
        controller: _codeControllers[index],
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          counterText: "",
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          // errorText: _errors[0],
        ),
        onChanged: (value) {
          setState(() {
            if (value.isNotEmpty) {
              _errors[index] = '';
            }
          });
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
