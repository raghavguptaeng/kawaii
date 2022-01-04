import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kawaii/Screens/Auth/Login.dart';
import 'package:kawaii/Screens/HomeScreens/HomeScreen.dart';
import 'package:kawaii/Screens/OpeningScreens/FirstOpeningScreen.dart';
import 'package:kawaii/Screens/Product/AllProducts.dart';
import 'package:kawaii/Screens/User/orders.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Init());
}
class Init extends StatelessWidget {
  const Init({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      initialRoute: FirstScreen.id,
      routes: {
        FirstScreen.id:(context)=>FirstScreen(),
        Login.id:(context)=>Login(),
        HomeScreen.id:(context)=>HomeScreen(),
        Orders.id:(context)=>Orders(),
        AllProducts.id:(context)=>AllProducts(),
      },
    );
  }
}
