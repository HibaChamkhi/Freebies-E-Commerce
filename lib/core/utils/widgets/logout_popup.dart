import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/auth/presentation/pages/sign_in_page.dart';
import '../../../../core/config/themes/app_theme.dart';
import '../../../features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import '../../config/injection/injection.dart';
import 'dialog_widget.dart';

class logoutPopupWidget extends StatefulWidget {
  const logoutPopupWidget({super.key});

  @override
  State<logoutPopupWidget> createState() => _logoutPopupWidgetState();
}

class _logoutPopupWidgetState extends State<logoutPopupWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<LoginBloc>()),
      ],
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.loginStatus == LoginStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.messages),
            ),
          );
        } else if (state.loginStatus == LoginStatus.loading) {
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
                builder: (context) => const SignInPage(),
              ),
            );
          });
        }
      },
      builder: (context, state) {
        return DialogWidget(
          title: 'Logout Account',
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0.h),
                child: const Text(
                  "You need to logout",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<LoginBloc>(context).add(LogoutEvent());
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.center,
                  width: 325.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: marinerApprox,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
