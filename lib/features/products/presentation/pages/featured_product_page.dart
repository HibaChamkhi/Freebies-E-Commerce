import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freebies_e_commerce/features/products/presentation/bloc/product_bloc.dart';
import '../../../../core/config/injection/injection.dart';
import '../widgets/product_box.dart';

class FeaturedProductPage extends StatefulWidget {
  const FeaturedProductPage({super.key});

  @override
  State<FeaturedProductPage> createState() => _FeaturedProductPageState();
}

class _FeaturedProductPageState extends State<FeaturedProductPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductBloc>()
        ..add(const GetAllProductsEvent())
      ,
      child: _buildBody(),
    );
  }
  Widget _buildBody() {
    return  BlocConsumer<ProductBloc, ProductState>(listener: (context, state) {
      }, builder: (context, state) {
      print(state.products);
        return Container(
          color: const Color(0xFFFAFAFA),
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Product',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(fontSize: 14.0, color: Colors.blue),
                  ),
                ],
              ),
              Flexible(
                child: SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(top: 20.0.h,bottom: 20.h,left: 10.w),
                        child: ProductBox(product: state.products[index]),
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

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<ProductBloc>(context)
        .add(const GetAllProductsEvent());
  }
}



