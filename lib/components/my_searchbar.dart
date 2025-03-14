import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => SearchBarState();
}

class SearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
              width: double.infinity,
              color: Color(0xFF4CAF50),
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                    return SearchBar(
                      controller: controller,
                      padding: const WidgetStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 15.0),
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

                    final List<String> towns = ['Mayaguez', 'Arecibo', 'Ponce', 'San Juan', 'Cayey'];
                    return towns.map((String town) {
                      return ListTile(
                        title: Text(town),
                        onTap: () {
                          setState(() {
                            controller.closeView(town);
                            });
                        },
                      );
                      }).toList();
                  },
                ),
              ),
            );
  }
}