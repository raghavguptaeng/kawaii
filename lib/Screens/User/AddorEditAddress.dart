import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kawaii/constants.dart';

class Address extends StatelessWidget {
  bool add;
  Address({required this.add});
  String name = 'Raghav Gupta';
  String address =
      'pkt - B8, plot number 75/76 , first Floor , sector - 11 , rohini , Delhi';
  String city = 'Delhi';
  String state = 'Delhi';
  String zip = "110085";
  String number = '9582079619';
  @override
  Widget build(BuildContext context) {
    if (add) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Shipping Addresses",
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
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Container(
                    decoration: cardDecoration.copyWith(
                        borderRadius: BorderRadius.zero),
                    padding: const EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: InputDecoration(labelText: "full name"),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    decoration: cardDecoration.copyWith(
                        borderRadius: BorderRadius.zero),
                    padding: const EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        number = value;
                      },
                      decoration: InputDecoration(labelText: "Phone Number"),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    decoration: cardDecoration.copyWith(
                        borderRadius: BorderRadius.zero),
                    padding: const EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      onChanged: (value) {
                        address = value;
                      },
                      decoration: InputDecoration(labelText: "Address"),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    decoration: cardDecoration.copyWith(
                        borderRadius: BorderRadius.zero),
                    padding: const EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      onChanged: (value) {
                        city = value;
                      },
                      decoration: InputDecoration(labelText: "City"),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    decoration: cardDecoration.copyWith(
                        borderRadius: BorderRadius.zero),
                    padding: const EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      onChanged: (value) {
                        state = value;
                      },
                      decoration:
                          InputDecoration(labelText: "State/Province/Region"),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    decoration: cardDecoration.copyWith(
                        borderRadius: BorderRadius.zero),
                    padding: const EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        zip = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Zip Code",
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: LoginColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                        child: Text(
                      "Add Address",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                  ),
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('User')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('Address')
                        .doc()
                        .set({
                      'name': name,
                      'number': number,
                      'address': address,
                      'zip': zip,
                      'state': state,
                      'city': city,
                      'isSelected':false,
                    });
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shipping Addresses",
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
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('User')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('Address')
                .snapshots(),
            builder: (context, snapshot) {
              var data = snapshot.data!.docs;
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              if(snapshot.data!.docs.length==0)
                return Center(child: Text("No Addresses Found",style: LoginFontStyle.copyWith(fontSize: 20,color: LoginColor),));
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: cardDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data[index]['name'],
                              style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                                onTap: (){
                                  FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection('Address').doc(data[index].id).delete();
                                },
                                child: Icon(FontAwesomeIcons.trash,color: Colors.red,))
                          ],
                        ),
                        Text(
                          data[index]['number'],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(data[index]['address'],style: TextStyle(
                          fontSize: 20,
                        ),),
                        Row(
                          children: [
                            Text("Use as primary address :"),
                            Checkbox(
                              value:data[index]['isSelected'], onChanged: (bool? value) {
                                for(int i=0 ; i<data.length ; ++i){
                                  FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection('Address').doc(data[i].id).update({
                                    'isSelected':false
                                  });
                                }
                              FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection('Address').doc(data[index].id).update({
                                'isSelected':value
                              });
                                Navigator.pop(context);
                            } ,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Address(add: true),
                    ),
                  );
                },
                child: Icon(FontAwesomeIcons.plus),
              ),
            ),
          )
        ],
      )
    );
  }
}
