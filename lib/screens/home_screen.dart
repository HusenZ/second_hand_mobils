import 'package:flutter/material.dart';
import 'package:second_hand_mobils/bloc/app_bloc/app_bloc.dart';
import 'package:second_hand_mobils/bloc/app_bloc/app_event.dart';
import 'package:second_hand_mobils/bloc/app_bloc/app_state.dart';
import 'package:second_hand_mobils/constants/global_variables.dart';
import 'package:second_hand_mobils/screens/product_details.dart';
import 'package:second_hand_mobils/widgets/display_product.dart';
import 'package:second_hand_mobils/widgets/search_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: GlobalVariables.appBarGradient,
                ),
              ),
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SearchActionField(),
                  )
                ],
              ),
            ),
          ),
          body: ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                child: DisplayProduct(product: products[index]),
                onTap: () {
                  context
                      .read<AppBloc>()
                      .add(ProductDetailScreenEvent(product: products[index]));
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return ProductDetailsScreen(
                        product: products[index],
                      );
                    },
                  ));
                },
              );
            },
            itemCount: products.length,
            scrollDirection: Axis.vertical,
          ),
        );
      },
    );
  }
}
