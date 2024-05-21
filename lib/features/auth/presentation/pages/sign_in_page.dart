import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/auth/presentation/widgets/sign_in.dart';
import 'package:freebies_e_commerce/features/home.dart';
import '../../../../core/config/injection/injection.dart';
import '../../../../core/config/themes/app_theme.dart';
import '../bloc/login_bloc/login_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<LoginBloc>()),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.loginStatus == LoginStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.messages),
              ),
            );
          }
          else if (state.loginStatus == LoginStatus.loading) {
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
          } else if (state.loginStatus == LoginStatus.success) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(
                    isLoggedIn: true,
                  ),
                ),
              );
            });
          }


        },
        builder: (context, state) {
          return SignIn(
            loginContext: context,
          );
        },
      ),
    );
  }
}
