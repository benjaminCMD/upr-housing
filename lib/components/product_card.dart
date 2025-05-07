import 'package:flutter/material.dart';
import 'package:upr_housing/components/product.dart';
import 'package:upr_housing/pages/focus_apartment.dart';

class ProductCardApp extends StatefulWidget {
  //Required Product to initialize the card
  final Product product;

  const ProductCardApp({
    super.key,
    required this.product,
  });

  @override
  State<ProductCardApp> createState() => _ProductCardAppState();
  
}




class _ProductCardAppState extends State<ProductCardApp> {
  
    void movetoFocusApartment(Product p)
  {
    Navigator.push(context,MaterialPageRoute(builder: (context) => FocusApartment(product: widget.product,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        movetoFocusApartment(widget.product);
      },
      child:
    Card(
      color:const Color.fromARGB(255, 213, 208, 194),
      margin: EdgeInsets.all(8),
      child: Row(mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(widget.product.imageUrl[0],
          width: 225,
          height: 225,
          fit:BoxFit.cover
          ),
          Expanded(child:Padding(
            padding: EdgeInsets.all(7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
 
                if(widget.product.title.length > 15)
                  Text(
                  '${widget.product.title.substring(0,13)}...',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                    )
                  )

                else 
                  Text(
                  widget.product.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                  )
                  ), 

                SizedBox(height: 15),

                Text(
                  'Gender: ${widget.product.gender}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                  )
                ),

                SizedBox(height: 15),
                Text(
                  'Town: ${widget.product.town}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                  )
                ),

                SizedBox(height: 15),
                Text(
                  'Price: ${widget.product.price}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                  )
                ),

    

                SizedBox(height: 15),


                Row(children: [
                  Icon(Icons.thumb_up,color: Colors.red,),
                  Text(
                  ' ${widget.product.likes}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                  )
                ),
                ],)
              ],
            ),
            ),
            ),
        ], 
      ),
    )
    );
  }
}