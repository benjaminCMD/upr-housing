import 'package:flutter/material.dart';
import 'package:upr_housing/components/product.dart';


class ProductCardApp extends StatelessWidget {
  //Required Product to initialize the card
  final Product product;

  const ProductCardApp({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return  Card(
      color:const Color.fromARGB(255, 213, 208, 194),
      margin: EdgeInsets.all(8),
      child: Row(mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(product.imageUrl,
          width: 225,
          height: 225,
          fit:BoxFit.cover
          ),
          Expanded(child:Padding(
            padding: EdgeInsets.all(7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title),//name of the owner
                SizedBox(height: 20,),
                Text('Summary: ' + product.summary),
                SizedBox(height: 20,),
                Text('Price: ' + product.price.toString(),
                ),
                SizedBox(height: 20,),
                Row(children: [
                  Icon(Icons.thumb_up,color: Colors.red,),
                  Text("   " + product.likes.toString())
                ],)
              ],
            ),
            ),
            ),
        ], 
      ),
    );
  }
}