import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kawaii/Components/Home%20Screen/FavoriteComponents.dart';
import 'package:kawaii/constants.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: cardDecoration.copyWith(borderRadius: BorderRadius.circular(0)),
      child:Column(
        children: [
          Text('Favorites',style: LoginFontStyle,),
          StreamBuilder<QuerySnapshot>(
            stream:FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection('favorites').snapshots(),
            builder: (context,snapshot){
              var data = snapshot.data!.docs;
              if(data.length==0){
                isEmpty = true;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.2,
                    ),
                    Image.asset('assets/Images/touch.png',height:MediaQuery.of(context).size.height*0.2 ,),
                    Container(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Text("Touch our heart by adding those items to your cart !",style: ksmallFontStyle,))
                  ],
                );
              }
              isEmpty = false;
              return SizedBox(
                height: MediaQuery.of(context).size.height*0.7,
                child: ListView.builder(
                  itemCount: data.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index){
                    return FavoriteCard(data: data[index]);
                  },
                ),
              );
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream:FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection('favorites').snapshots(),
            builder: (context,snapshot){
              var data = snapshot.data!.docs;
              if(data.length==0){
                return Container();
              }
              isEmpty = false;
              return Container(
                decoration: ksubCard,
                width: MediaQuery.of(context).size.width*0.8,
                height: MediaQuery.of(context).size.height*0.1,
                child: Center(child: Text("ADD ALL TO CART",style: LoginFontStyle.copyWith(color: Colors.white),)),
              );
            },
          )
        ],
      ),
    );
  }
}


