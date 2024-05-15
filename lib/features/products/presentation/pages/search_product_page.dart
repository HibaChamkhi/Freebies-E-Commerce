import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/products/data/data_source/supabase_data_source.dart';
import 'package:freebies_e_commerce/features/products/presentation/bloc/product_bloc.dart';
import 'package:freebies_e_commerce/features/products/presentation/widgets/search_screen.dart';
import '../../../../core/config/injection/injection.dart';
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
      create: (_) => getIt<ProductBloc>(),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SearchScreen(searchProduct: (query) {
            BlocProvider.of<ProductBloc>(context)
                .add( SearchProductEvent(query: query));
          }, isLoggedIn: widget.isLoggedIn, state: state,);
        });
  }

// Future<void> _onRefresh(BuildContext context) async {
//   BlocProvider.of<ProductBloc>(context)
//       .add(const GetAllProductsEvent());
// }
}
