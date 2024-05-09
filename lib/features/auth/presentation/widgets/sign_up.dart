import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/auth/presentation/widgets/sign_in.dart';
import 'package:freebies_e_commerce/features/auth/presentation/widgets/verification_screen.dart';
import '../../../../core/config/themes/app_theme.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final userIdController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:       Row(
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
                      style: TextStyle(fontSize: 16, ),
                    ),  Text(
                      "Sign In",
                      style: TextStyle(fontSize: 16, color: marinerApprox),
                    ),
                  ],
                )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0, left: 16, right: 16),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Register Account",
                    style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.bold),
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
                  const Text(
                    "Email/ Phone",
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 10.h),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[100],
                      filled: true,
                      labelText: 'Email',
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 150),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const VerificationScreen(emailOrPhone: '50441323',)
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
            ],
          ),
        ),
      ),
    );
  }
}
