import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/products/data/data_source/supabase_data_source.dart';
import 'package:freebies_e_commerce/features/products/presentation/bloc/product_bloc.dart';
import 'package:freebies_e_commerce/features/products/presentation/bloc/search/search_bloc.dart';
import 'package:freebies_e_commerce/features/products/presentation/widgets/search_screen.dart';
import '../../../../core/config/injection/injection.dart';
import '../../../../core/config/themes/app_theme.dart';
import '../widgets/product_box.dart';

class SearchProductPage extends StatefulWidget {
  const SearchProductPage({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SearchBloc>()..add(GetSearchValueEvent()),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state.searchProductsStatus == SearchProductsStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.messages),
              ),
            );
          }
          else if (state.searchProductsStatus == SearchProductsStatus.loading) {
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
          print("GetSearchValueEvent : ${state.searchValue}");
          return SearchScreen(searchProduct: (query) {
            BlocProvider.of<SearchBloc>(context)
                .add( SearchProductEvent(query: query));
          }, isLoggedIn: widget.isLoggedIn, state: state,);
        });
  }

// Future<void> _onRefresh(BuildContext context) async {
//   BlocProvider.of<ProductBloc>(context)
//       .add(const GetAllProductsEvent());
// }
}
