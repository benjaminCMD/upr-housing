// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
// import 'package:upr_housing/components/navBar.dart';
import 'package:upr_housing/components/product.dart';
// import 'package:upr_housing/model/users.dart';
// import 'package:upr_housing/pages/home_page.dart';
import 'package:upr_housing/components/my_button.dart';
import 'package:upr_housing/pages/userChatPage.dart';
import 'package:upr_housing/components/richtext.dart';

class FocusApartment extends StatelessWidget {
  // final Product product;
  final Product product;
  const FocusApartment({super.key, required this.product});

  void talkWithOwner(BuildContext context, uid, email){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => userChatPageApp(
          receiverUserEmail: email,
          receiverUserID: uid,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 224, 222, 214),
        appBar: AppBar(
          toolbarHeight: 30,
          title: SizedBox(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                //Navigator.push(context, MaterialPageRoute(builder: (context) => Navbar()));
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          backgroundColor: const Color(0xFF4CAF50),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image.network(product.imageUrl[0]),
        SizedBox(
          height: 375,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: product.imageUrl.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Scaffold(
                          backgroundColor: Colors.black,
                          appBar: AppBar(backgroundColor: Colors.transparent),
                          body: Center(
                            child: PhotoView(
                              imageProvider: NetworkImage(product.imageUrl[index]),
                              backgroundDecoration: const BoxDecoration(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product.imageUrl[index],
                      width: MediaQuery.of(context).size.width * 0.8,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                              );
                            },
                          ),
                        ),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 15),
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                  ),
              ),

              const SizedBox(height: 20),
              LabelledText(boldedWord: 'Description: \n', regularWord: product.summary, wordSize: 25),

              const SizedBox(height: 20),
              LabelledText(boldedWord: 'Town: ', regularWord: product.town, wordSize: 25),

              const SizedBox(height: 20),
              LabelledText(boldedWord: 'Gender: ', regularWord: product.gender, wordSize: 25),

              // const SizedBox(height: 15),
              // LabelledText(boldedWord: 'Neighborhood: ', regularWord: product.),
              
          
              const SizedBox(height: 20),
              LabelledText(boldedWord: 'Price: ', regularWord: product.price, wordSize: 25),

              const SizedBox(height: 20),
              LabelledText(boldedWord: 'Likes: ', regularWord: '${product.likes}', wordSize: 25),


              const SizedBox(height: 30),
              product.uID != FirebaseAuth.instance.currentUser!.uid
                  ? MyButton(
                      text: 'Chat with owner',
                      onTap: () => talkWithOwner(context, product.uID, "Home Owner"),
                    )
                  : const SizedBox(height: 15),
            ],
          ),
        ),
      ],
    ),
  ),
),
  //       body: SafeArea(
  // child: SingleChildScrollView(
  //   child: Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Image.network(product.imageUrl),
  //         const SizedBox(height: 15),
  //         Text(
  //           product.title,
  //           style: const TextStyle(fontSize: 30),
  //         ),
  //         const SizedBox(height: 15),
  //         Text(
  //           "Description: ${product.summary}",
  //           style: const TextStyle(fontSize: 25),
  //         ),
  //         const SizedBox(height: 15),
  //         Text(
  //           "Price: ${product.price}",
  //           style: const TextStyle(fontSize: 25),
  //         ),
  //         const SizedBox(height: 10),
  //         Text(
  //           "Likes: ${product.likes}",
  //           style: const TextStyle(fontSize: 25),
  //         ),
  //         const SizedBox(height: 20),
  //         product.uID != FirebaseAuth.instance.currentUser!.uid
  //             ? MyButton(
  //                 text: 'Chat with owner',
  //                 onTap: () => talkWithOwner(context, product.uID, "Home Owner"),
  //               )
  //             : const SizedBox(height: 15),
  //       ],
  //     ),
  //   ),
  // ),
// ),
        // body: SafeArea(
        //   child:
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
     
        //       Image.network(product.imageUrl),
        //       // SizedBox(
        //       //   height: 15,
        //       // ),
        //       Container(
        //         decoration: BoxDecoration(),
        //         // margin: const EdgeInsets.all(25),
        //         child: Text(
        //           "${product.title}",
        //           style: TextStyle(
        //             fontSize: 30
        //             ),
        //         ),
        //       ),
        //       // SizedBox(
        //       //   height: 15,
        //       // ),
        //       Expanded(
        //         child: SingleChildScrollView(
        //           child: Container(
        //             decoration: BoxDecoration(),
        //             // margin: const EdgeInsets.all(15),
        //             child: Text(
        //               "Description: ${product.summary}",
        //               style: TextStyle(fontSize: 25),
        //             ),
        //           ),
        //         ),
        //       ),
        //       // SizedBox(
        //       //   height: 10,
        //       // ),
        //       Container(
        //         decoration: BoxDecoration(),
        //         // margin: const EdgeInsets.all(2),
        //         child: Text(
        //           "Price: ${product.price}",
        //           style: TextStyle(fontSize: 25),
        //         ),
        //       ),
        //       // SizedBox(
        //       //   height: 5,
        //       // ),
        //       Container(
        //         decoration: BoxDecoration(),
        //         child: Text(
        //           "Likes: ${product.likes}",
        //           style: TextStyle(fontSize: 25),
        //         ),
        //       ),
        //       product.uID != FirebaseAuth.instance.currentUser!.uid ? MyButton(
        //         text: 'Chat with owner',
        //         onTap: () => talkWithOwner(context, product.uID, "Home Owner")
               
        //         ) 
        //         : SizedBox(
        //               height: 15,
        //             )
        //     ],
        //   ),
        // ));
    );
  }
}
