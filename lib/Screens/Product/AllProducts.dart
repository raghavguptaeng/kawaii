import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kawaii/Components/Home%20Screen/HomeComponents.dart';
import 'package:kawaii/constants.dart';
class AllProducts extends StatelessWidget {
  static String id = '/All Products';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPurpleDark,
        title: Text("All Products"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Items').where('outOfStock',isNotEqualTo: true).snapshots(),
        builder: (context,snapshot){
          var data = snapshot.data!.docs;
          return GridView.count(
            childAspectRatio: MediaQuery.of(context).size.width * 0.4 / 200,
            crossAxisCount: 2,
            physics: BouncingScrollPhysics(),
            children: List.generate(data.length, (index) {
              return ItemCard(data: data[index],);
            }),
          );
        },
      ),
    );
  }
}
