import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore, QuerySnapshot;
import 'package:kawaii/constants.dart';
import 'orderDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Orders extends StatelessWidget {
  static String id = '/orders';
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Orders",
          style: LoginFontStyle.copyWith(color: Colors.black, fontSize: 25),
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.black,
            )),
      ),
      body: Column(
        children: [
          Text("Orders",style: LoginFontStyle,),
          SizedBox(height: 10,),
          Center(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('orders')
              .where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                var data = snapshot.data!.docs;
                if(data.length==0){
                  return Text("No Orders Yet");
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ListView.builder(
                    itemCount: data.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      List items = data[index]['items'];
                      return OrderCard(
                          id: data[index]['orderId'],
                          qty: items.length,
                          date: data[index]['date'],
                          items: items,
                          status: data[index]['status'],
                          total: data[index]['total'],
                        master: data[index],
                      );
                    },
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

class OrderCard extends StatelessWidget {
  var id, qty, date, items, status,total,master;
  OrderCard({this.id, this.qty, this.items, this.date, this.status,this.total,this.master});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: cardDecoration,
      padding: EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          orderId_and_date(context),
          Quantity_and_amount(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetails(items: items,data: master,)));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(
                    'Details',
                    style: subFontStyle.copyWith(color: Colors.black),
                  )),
                ),
              ),
              Text(
                status,
                style: subFontStyle.copyWith(color:(status=='order placed')?Colors.orange:(status=='Shipped')?Colors.green:Colors.red,fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }

  SizedBox orderId_and_date(var context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.95,
      child: Column(
       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order № ' + id,
            style: LoginFontStyle.copyWith(fontSize: 20),
          ),
          Text(date, style: subFontStyle)
        ],
      ),
    );
  }

  Column Quantity_and_amount() {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Quantity: ",
              style: subFontStyle,
            ),
            Text(
              qty.toString(),
              style: subFontStyle.copyWith(color: Colors.black),
            )
          ],
        ),
        Row(
          children: [
            Text(
              "Total Amount: ",
              style: subFontStyle,
            ),
            Text(
              "$total ₹",
              style: subFontStyle.copyWith(color: Colors.black),
            )
          ],
        ),
      ],
    );
  }
}
