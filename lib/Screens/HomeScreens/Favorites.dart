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
      color: Colors.white,
      // decoration: cardDecoration.copyWith(borderRadius: BorderRadius.circular(0)),
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
              return GestureDetector(
                onTap: (){
                  FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection('favorites').get().then((snapshot){
                    var data = snapshot.docs;
                    for(int i=0 ; i<data.length ; ++i){
                      FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection('cart').doc(data[i].id).set(
                        {
                          'pid':data[i]['pid'],
                          'Price':data[i]['Price'],
                          'Name':data[i]['Name'],
                          'qty':"1",
                          'Image':data[i]['Image']
                        }
                      );
                    }
                  });
                  showDialog(context: context, builder:(context){
                    return CustomDialogBox(title: 'Voila', descriptions: 'Items Added To Cart', text: 'Back', img: Image.asset('assets/Images/touch.png'));
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: ksubCard.copyWith(color: kPurpleLight),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add All To Cart",
                        style: ksmallFontStylewithStyle.copyWith(
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        CupertinoIcons.add,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}


