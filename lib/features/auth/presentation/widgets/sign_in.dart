import 'package:flutter/material.dart';
import '../../../../core/config/themes/app_theme.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const SignUp()),
                  // );
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 16, color: marinerApprox),
                )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(top: 100.0, left: 16, right: 16),
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
                    const Text(
                      "Email/ Phone",
                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[100],
                        filled: true,
                        labelText: 'Email',
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                    SizedBox(height: 40),
                    const Text(
                      "Password",
                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400)
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[100],
                        filled: true,
                        labelText: 'Password',
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 150),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
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
    );
  }
}
