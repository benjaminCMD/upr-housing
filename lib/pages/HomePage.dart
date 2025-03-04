import 'package:flutter/material.dart';
import 'package:upr_housing/components/Product.dart';
import 'package:upr_housing/components/ProductList.dart';
import 'package:upr_housing/components/ProductCard.dart';

// Here is the Product list, we have to make this somehow able to recover the data from the firebase, instead of having it locally
class HomePage extends StatelessWidget{
  final List<Product> products = p;
  HomePage({super.key});

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products List')
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index){
          final product = products[index];
          return SizedBox(
            height:225,
            child: ProductCard(product: product),
            );
        },
      )
    );
  }
}