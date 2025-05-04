import 'package:flutter/material.dart';
import 'package:upr_housing/pages/chatPage.dart';
import 'package:upr_housing/pages/dummy_home.dart';
import 'package:upr_housing/pages/home_page.dart';
import 'package:upr_housing/pages/posting_Apt.dart';
import 'package:upr_housing/pages/user_page.dart';

class Navbar extends StatefulWidget {

  //final Function()? onTap;
  const Navbar({
    super.key,
    //required this.onTap
    
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int myIndex = 0;

  final states = [
    HomePageApp(),
    PostingAptApp(),
    chatPageApp(),
    UserPage(),
    HomePage()
  ];

  int returnIndex(){
    return myIndex;

  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold( 
      body: states[myIndex],
      bottomNavigationBar: myIndex!= 1 ? BottomNavigationBar(
      onTap: (index){
        setState(() {
          myIndex = index;
        });
      },
      currentIndex: myIndex,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            ),
            label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add,
            ),
            label: "Post",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat,
            ),
            label: "Chat"
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            ),
            label: "My Apt"
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            ),
            label: "User"
        ),
      ],
      
      ): null,
      );
  }
}