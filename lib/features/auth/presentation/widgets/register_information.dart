import 'package:flutter/material.dart';
import '../../../../core/config/themes/app_theme.dart';

class RegisterInformation extends StatefulWidget {
  const RegisterInformation({Key? key}) : super(key: key);

  @override
  State<RegisterInformation> createState() => _RegisterInformationState();
}

class _RegisterInformationState extends State<RegisterInformation> {
  final userIdController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "Profile & Password",
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Complete the following final data to enter the Mega Mall application",
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Full Name",
                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[100],
                        filled: true,
                        labelText: 'Full Name',
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
                              child: const Text('Confirmation',style: TextStyle(color: Colors.white),)
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
