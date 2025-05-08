import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:upr_housing/components/my_searchbar.dart';
import 'package:upr_housing/components/product.dart';
import 'package:upr_housing/components/product_card.dart';
import 'package:upr_housing/components/username_title.dart';
import 'package:upr_housing/model/apartments.dart';
import 'package:upr_housing/model/users.dart';
import 'package:upr_housing/components/my_button.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<StatefulWidget> createState() => _UserPageAppState();
}

class _UserPageAppState extends State<UserPage> {
  Users user = Users();
  Future<List<Product>> fetchApartments() async {
    List<Product> p = [];
    Apartment apt = Apartment();
    QuerySnapshot querySnapshot = await apt.collection.get();

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      Product product = Product(
          //imageUrl: data['ImageUrl'] ?? 'https://w7.pngwing.com/pngs/575/378/png-transparent-easter-bunny-hare-cottontail-rabbit-domestic-rabbit-european-rabbit-rabbit-mammal-image-file-formats-animals-thumbnail.png', // Default image if none is provided
          imageUrl: data['ImageUrl'] is List
              ? data['ImageUrl'][0]
              : (data['ImageUrl'] ??
                  'https://w7.pngwing.com/pngs/575/378/png-transparent-easter-bunny-hare-cottontail-rabbit-domestic-rabbit-european-rabbit-rabbit-mammal-image-file-formats-animals-thumbnail.png'),
          summary: data['Summary'] ?? 'No summary available',
          likes: data['Likes'] ?? 0,
          price: data['Price'] ?? 0,
          title: data['Title'] ?? 'Benjamin',
          uID: data['uID'] ?? 0,
          gender: data['Gender'],
          town: data['Town']);
      product.uID == FirebaseAuth.instance.currentUser!.uid
          ? p.add(product)
          : '';
    }

    return p;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          
          child: Text(
            "Profile",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        automaticallyImplyLeading: false,
        toolbarHeight: 25,
      ),
      body: SafeArea(
        child: 
        Column(
          children: [
                        // Profile section with stats
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
            
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Profile icon and username
                  Column(
                    children: [
                      Icon(
                        Icons.account_circle_rounded,
                        size: 90,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(height: 4),
                      // UsernameTitle(
                      //   uid: FirebaseAuth.instance.currentUser!.uid,
                      //   user: Users(),
                      // ),
                    ],
                  ),

                  // Posts count
                  Column(
                    children: [
                        UsernameTitle(
                          uid: FirebaseAuth.instance.currentUser!.uid,
                          user: Users(),
                        ),
                      FutureBuilder<List<Product>>(
                        future: fetchApartments(),
                        builder: (context, snapshot) {
                          int postCount =
                              snapshot.hasData ? snapshot.data!.length : 0;
                          return Text(
                            '$postCount',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          );
                        },
                      ),
                      const Text('Posts',
                        style:TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                      ),
                    ],
                    
                  ),

                  Column(
                    children: [
                      SizedBox(height: 25,),
                      const Text('0',
                        style:TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                      ),
                      const Text('Saved',
                        style:TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),)
                    ],
                  )

                  // Saves count
                  // Column(
                  //   children: [
                  //     FutureBuilder<int>(
                  //       future: fetchSavedCount(),
                  //       builder: (context, snapshot) {
                  //         int saveCount = snapshot.hasData ? snapshot.data! : 0;
                  //         return Text(
                  //           '$saveCount',
                  //           style: const TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 18,
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //     const Text('Saves'),
                  //   ],
                  // ),
                ],
              ),
            ),

            SizedBox(height: 10,),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: MyButton(
                  onTap: () {},
                  text: 'Edit Profile'
                  ),
                ),

                SizedBox(
                  width: 200,
                  child: MyButton(
                  onTap: () {},
                  text: 'Log Out'
                  ),
                )
              ]
              ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     SizedBox(width: 20),
            //     Center(
            //       child: 

                  
                  
                  
            //       Column(
            //         children: [
            //           IconButton(
            //             onPressed: () {},
            //             icon: Icon(Icons.edit),
            //             iconSize: 35,
            //           ),
            //           Text(
            //             'Edit Profile',
            //             style: const TextStyle(
            //               fontSize: 18,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     SizedBox(
            //       width: 20,
            //     ),
            //     Column(
            //       children: [
            //         IconButton(
            //           onPressed: () {},
            //           icon: Icon(Icons.logout),
            //           iconSize: 35,
            //         ),
            //         Text(
            //           'Log out',
            //           style: const TextStyle(
            //             fontSize: 18,
            //           ),
            //         ),
            //       ],
            //     ),
            //     SizedBox(
            //       width: 15,
            //     ),
            //     // if (product.uID !=
            //     //     FirebaseAuth.instance.currentUser!.uid)
            //     //   Column(
            //     //     children: [
            //     //       IconButton(
            //     //         onPressed: () => talkWithOwner(
            //     //             context, product.uID, "Home Owner"),
            //     //         icon: Icon(Icons.chat),
            //     //         iconSize: 35,
            //     //       ),
            //     //       Text(
            //     //         'Message',
            //     //         style: const TextStyle(fontSize: 18),
            //     //       ),
            //     //     ],
            //     //   ),
            //   ],
            // ),
            Divider(
              color: Colors.grey, // Line color
              thickness: 2, // Line thickness
              // indent: 16, // Left padding
              // endIndent: 16, // Right padding
            ),
            Expanded(
              child: FutureBuilder<List<Product>>(
                future:
                    fetchApartments(), // ✅ Use FutureBuilder to handle async data
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Show loading spinner
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No apartments available'));
                  }

                  List<Product> products = snapshot.data!;

                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 225,
                        child: ProductCardApp(product: products[index]),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      //bottomNavigationBar: Navbar(),
    );
  }
}
