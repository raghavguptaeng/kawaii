import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kawaii/admin_panel/subScreens/AddPromoCode.dart';

import '../../constants.dart';

class Promo extends StatelessWidget {
  const Promo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height ,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('PromoCodes').snapshots(),
            builder: (context,snapshot){
              if(snapshot.data!.docs.length==0)
                return Text("NO Promocodes found");
              var data = snapshot.data!.docs;
              return SizedBox(
                height:MediaQuery.of(context).size.height * 0.6 ,
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length ,
                    itemBuilder: (context,index){
                      return PromoCard(
                          name: data[index]['name'],
                          validity: data[index]['validity'],
                          discount: data[index]['discount'],
                          minAmount: data[index]['minimumAmount'],
                          code: data[index]['code'],
                          pcode:data[index].id
                      );
                    }
                ),
              );
            },
          ),
          Align(
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddPromo.id);
              },
              child: Icon(FontAwesomeIcons.plus),
            ),
            alignment: Alignment.bottomRight,
          )
        ],
      ),
    );
  }
}

class PromoCard extends StatelessWidget {
  PromoCard({required this.discount,required this.code,required this.name,required this.minAmount,required this.validity, required this.pcode});
  final String name,code,discount,validity,minAmount,pcode;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: kBoxDecoration,
      width: MediaQuery.of(context).size.width*0.4,
      height: MediaQuery.of(context).size.height*0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Promo name: "+name),
              Text("Code: "+code)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("total Discount: "+discount+" %"),
              Text("Minimum Amount: "+minAmount)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: (){
                  FirebaseFirestore.instance.collection('PromoCodes').doc(pcode).delete();
                },
                child: Icon(FontAwesomeIcons.trash,color: Colors.red,),
              ),
              Text("Valid Till: "+validity)
            ],
          )
        ],
      ),
    );
  }
}
