import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kawaii/admin_panel/HomeScreens/products.dart';

import '../../constants.dart';
class SpecialItems extends StatefulWidget {
  const SpecialItems({Key? key}) : super(key: key);
  static String id = '/SpecialItems';
  @override
  _SpecialItemsState createState() => _SpecialItemsState();
}

class _SpecialItemsState extends State<SpecialItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
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
                  // return Container(
                  //   child: Text(data[index]['Name'],style: kBigText,),
                  // );
                  return SpecialCard(
                    name: data[index]['Name'],
                    category: data[index]['Category'],
                    priceAfter: data[index]['Price'],
                    priceBefore: data[index]['PriceBefore'],
                    discount: data[index]['TotalDiscount'],
                    img: data[index]['ImageUrl'],
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
    );
  }
}
