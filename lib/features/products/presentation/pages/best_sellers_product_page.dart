import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/products/data/data_source/supabase_data_source.dart';
import 'package:freebies_e_commerce/features/products/presentation/bloc/product_bloc.dart';
import '../../../../core/config/injection/injection.dart';
import '../widgets/product_box.dart';
import '../widgets/see_all_product_widget.dart';

class BestSellersProductPage extends StatefulWidget {
  const BestSellersProductPage({super.key, required this.isLoggedIn});
  final bool isLoggedIn ;

  @override
  State<BestSellersProductPage> createState() => _BestSellersProductPageState();
}

class _BestSellersProductPageState extends State<BestSellersProductPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductBloc>()
        ..add(const GetBestSellersEvent())
      ,
      child: _buildBody(),
    );
  }
  Widget _buildBody() {
    return  BlocConsumer<ProductBloc, ProductState>(listener: (context, state) {
      }, builder: (context, state) {
        return Container(
          height: 350.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 10.h),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Best Sellers ',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  SeeAllProduct(productsStatus: state.productsStatus, isLoggedIn: widget.isLoggedIn, title:  'Best Sellers ', products: state.bestSellers,)),
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
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.bestSellers.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(top: 20.0.h,bottom: 20.h,left: 20.w),
                        child: ProductBox(product: state.bestSellers[index], isLoading: state.productsStatus == ProductsStatus.loading, isLoggedIn: widget.isLoggedIn,),
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



