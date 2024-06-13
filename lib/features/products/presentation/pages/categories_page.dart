import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/products/data/data_source/supabase_data_source.dart';
import 'package:freebies_e_commerce/features/products/presentation/bloc/product_bloc.dart';
import '../../../../core/config/injection/injection.dart';
import '../../../../core/config/themes/app_theme.dart';
import '../widgets/category_box.dart';
import '../widgets/category_popup.dart';
import '../widgets/product_box.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key, required this.isLoggedIn});
  final bool isLoggedIn ;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductBloc>()
        ..add(const GetAllCategoriesEvent())
      ,
      child: _buildBody(),
    );
  }
  Widget _buildBody() {
    return  BlocConsumer<ProductBloc, ProductState>(listener: (context, state) {
      if (state.categoriesStatus == CategoriesStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.messages),
          ),
        );
      }
      else if (state.categoriesStatus == CategoriesStatus.loading) {
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
      }, builder: (context, state) {
        return Container(
          // color: const Color(0xFFFAFAFA),
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          height: 180.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 10.h),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return categoryPopupWidget(context,state.categories , widget.isLoggedIn , state.categoriesStatus);
                          },
                        );

                      },
                      child: Text(
                        'See All',
                        style: TextStyle(fontSize: 14.0, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: SizedBox(
                  height: 150.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(top: 20.0.h,bottom: 10.h,left: 20.w),
                        child: CategoryBox(category: state.categories[index], isLoading: state.categoriesStatus == CategoriesStatus.loading, isLoggedIn: widget.isLoggedIn,),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      });
  }

  // Future<void> _onRefresh(BuildContext context) async {
  //   BlocProvider.of<ProductBloc>(context)
  //       .add(const GetAllProductsEvent());
  // }
}



