import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width*0.8,
      height: MediaQuery.of(context).size.height*0.15,
      decoration: BoxDecoration(
        color: kbackColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: MediaQuery.of(context).size.width*0.3,
              child: Center(child: Image.network(data['Image']))),
          Container(
              width:MediaQuery.of(context).size.width*0.3 ,
              child: Text(data['Name'],style: ksmallFontStylewithStyle.copyWith(color: LoginColor),softWrap: true,)),
          Container(
            width: MediaQuery.of(context).size.width*0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(FontAwesomeIcons.trash,color: Colors.red,),
                Text(data['Price'],style: ksmallFontStylewithStyle,),
                Icon(CupertinoIcons.right_chevron),
              ],
            ),
          )
        ],
      ),
    );
  }
}