import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:freebies_e_commerce/features/auth/presentation/pages/sign_in_page.dart';
import 'package:freebies_e_commerce/features/auth/presentation/widgets/register_information.dart';
import 'package:freebies_e_commerce/features/auth/presentation/widgets/sign_in.dart';
import 'package:freebies_e_commerce/features/home.dart';
import '../../../../core/config/injection/injection.dart';
import '../../../../core/config/themes/app_theme.dart';
import '../bloc/login_bloc/login_bloc.dart';
import '../widgets/sign_up.dart';
import '../widgets/verification_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.emailOrPhone});
  final String emailOrPhone ;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<RegisterBloc>()),
        ],
        child: Scaffold(
          backgroundColor: const Color(0xffFFFFFF),
          body: _buildBody(),
        ));
  }

  Widget _buildBody() {
    return Center(
      child: BlocConsumer<RegisterBloc, RegisterState>(listener: (context, state) {
        if (state.registerStatus == RegisterStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.messages),
            ),
          );
        }
         if (state.registerStatus == RegisterStatus.loading) {
          Center(
            child: SizedBox(
              height: 60.h,
              child: const Center(
                child: CircularProgressIndicator(
                  color: marinerApprox,
                ),
              ),
            ),
          );
        }
         if (state.registerStatus == RegisterStatus.success)
         {
           WidgetsBinding.instance.addPostFrameCallback((_) {
             Navigator.of(context).pushReplacement(
                 MaterialPageRoute(builder: (_) =>
                     VerificationScreen(emailOrPhone: widget.emailOrPhone,) )
             );
           });
         }
         {

        }
      }, builder: (context, state) {
        return  RegisterInformation(emailOrPhone: widget.emailOrPhone,);
      }),
    );
  }
}
