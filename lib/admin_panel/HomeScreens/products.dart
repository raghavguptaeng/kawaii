import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kawaii/admin_panel/subScreens/AddItems.dart';

import '../../constants.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height ,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Items').snapshots(),
            builder: (context,snapshot){
              if(snapshot.data!.docs.length==0)
                return Text("NO Items found");
              var data = snapshot.data!.docs;
              return SizedBox(
                height:MediaQuery.of(context).size.height * 0.9 ,
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length ,
                    itemBuilder: (context,index){
                      return PromoCard(
                          name: data[index]['Name'],
                          category: data[index]['Category'],
                          priceAfter: data[index]['Price'],
                          priceBefore: data[index]['PriceBefore'],
                          discount: data[index]['TotalDiscount'],
                          pcode:data[index].id,
                        onDiscount: data[index]['onDiscount'],
                        isPopular: data[index]['isPopular'],
                        isOutOfStock: data[index]['outOfStock'],
                      );
                    }
                ),
              );
            },
          ),
          Align(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddItems.id);
                },
                child: Icon(FontAwesomeIcons.plus),
              ),
            ),
            alignment: Alignment.bottomRight,
          )
        ],
      ),
    );
  }
}

class PromoCard extends StatelessWidget {
  PromoCard({required this.isPopular,required this.isOutOfStock,required this.discount,required this.name, required this.pcode,required this.onDiscount, required this.category, required this.priceAfter, required this.priceBefore});
  final String name,category,discount,priceAfter,priceBefore,pcode;
  bool onDiscount;
  bool isPopular;
  bool isOutOfStock ;
  @override
  Widget build(BuildContext context) {
    if(onDiscount == true) {
      return Container(
        margin: EdgeInsets.all(20),
        decoration: kBoxDecoration.copyWith(
          color: (isOutOfStock)?Colors.red:Colors.white,
        ),
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text("Name: " + name), Text("Category: " + category)],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("total Discount: " + discount + " %"),
                Text("Amount: " + priceAfter)
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text("Make Popular"),
                    CupertinoSwitch(value: isPopular, onChanged: (value){
                      FirebaseFirestore.instance
                          .collection('Items')
                          .doc(pcode).update({
                        'isPopular':value,
                      })  ;
                    }),
                  ],
                ),
                Row(
                  children: [
                    Text("Out Of Stock"),
                    CupertinoSwitch(value: isOutOfStock, onChanged: (value){
                      FirebaseFirestore.instance
                          .collection('Items')
                          .doc(pcode).update({
                        'outOfStock':value,
                      })  ;
                    }),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('Items')
                        .doc(pcode)
                        .delete();
                  },
                  child: Icon(
                    FontAwesomeIcons.trash,
                    color: (isOutOfStock)?Colors.black:Colors.red,
                  ),
                ),
                Text("Price Before Discount: " + priceBefore)
              ],
            )
          ],
        ),
      );
    }
    else{
      return Container(
        margin: EdgeInsets.all(20),
        decoration: kBoxDecoration.copyWith(
          color: (isOutOfStock)?Colors.red:Colors.white,
        ),
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text("Name: " + name), Text("Category: " + category)],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Amount: " + priceAfter),
                RaisedButton(onPressed: (){

                },
                child: Text("Add Discount"),
                    color: Colors.blue,
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text("Make Popular"),
                    CupertinoSwitch(value: isPopular, onChanged: (value){
                      FirebaseFirestore.instance
                          .collection('Items')
                          .doc(pcode).update({
                        'isPopular':value,
                      })  ;
                    }),
                  ],
                ),
                Row(
                  children: [
                    Text("Out Of Stock"),
                    CupertinoSwitch(value: isOutOfStock, onChanged: (value){
                      FirebaseFirestore.instance
                          .collection('Items')
                          .doc(pcode).update({
                        'outOfStock':value,
                      })  ;
                    }),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('Items')
                        .doc(pcode)
                        .delete();
                  },
                  child: Icon(
                    FontAwesomeIcons.trash,
                    color: (isOutOfStock)?Colors.black:Colors.red,
                  ),
                ),
                // Text("Price Before Discount: " + priceBefore)
              ],
            )
          ],
        ),
      );
    }
  }
}
