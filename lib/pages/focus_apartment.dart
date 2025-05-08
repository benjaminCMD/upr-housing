// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
// import 'package:upr_housing/components/navBar.dart';
import 'package:upr_housing/components/product.dart';
import 'package:upr_housing/model/users.dart';
// import 'package:upr_housing/pages/home_page.dart';
import 'package:upr_housing/components/my_button.dart';
import 'package:upr_housing/pages/userChatPage.dart';
import 'package:upr_housing/components/richtext.dart';

class FocusApartment extends StatelessWidget {
  // final Product product;
  final Product product;
  // final Users user = Users();
  const FocusApartment({super.key, required this.product});

  void talkWithOwner(BuildContext context, uid, email) {
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
        toolbarHeight: 35,
        title: SizedBox(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Navbar()));
            },
            child: Icon(
              Icons.arrow_back,
              size: 30,
            ),
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
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Scaffold(
                                backgroundColor: Colors.black,
                                appBar:
                                    AppBar(backgroundColor: Colors.transparent),
                                body: Center(
                                  child: PhotoView(
                                    imageProvider:
                                        NetworkImage(product.imageUrl[index]),
                                    backgroundDecoration: const BoxDecoration(
                                        color: Colors.black),
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
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 20),
                        Center(
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.bookmark_add_outlined),
                                iconSize: 35,
                              ),
                              Text(
                                'Bookmark',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.share),
                              iconSize: 35,
                            ),
                            Text(
                              'Share',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        if (product.uID !=
                            FirebaseAuth.instance.currentUser!.uid)
                          Column(
                            children: [
                              IconButton(
                                onPressed: () => talkWithOwner(
                                    context, product.uID, "Home Owner"),
                                icon: Icon(Icons.chat),
                                iconSize: 35,
                              ),
                              Text(
                                'Message',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    LabelledText(
                        boldedWord: 'Description: \n',
                        regularWord: product.summary,
                        wordSize: 25),

                    const SizedBox(height: 20),
                    LabelledText(
                        boldedWord: 'Town: ',
                        regularWord: product.town,
                        wordSize: 25),

                    const SizedBox(height: 20),
                    LabelledText(
                        boldedWord: 'Gender: ',
                        regularWord: product.gender,
                        wordSize: 25),

                    // const SizedBox(height: 15),
                    // LabelledText(boldedWord: 'Neighborhood: ', regularWord: product.),

                    const SizedBox(height: 20),
                    LabelledText(
                        boldedWord: 'Price: ',
                        regularWord: product.price,
                        wordSize: 25),

                    const SizedBox(height: 20),
                    LabelledText(
                        boldedWord: 'Likes: ',
                        regularWord: '${product.likes}',
                        wordSize: 25),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
