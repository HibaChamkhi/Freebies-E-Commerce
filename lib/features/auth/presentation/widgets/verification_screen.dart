import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/auth/presentation/widgets/register_information.dart';

import '../../../../core/config/themes/app_theme.dart';

class VerificationScreen extends StatefulWidget {
  final String emailOrPhone ;

  const VerificationScreen({super.key, required this.emailOrPhone});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {

  final _codeControllers = List.generate(4, (_) => TextEditingController());
  bool _isLoading = false;

  @override
  void dispose() {
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _verifyCode() async {
    setState(() {
      _isLoading = true;
    });

    // Replace this with your actual code to verify the code with backend
    // This could involve calling an API with the entered code
    // and handling success/failure scenarios
    String enteredCode = "";
    for (var controller in _codeControllers) {
      enteredCode += controller.text;
    }
    bool isValid = await Future.delayed(Duration(seconds: 2), () => enteredCode == '1234');

    setState(() {
      _isLoading = false;
    });

    if (isValid) {
      // Code verified, navigate to next screen
    } else {
      // Show error message
    }
  }

  void _resendCode() async {
    // Replace this with your logic to resend the verification code
    // This could involve calling an API to send a new code
    await Future.delayed(const Duration(seconds: 2), () => print('Code resent'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 50.0.w,vertical: 100.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Verification",
              style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "We have sent a verification code to ${widget.emailOrPhone} Change?",
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(
              height: 50.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Text('Verification Code',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14)),
                TextButton(
                  onPressed: _resendCode,
                  child: const Text('Re-send Code',style: TextStyle(color: marinerApprox,fontWeight: FontWeight.w500,fontSize: 14),),
                ),
              ],
            ),
            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) => _buildCodeTextField(index)),
            ),
            const SizedBox(height: 150),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterInformation()
                      ),
                    );

                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: 325,
                      height: 50,
                      decoration:  BoxDecoration(color: marinerApprox,borderRadius: BorderRadius.circular(10)),
                      child: const Text('Continue',style: TextStyle(color: Colors.white),)
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
          fillColor: Colors.grey[100] ,
          counterText: "",
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}

