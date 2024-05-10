import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freebies_e_commerce/features/auth/presentation/widgets/sign_up.dart';
import 'package:freebies_e_commerce/features/auth/presentation/widgets/verification_screen.dart';
import '../../../../core/config/themes/app_theme.dart';
import '../../../../core/utils/Input_field.dart';
import '../../../../core/utils/input_validator.dart';
import '../bloc/login_bloc/login_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>(); // Key for the form
  final userIdController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp()),
                );
              },
              child: const Text(
                "Sign Up",
                style: TextStyle(fontSize: 16, color: marinerApprox),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(top: 100.0, left: 16, right: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Welcome back to Mega Mall",
                        style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Please enter data to log in",
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const SizedBox(height: 10),
                      InputField(
                        controller: emailController,
                        hintText: 'Email/Phone',
                        validator: (value) => validateEmail(emailController.text,),

                      ),
                      const SizedBox(height: 20),
                      InputField(
                        controller: passwordController,
                        hintText: 'password',
                        validator: (value) => validatePassword(passwordController.text,"password",),
                      ),

                      const SizedBox(height: 150),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              final isValid = _formKey.currentState!.validate();
                              if (isValid) {
                                final String email;
                                final String password;

                                email = emailController.text;
                                password = passwordController.text;

                                BlocProvider.of<LoginBloc>(context).add(LoginUserEvent(
                                  email: email,
                                  password: password,
                                ));
                              }
                            },
                            child: Container(
                                alignment: Alignment.center,
                                width: 325,
                                height: 50,
                                decoration:  BoxDecoration(color: marinerApprox,borderRadius: BorderRadius.circular(10)),
                                child: const Text('Sign In',style: TextStyle(color: Colors.white),)
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
