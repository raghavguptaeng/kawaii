import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kawaii/constants.dart';
class ProductCard extends StatefulWidget {
  ProductCard({required this.id,this.img,required this.price,required this.name});
  var img;
  String name,price,id;
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(backgroundColor: ksecColor,),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ProdutImage(context),
                  DetailsSetion(context),
                  TopNavigation(context),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container TopNavigation(BuildContext context) {
    return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: ()=>Navigator.pop(context),
                              child: Icon(CupertinoIcons.back,size: 50,)),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection('favorites').where('pid',isEqualTo: widget.id).snapshots(),
                            builder: (context,snapshot){
                              if(snapshot.data!.docs.isEmpty){
                                return GestureDetector(
                                    onTap: (){
                                      FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection('favorites').doc(widget.id).set({
                                        'pid':widget.id,
                                        'Name':widget.name,
                                        'Image':widget.img,
                                        'Price':widget.price
                                      });
                                    },
                                    child: Icon(FontAwesomeIcons.heart));
                              }
                              return GestureDetector(
                                  onTap: (){
                                    FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection('favorites').doc(widget.id).delete();
                                  },
                                  child: Icon(FontAwesomeIcons.solidHeart,color: Colors.red,));
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
  }

  Container ProdutImage(BuildContext context) {
    return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.7,
                decoration: BoxDecoration(
                  color: Color(0xFFF1F4FB)
                  // gradient: LinearGradient(
                  //   colors: [kcolor1,kcolor2],
                  // ),
                ),
                child: Image.network(widget.img),
              );
  }

  Container DetailsSetion(BuildContext context) {
    return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Align(
                    alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft:  Radius.circular(50))
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.35,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.65,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: GestureDetector(
                                onTap: (){
                                  FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection('cart').doc().set(
                                    {
                                      'Image':widget.img,
                                      'Price':widget.price,
                                      'pid':widget.id,
                                      'qty':qty.toString(),
                                      'Name':widget.name
                                    }
                                  );
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 30),
                                  width: MediaQuery.of(context).size.width*0.8,
                                  height: MediaQuery.of(context).size.height*0.08,
                                  decoration: BoxDecoration(
                                    color: LoginColor,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(CupertinoIcons.bag,color: Colors.white,),
                                      Text("Add To Cart",style:ksmallFontStyle.copyWith(color: Colors.white
                                      ),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(height: 50,),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(widget.name,style: LoginFontStyle.copyWith(color: LoginColor),),
                                    Text(widget.price,style: LoginFontStyle,),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Container(
                                width:MediaQuery.of(context).size.width*0.25 ,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1
                                    )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          qty++;
                                        });
                                      },
                                      child: Container(
                                        child: Icon(CupertinoIcons.add),
                                      ),
                                    ),
                                    Text(qty.toString(),style: ksmallFontStylewithStyle,),
                                    GestureDetector(
                                      onTap: (){
                                        if(qty>1){
                                          setState(() {
                                            qty--;
                                          });
                                        }
                                      },
                                      child: Container(
                                        child: Icon(CupertinoIcons.minus),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
  }
}
