import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePageApp extends StatefulWidget {
  const HomePageApp({super.key});

  @override
  State<HomePageApp> createState() => HomePageAppState();
}

class HomePageAppState extends State<HomePageApp> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Green Background Section
            Container(
              width: double.infinity,
              color: Color(0xFF4CAF50),
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                    return SearchBar(
                      controller: controller,
                      padding: const WidgetStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (_) {
                        controller.openView();
                      },
                      leading: const Icon(Icons.search, color: Colors.black), // Adjust icon color
                      backgroundColor: const WidgetStatePropertyAll<Color>(Colors.white),
                    );
                  },
                  suggestionsBuilder: (BuildContext context, SearchController controller) {
                    return List<ListTile>.generate(5, (int index) {
                      final String item = 'Item $index';
                      return ListTile(
                        title: Text(item),
                        onTap: () {
                          setState(() {
                            controller.closeView(item);
                          });
                        },
                      );
                    });
                  },
                ),
              ),
            ),

            // White Background Section (Main Content)
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Center(
                  child: const Text(
                    "Main Content Goes Here",
                    style: TextStyle(fontSize: 18),
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
