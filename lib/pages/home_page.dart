import 'package:firebase_auth/firebase_auth.dart';
import 'package:upr_housing/components/my_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:upr_housing/pages/posting_Apt.dart';
import 'package:upr_housing/components/product.dart';
import 'package:upr_housing/components/product_card.dart';
// import 'package:upr_housing/components/product_list.dart';
import 'package:upr_housing/model/apartments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:upr_housing/components/navBar.dart';

class HomePageApp extends StatefulWidget {
  const HomePageApp({super.key});

  @override
  State<HomePageApp> createState() => _HomePageAppState();
}

class _HomePageAppState extends State<HomePageApp> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void moveToPostingApt() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostingAptApp()),
    );
  }

  Future<List<Product>> fetchApartments() async {
    List<Product> p = [];
    Apartment apt = Apartment();
    QuerySnapshot querySnapshot = await apt.collection.get();

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      Product product = Product(
          // imageUrl: data['ImageUrl'] ??
          //     'https://w7.pngwing.com/pngs/575/378/png-transparent-easter-bunny-hare-cottontail-rabbit-domestic-rabbit-european-rabbit-rabbit-mammal-image-file-formats-animals-thumbnail.png', // Default image if none is provided
          imageUrl: data['ImageUrl'] is List
            ? List<String>.from(data['ImageUrl'])
            : (data['ImageUrl'] is String
                ? [data['ImageUrl']]
                : ['https://w7.pngwing.com/pngs/575/378/png-transparent-easter-bunny-hare-cottontail-rabbit-domestic-rabbit-european-rabbit-rabbit-mammal-image-file-formats-animals-thumbnail.png']),

          summary: data['Summary'] ?? 'No summary available',
          likes: data['Likes'],
          price: data['Price'],
          title: data['Title'] ?? 'Unknown',
          uID: data['uID'],
          gender: data['Gender'], 
          town: data['Town']
          )
          ;
      product.uID != FirebaseAuth.instance.currentUser!.uid? 
      p.add(product): '';
    }

    return p;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          child: MySearchBar(),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
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
