import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        borderRadius: BorderRadius.circular(20),
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
                GestureDetector(
                  child: Icon(FontAwesomeIcons.trash,color: Colors.red,),
                  onTap: (){
                    FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection('favorites').doc(data.id).delete();
                  },
                ),
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
class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Image img;

  CustomDialogBox({required this.title, required this.descriptions, required this.text, required this.img});

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
              + Constants.padding, right: Constants.padding,bottom: Constants.padding
          ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              Text(widget.descriptions,style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
              SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(widget.text,style: TextStyle(fontSize: 18),)),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: widget.img,//Image.asset('assets/Images/touch.png'),
            ),
          ),
        ),
      ],
    );
  }
}