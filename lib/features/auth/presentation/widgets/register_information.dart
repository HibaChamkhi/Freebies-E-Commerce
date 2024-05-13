import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/config/themes/app_theme.dart';
import '../../../../core/utils/Input_field.dart';
import '../../../../core/utils/input_validator.dart';
import '../../data/models/user.dart';
import '../bloc/register_bloc/register_bloc.dart';
import '../pages/sign_up_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class RegisterInformation extends StatefulWidget {
  const RegisterInformation({super.key, required this.emailOrPhone});
  final String emailOrPhone ;
  @override
  State<RegisterInformation> createState() => _RegisterInformationState();
}

class _RegisterInformationState extends State<RegisterInformation> {
  final _formKey = GlobalKey<FormState>(); // Key for the form
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final picker = ImagePicker();
  File? imageFile;

  Future<void> _pickImageFromGallery() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;
      setState(() {
        imageFile = File(pickedFile.path);
      });
    } catch (errorMsg) {
      print("image error msg ${errorMsg.toString()}");
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile == null) return;
      setState(() {
        imageFile = File(pickedFile.path);
      });
    } catch (errorMsg) {
      print("image error msg ${errorMsg.toString()}");
    }
  }

  void _showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  _pickImageFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () {
                  _pickImageFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                final isValid = _formKey.currentState!.validate() ;
                // final supabase = Supabase.instance.client;
                if (isValid) {
                    final String email;
                    final String password;
                    final String username;

                    email = widget.emailOrPhone;
                    password = passwordController.text;
                    username = nameController.text;

                    BlocProvider.of<RegisterBloc>(context).add(CreateAccountEvent(
                        user: UserModel(
                          username: username,
                          email: email,
                          password: password,
                        ),imageFile!));
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
                  'Confirmation',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
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
                        "Profile & Password",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showImagePickerBottomSheet(context);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 50,
                              backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
                              child: imageFile == null
                                  ? Icon(Icons.camera_alt, size: 50, color: Colors.grey[100])
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputField(
                        controller: nameController,
                        hintText: 'Full Name',
                        validator: (value) => validateField(nameController.text,"Full Name",),
                      ),
                      SizedBox(height: 40),
                      InputField(
                        controller: passwordController,
                        hintText: 'password',
                        validator: (value) => validatePassword(passwordController.text,"Password",),
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
