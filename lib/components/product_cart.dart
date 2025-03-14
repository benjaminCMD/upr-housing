import 'package:flutter/material.dart';
import 'package:upr_housing/components/product.dart';


class ProductCardApp extends StatefulWidget {
  //Required Product to initialize the card
  Product product;

  ProductCardApp({
    super.key,
    required this.product,
  });

  @override
  State<ProductCardApp> createState() => _ProductCardAppState();
}

class _ProductCardAppState extends State<ProductCardApp> {
  @override
  Widget build(BuildContext context) {
    return  Card(
      color:const Color.fromARGB(255, 213, 208, 194),
      margin: EdgeInsets.all(8),
      child: Row(mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(widget.product.imageUrl,
          width: 225,
          height: 200,
          fit:BoxFit.cover
          ),
          Expanded(child:Padding(
            padding: EdgeInsets.all(7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.product.owner),//name of the owner
                SizedBox(height: 20,),
                Text('Summary: ' + widget.product.summary),
                SizedBox(height: 20,),
                Text('Price: ' + widget.product.price.toString(),
                ),
                SizedBox(height: 20,),
                Row(children: [
                  Icon(Icons.thumb_up,color: Colors.red,),
                  Text("   " + widget.product.likes.toString())
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