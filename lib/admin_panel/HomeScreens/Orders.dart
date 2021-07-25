import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';
class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.8,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context,snapshot){
          var data = snapshot.data!.docs;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context,index){
              return OrderCard(data: data[index],);
            },
          );
        },
      ),
    );
  }
}
class OrderCard extends StatelessWidget {
  OrderCard({this.data});
  var data;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height*0.2,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: kBoxDecoration.copyWith(color: (data['status']=='order placed')?Colors.green:(data['status']=='Shipped')?Colors.orange:Colors.blueAccent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Order Id: '+data['orderId']),
              Text('Amount: '+data['total'],),
              Text("show Items")
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Address: '+data['address']),
              Text('User Id: '+data['uid'],),
              Text("Date: "+data['date'].toString())
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Visibility(
                visible: (data['status']=='completed')?true:false,
                child: GestureDetector(
                    child: Icon(FontAwesomeIcons.trash,color: Colors.red,),
                  onTap: (){
                    FirebaseFirestore.instance.collection('orders').doc(data.id).delete();
                  },
                ),
              ),
              Text('Phone Number: '+data['phone']),
              Text('Status: '+data['status']),
              GestureDetector(
                onTap: (){
                  if(data['status']=='Shipped')
                    FirebaseFirestore.instance.collection('orders').doc(data.id).update({
                      'status':'completed'
                    });
                  else
                    FirebaseFirestore.instance.collection('orders').doc(data.id).update({
                      'status':'Shipped'
                    });
                },
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: kBoxDecoration.copyWith(color: (data['status']=='order placed')?Colors.orange:(data['status']=='completed')?Colors.blueAccent:Colors.green),
                  child: Center(child: (data['status']=='order placed')?Text("Send for shipping"):(data['status']=='Shipped')?Text("Mark As Complete"):Container()),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
