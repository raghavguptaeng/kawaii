
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class unFilledOrderCard extends StatelessWidget {
  const unFilledOrderCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height*0.2 ,
      width: MediaQuery.of(context).size.width*0.2,
      decoration: kBoxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height:MediaQuery.of(context).size.height*0.2 ,
            width: MediaQuery.of(context).size.width*0.1,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('orders').where('status',isEqualTo: 'order placed').snapshots(),
                  builder: (context,snapshot){
                    var data = snapshot.data!.docs;
                    int num = 0;
                    for(int i=0 ; i<data.length ; ++i){
                      num++;
                    }
                    return Text(num.toString(),style: kBigText,);
                  },
                ),
                Text("Unfullfilled Orders",style: TextStyle(
                    color: Colors.grey
                ),)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            height:MediaQuery.of(context).size.height*0.1 ,
            width: MediaQuery.of(context).size.width*0.05,
            decoration: BoxDecoration(
              color: Color(0xFFFFF5D9),
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Icon(FontAwesomeIcons.shoppingBag,color: Color(0xFFFFBB38),),
          ),
        ],
      ),
    );
  }
}
class onShipping extends StatelessWidget {
  const onShipping({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height*0.2 ,
      width: MediaQuery.of(context).size.width*0.2,
      decoration: kBoxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height:MediaQuery.of(context).size.height*0.2 ,
            width: MediaQuery.of(context).size.width*0.1,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('orders').where('status',isEqualTo: 'Shipped').snapshots(),
                  builder: (context,snapshot){
                    var data = snapshot.data!.docs;
                    int num = 0;
                    for(int i=0 ; i<data.length ; ++i){
                      num++;
                    }
                    return Text(num.toString(),style: kBigText,);
                  },
                ),
                Text("Orders In Shipping",style: TextStyle(
                    color: Colors.grey
                ),)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            height:MediaQuery.of(context).size.height*0.1 ,
            width: MediaQuery.of(context).size.width*0.05,
            decoration: BoxDecoration(
              color: Color(0xFFE7EDFF),
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Icon(FontAwesomeIcons.truck,color: Color(0xFF396AFF),),
          ),
        ],
      ),
    );
  }
}
class completedOrders extends StatelessWidget {
  const completedOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height*0.2 ,
      width: MediaQuery.of(context).size.width*0.2,
      decoration: kBoxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height:MediaQuery.of(context).size.height*0.2 ,
            width: MediaQuery.of(context).size.width*0.1,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('orders').where('status',isEqualTo: 'completed').snapshots(),
                  builder: (context,snapshot){
                    var data = snapshot.data!.docs;
                    int num = 0;
                    for(int i=0 ; i<data.length ; ++i){
                      num++;
                    }
                    return Text(num.toString(),style: kBigText,);
                  },
                ),
                Text("Orders completed",style: TextStyle(
                    color: Colors.grey
                ),)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            height:MediaQuery.of(context).size.height*0.1 ,
            width: MediaQuery.of(context).size.width*0.05,
            decoration: BoxDecoration(
              color: Color(0xFFDCFAF8),
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Icon(FontAwesomeIcons.solidThumbsUp,color: Color(0xFF16DBCC),),
          ),
        ],
      ),
    );
  }
}