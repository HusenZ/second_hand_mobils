import 'package:flutter/material.dart';
import 'package:second_hand_mobils/constants/global_variables.dart';
import 'package:second_hand_mobils/widgets/display_product.dart';
import 'package:second_hand_mobils/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
            onTap: () {},
          );
        },
        itemCount: products.length,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
