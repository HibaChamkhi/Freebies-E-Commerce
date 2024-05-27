import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/injection/injection.dart';
import '../../../../core/config/themes/app_theme.dart';
import '../bloc/news_bloc.dart';
import '../widgets/news.dart';

class HomeNewsPage extends StatefulWidget {
  const HomeNewsPage({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  @override
  State<HomeNewsPage> createState() => _HomeNewsPageState();
}

class _HomeNewsPageState extends State<HomeNewsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NewsBloc>()..add(GetNewsEvent()),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<NewsBloc, NewsState>(
        listener: (context, state) {
          if (state.newsStatus == NewsStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.messages),
              ),
            );
          }
          else if (state.newsStatus == NewsStatus.loading) {
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
        },
        builder: (context, state) {
          return  News(state: state, isLoggedIn: widget.isLoggedIn,);
        });
  }

// Future<void> _onRefresh(BuildContext context) async {
//   BlocProvider.of<ProductBloc>(context)
//       .add(const GetAllProductsEvent());
// }
}
