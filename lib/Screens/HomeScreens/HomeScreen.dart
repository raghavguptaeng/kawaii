import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kawaii/Screens/HomeScreens/Favorites.dart';
import 'package:kawaii/Screens/HomeScreens/Home.dart';
import 'package:kawaii/Screens/HomeScreens/Profile.dart';
import 'package:kawaii/constants.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'Cart.dart';

class HomeScreen extends StatefulWidget {
  static String id = '/homeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            IndexedStack(
              index: _currentIndex,
              children: [
                Home(),
                Cart(),
                Favorites(),
                Profile()
              ],
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: SalomonBottomBar(
            //     currentIndex: _currentIndex,
            //     onTap: (i) => setState(() => _currentIndex = i),
            //     items: [
            //       /// Home
            //       SalomonBottomBarItem(
            //         icon: Icon(Icons.home),
            //         title: Text("Home"),
            //         selectedColor: Colors.purple,
            //       ),
            //
            //       /// Likes
            //       SalomonBottomBarItem(
            //         icon: Icon(Icons.favorite_border),
            //         title: Text("Likes"),
            //         selectedColor: Colors.pink,
            //       ),
            //
            //       /// Search
            //       SalomonBottomBarItem(
            //         icon: Icon(Icons.search),
            //         title: Text("Search"),
            //         selectedColor: Colors.orange,
            //       ),
            //
            //       /// Profile
            //       SalomonBottomBarItem(
            //         icon: Icon(Icons.person),
            //         title: Text("Profile"),
            //         selectedColor: Colors.teal,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.purple,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text("Likes"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
            selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}

// ],
