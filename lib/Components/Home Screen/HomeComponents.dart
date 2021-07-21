import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kawaii/constants.dart';

class BestSellerCard extends StatelessWidget {
  const BestSellerCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: cardDecoration.copyWith(
          gradient: LinearGradient(colors: [kcolor1, kcolor2]),
        ),
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width * 0.95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Best Seller",
                        style: TextStyle(
                            color: ksecColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Text(
                    "Ethnic Women Pins",
                    style: ksmallFontStyle,
                  ),
                  Text(
                    "200 \$",
                    style: ksmallFontStyle,
                  )
                ],
              ),
            ),
            Image.network(
                'https://firebasestorage.googleapis.com/v0/b/kawaii-510c4.appspot.com/o/2-removebg-preview.png?alt=media&token=a9c16524-d131-4437-bbbd-44a3ef4a9d0c')
          ],
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  var data;
  ItemCard({this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: cardDecoration,
      width: MediaQuery.of(context).size.width * 0.4,
      margin: EdgeInsets.only(right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
                color: kbackColor,
              borderRadius: BorderRadius.circular(30)
            ),
            child: Stack(
              children: [
                Center(
                  child: Image.network(
                    data['ImageUrl'],
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection('favorites').where('pid',isEqualTo: data.id).snapshots(),
                      builder: (context,snapshot){
                        if(snapshot.data!.docs.isEmpty){
                          return GestureDetector(
                              onTap: (){
                                FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection('favorites').doc(data.id).set({
                                  'pid':data.id.toString(),
                                  'Name':data['Name'],
                                  'Image':data['ImageUrl'],
                                  'Price':data['Price']
                                });
                              },
                              child: Icon(FontAwesomeIcons.heart));
                        }
                        return GestureDetector(
                            onTap: (){
                              FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection('favorites').doc(data.id).delete();
                            },
                            child: Icon(FontAwesomeIcons.solidHeart,color: Colors.red,));
                      },
                    ),
                  ),
                )
              ],
            )
          ),
          Text(
            data['Name'],
            style: ksmallFontStylewithStyle,
          ),
          Text(
            data['Price'],
            style: ksmallFontStylewithStyle.copyWith(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
