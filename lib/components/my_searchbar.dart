import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => SearchBarState();
}

class SearchBarState extends State<MySearchBar> {
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: SearchAnchor.bar(
        barBackgroundColor: WidgetStateProperty.all(Colors.white),
        isFullScreen: false,
        viewBackgroundColor: Colors.white,
        barShape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          )
        ),
        viewConstraints: BoxConstraints(maxHeight: 300.0, maxWidth: double.infinity),
        dividerColor: Colors.black,
        barHintText: "Search",
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
    );
  }
}


// class MySearchBar extends StatefulWidget {
//   const MySearchBar({super.key});

//   @override
//   State<MySearchBar> createState() => SearchBarState();
// }

// class SearchBarState extends State<MySearchBar> {
  
//   @override
//   Widget build(BuildContext context) {
//     // final SearchController controller = SearchController();
//     return Container(
//               width: double.infinity,
//               color: Color(0xFF4CAF50),
//               padding: const EdgeInsets.symmetric(vertical: 10.0),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: SearchAnchor.bar(
//                   barBackgroundColor: WidgetStateProperty.all(Colors.white),
//                   // shrinkWrap: false,
//                   // barElevation: WidgetStateProperty.all(6.0),
//                   isFullScreen: false,
//                   viewBackgroundColor: Colors.white,
//                   viewShape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0)
//                   ),
//                   barShape: WidgetStatePropertyAll(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0)
//                       )
//                     ),
//                   // viewHeaderHeight: 100,
//                   // viewElevation: 100.0,
//                   viewConstraints: BoxConstraints(maxHeight: 300.0),

//                   dividerColor: Colors.black,

//                   suggestionsBuilder: (BuildContext context, SearchController controller) {

//                     final List<String> towns = ['Mayaguez', 'Arecibo', 'Ponce', 'San Juan', 'Cayey'];
//                     return towns.map((String town) {
//                       return ListTile(
//                         title: Text(town),
//                         onTap: () {
//                           setState(() {
//                             controller.closeView(town);
//                             });
//                         },
//                       );
//                       }).toList();
//                   },
//                 ),
//               ),
//             );
//   }
// }