import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kawaii/Components/Home%20Screen/HomeComponents.dart';
import 'package:kawaii/constants.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Welcome",style: TextStyle(
              fontSize: 30,
              fontFamily: 'subFont'
            ),),
            BestSellerCard(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Popular Deals",style: ksmallFontStylewithStyle,),
                    Text("See all",style: TextStyle(color: Colors.grey),),
                  ],
                ),
                SizedBox(height: 10,),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Items').snapshots(),
                  builder: (context,snapshot){
                    var data = snapshot.data!.docs;
                    return SizedBox(
                      height: MediaQuery.of(context).size.height*0.35,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context,index){
                          return ItemCard(data: data[index],);
                        },
                      ),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}




