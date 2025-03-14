import 'package:firebase_auth/firebase_auth.dart';
import 'package:upr_housing/components/my_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:upr_housing/components/product.dart';
import 'package:upr_housing/components/product_cart.dart';
import 'package:upr_housing/components/product_list.dart';

class HomePageApp extends StatefulWidget {
  const HomePageApp({super.key});

  @override
  State<HomePageApp> createState() => HomePageAppState();
}

class HomePageAppState extends State<HomePageApp> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  List<Product> products = p;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MySearchBar(),

            // White Background Section (Main Content)
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Center(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return SizedBox(
                        height: 225,
                        child: ProductCardApp(product: product),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
