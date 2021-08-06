import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kawaii/Components/Home%20Screen/HomeComponents.dart';
import 'package:kawaii/constants.dart';
class CategoryItems extends StatefulWidget {
  CategoryItems({required this.category});
  String category;
  @override
  _CategoryItemsState createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: kPurpleDark,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Items').where('Category',isEqualTo: widget.category).snapshots(),
        builder: (context,snapshot){
          var data = snapshot.data!.docs;
          if(data.length==0){
            return Text("No Items Present");
          }
          return GridView.count(
            childAspectRatio: MediaQuery.of(context).size.width * 0.4 / 200,
            crossAxisCount: 2,
            physics: BouncingScrollPhysics(),
            children: List.generate(data.length, (index) {
              if(data[index]['outOfStock'])
                return Container();
              return ItemCard(data: data[index],);
            }),
          );
        },
      ),
    );
  }
}
// FirebaseFirestore.instance.collection('Items')