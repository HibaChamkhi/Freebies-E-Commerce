import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/used_functions.dart';
import '../../../products/presentation/pages/announcements_page.dart';
import '../bloc/login_bloc/login_bloc.dart';
import 'package:savane_vendeur/injection_container.dart' as di;
import '../widgets/login_widget.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<LoginBloc>()),
        ],
        child: Scaffold(
          backgroundColor: const Color(0xffFFFFFF),
          body: _buildBody(),
        ));
  }

  Widget _buildBody() {
    return Center(
      child: BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
        if (state.error.isNotEmpty) {
          showSnackBar(
              context,
             state.error,
              fuzzyWuzzyBrown.withOpacity(0.8));
        } else if (state.success) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const AnnouncementsPage()));
        }
      }, builder: (context, state) {
        return LoginWidget(isLoading: state.isLoading);
      }),
    );
  }
}
