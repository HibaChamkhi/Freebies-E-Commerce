import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/products/data/data_source/supabase_data_source.dart';
import 'package:freebies_e_commerce/features/products/presentation/bloc/product_bloc.dart';
import '../../../../core/config/injection/injection.dart';
import '../widgets/category_box.dart';
import '../widgets/category_popup.dart';
import '../widgets/product_box.dart';
import '../widgets/search_category_screen.dart';

class SearchByCategoryPage extends StatefulWidget {
  const SearchByCategoryPage({super.key, required this.title, required this.id, required this.isLoggedIn});
  final String title ;
  final String id ;
  final bool isLoggedIn ;

  @override
  State<SearchByCategoryPage> createState() => _SearchByCategoryPageState();
}

class _SearchByCategoryPageState extends State<SearchByCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductBloc>()
        ..add(GetProductsByCategoryEvent(id: widget.id))
      ,
      child: _buildBody(),
    );
  }
  Widget _buildBody() {
    return  BlocConsumer<ProductBloc, ProductState>(listener: (context, state) {
      }, builder: (context, state) {
        return SearchCategoryScreen(title: widget.title, state: state, isLoggedIn: widget.isLoggedIn,
          searchProduct: (query) {
            BlocProvider.of<ProductBloc>(context)
                .add(SearchProductByCategoryEvent(query: query, id: widget.id));
        }, sortFunction: (type) {
            BlocProvider.of<ProductBloc>(context)
                .add(GetProductSortTypeEvent(id:  widget.id, type: type));
          } ,);
      });
  }

  // Future<void> _onRefresh(BuildContext context) async {
  //   BlocProvider.of<ProductBloc>(context)
  //       .add(const GetAllProductsEvent());
  // }
}



