import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kawaii/constants.dart';
class OrderDetails extends StatefulWidget {
  List items;
  var data;
  OrderDetails({required this.items,this.data});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: LoginColor,),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            orderId_status_date(),
            Items(),
          ],
        ),
      )
    );
  }
  Padding orderId_status_date(){
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order №  ' + widget.data['orderId'],
                  style: LoginFontStyle.copyWith(fontSize: 20),
                ),
                Text(widget.data['date'], style: subFontStyle),
              ],
            ),
            Text(
              widget.data['status'],
              style: subFontStyle.copyWith(color:(widget.data['status']=='order placed')?Colors.orange:(widget.data['status']=='Shipped')?Colors.green:Colors.red,fontWeight: FontWeight.bold),
            )
          ],
        )
    );
  }
  Padding Items(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.items.length.toString()+" items",style: subFontStyle.copyWith(color: Colors.black),),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.6,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: widget.items.length,
              itemBuilder: (context,index){
                var data = widget.items[index];
                return Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: cardDecoration,
                  width: MediaQuery.of(context).size.width*0.85,
                  height: MediaQuery.of(context).size.height*0.2,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          data['ImageUrl'],
                          width: MediaQuery.of(context).size.width * 0.25,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data['Name'],
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      data['qty'],
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(data['price'],
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}


