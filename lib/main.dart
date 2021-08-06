import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kawaii/admin_panel/subScreens/SpecialItemScreen.dart';

import 'admin_panel/homeScreen.dart';
import 'admin_panel/login_admin.dart';
import 'admin_panel/subScreens/AddItems.dart';
import 'admin_panel/subScreens/AddPromoCode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                //fontFamily: kFontFamily,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                backgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  color: Colors.white,
                  elevation: 0,
                ),
                scrollbarTheme: ScrollbarThemeData().copyWith(
                  isAlwaysShown: true,
                  thumbColor: MaterialStateProperty.all(Colors.grey[500]),
                ),
                //highlightColor: Colors.red,
              ),
              initialRoute: HomeScreen.id,//(FirebaseAuth.instance.currentUser==null)?LoginAdmin.id:HomeScreen.id,
              routes: {
                LoginAdmin.id :(context)=>LoginAdmin(),
                HomeScreen.id :(context)=>HomeScreen(),
                AddPromo.id : (context)=>AddPromo(),
                AddItems.id : (context)=>AddItems(),
                SpecialItems.id : (context)=>SpecialItems(),
              },
            );
          },
        );
      },
    );
  }
}
