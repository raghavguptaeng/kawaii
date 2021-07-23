import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> data;

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width*0.8,
      height: MediaQuery.of(context).size.height*0.15,
      decoration: BoxDecoration(
        color: kbackColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: MediaQuery.of(context).size.width*0.3,
              child: Center(child: Image.network(widget.data['Image']))),
          Container(
              width:MediaQuery.of(context).size.width*0.3 ,
              child: Text(widget.data['Name'],style: ksmallFontStylewithStyle.copyWith(color: LoginColor),softWrap: true,)),
          Container(
            width: MediaQuery.of(context).size.width*0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: Icon(Icons.cancel_outlined,color: Colors.grey,),
                  onTap: (){
                    FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection('cart').doc(widget.data.id).delete();
                  },
                ),
                Text(widget.data['Price'],style: ksmallFontStylewithStyle,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          int qty = (int.parse(widget.data['qty'])+1);
                          FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection('cart').doc(widget.data.id).update(
                              {
                                'qty':qty.toString(),
                              });
                        });
                      },
                      child: Container(
                        child: Icon(CupertinoIcons.add),
                      ),
                    ),
                    Text(widget.data['qty'].toString(),style: ksmallFontStylewithStyle,),
                    GestureDetector(
                      onTap: (){
                        if(int.parse(widget.data['qty'])>1){
                          setState(() {
                            int qty = (int.parse(widget.data['qty'])-1);
                            FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection('cart').doc(widget.data.id).update(
                            {
                            'qty':qty.toString(),
                            });
                          });
                        }
                      },
                      child: Container(
                        child: Icon(CupertinoIcons.minus),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}