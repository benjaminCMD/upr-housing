import 'package:flutter/material.dart';
import 'package:upr_housing/components/Product.dart';


class ProductCard extends StatelessWidget {
  //Required Product to initialize the card
  final Product product;

  const ProductCard({
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
          height: 200,
          fit:BoxFit.cover
          ),
          Expanded(child:Padding(
            padding: EdgeInsets.all(7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 0,
                ),
                Text(product.Owner),//name of the Owner
                SizedBox(height: 25,),
                Text('Summary: ' + product.summary),
                SizedBox(height: 25,),
                Text('Price: ' + product.price.toString(),
                ),
                SizedBox(height: 25,),
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