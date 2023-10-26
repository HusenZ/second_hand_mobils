import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:second_hand_mobils/constants/global_variables.dart';
import 'package:second_hand_mobils/models/product_model.dart';
import 'package:second_hand_mobils/models/show_snack.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
        title: Text(product.name.padRight(1)),
      ),
      body: ListView(
        children: [
          CachedNetworkImage(imageUrl: product.image),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product.price),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Description:-\n${product.description}',
              style: const TextStyle(fontSize: 15),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              showSnackBar(context, 'Added to Favorite');
            },
            icon: const Icon(Icons.favorite),
            label: const Text('Add to Favorite'),
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(22),
            ),
          )
        ],
      ),
    );
  }
}
