import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kawaii/Components/Home%20Screen/FavoriteComponents.dart';
import 'package:kawaii/constants.dart';
class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: cardDecoration.copyWith(borderRadius: BorderRadius.circular(0)),
        child: StreamBuilder<QuerySnapshot>(
          stream:FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection('favorites').snapshots(),
          builder: (context,snapshot){
            var data = snapshot.data!.docs;
            if(data.length==0){
              return Text("Empty");
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height*0.7,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context,index){
                  return FavoriteCard(data: data[index]);
                },
              ),
            );
          },
        ),

    );
  }
}


