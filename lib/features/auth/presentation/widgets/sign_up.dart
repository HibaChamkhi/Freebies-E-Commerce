import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/auth/presentation/pages/sign_up_page.dart';
import 'package:freebies_e_commerce/features/auth/presentation/widgets/register_information.dart';
import 'package:freebies_e_commerce/features/auth/presentation/widgets/sign_in.dart';
import 'package:freebies_e_commerce/features/auth/presentation/widgets/verification_screen.dart';
import '../../../../core/config/themes/app_theme.dart';
import '../../../../core/utils/Input_field.dart';
import '../../../../core/utils/input_validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>(); // Key for the form
  final userIdController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignIn()),
                );
              },
              child: const Row(
                children: [
                  Text(
                    "Have an Account? ",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Sign In",
                    style: TextStyle(fontSize: 16, color: marinerApprox),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0, left: 16, right: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Register Account",
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Enter Email/Number. Mobile to register",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    SizedBox(height: 10.h),

                    InputField(
                      controller: emailController,
                      hintText: 'Email/Phone',
                      validator: (value) =>
                          validateEmail(emailController.text, ),
                    ),
                    SizedBox(height: 340.h),
                    // Add more form fields as needed
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, proceed to verification screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(
                                    emailOrPhone: emailController.text,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 325,
                            height: 50,
                            decoration: BoxDecoration(
                              color: marinerApprox,
                              borderRadius: BorderRadius.circular(10),
                            ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
